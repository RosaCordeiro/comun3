HA$PBExportHeader$w_ge266_lote_devolucao_compra.srw
forward
global type w_ge266_lote_devolucao_compra from dc_w_sheet
end type
type tab_1 from tab within w_ge266_lote_devolucao_compra
end type
type tabpage_1 from userobject within tab_1
end type
type cb_inserir_volume from commandbutton within tabpage_1
end type
type cb_reabrir from commandbutton within tabpage_1
end type
type cb_resolver from commandbutton within tabpage_1
end type
type cb_fechar from commandbutton within tabpage_1
end type
type gb_2 from groupbox within tabpage_1
end type
type gb_1 from groupbox within tabpage_1
end type
type dw_1 from dc_uo_dw_base within tabpage_1
end type
type dw_2 from dc_uo_dw_base within tabpage_1
end type
type cb_incluir from commandbutton within tabpage_1
end type
type cb_alterar from commandbutton within tabpage_1
end type
type cb_cancelar from commandbutton within tabpage_1
end type
type gb_6 from groupbox within tabpage_1
end type
type dw_9 from dc_uo_dw_base within tabpage_1
end type
type tabpage_1 from userobject within tab_1
cb_inserir_volume cb_inserir_volume
cb_reabrir cb_reabrir
cb_resolver cb_resolver
cb_fechar cb_fechar
gb_2 gb_2
gb_1 gb_1
dw_1 dw_1
dw_2 dw_2
cb_incluir cb_incluir
cb_alterar cb_alterar
cb_cancelar cb_cancelar
gb_6 gb_6
dw_9 dw_9
end type
type tabpage_2 from userobject within tab_1
end type
type gb_3 from groupbox within tabpage_2
end type
type dw_3 from dc_uo_dw_base within tabpage_2
end type
type dw_8 from dc_uo_dw_base within tabpage_2
end type
type tabpage_2 from userobject within tab_1
gb_3 gb_3
dw_3 dw_3
dw_8 dw_8
end type
type tabpage_3 from userobject within tab_1
end type
type gb_4 from groupbox within tabpage_3
end type
type dw_4 from dc_uo_dw_base within tabpage_3
end type
type dw_6 from dc_uo_dw_base within tabpage_3
end type
type tabpage_3 from userobject within tab_1
gb_4 gb_4
dw_4 dw_4
dw_6 dw_6
end type
type tabpage_4 from userobject within tab_1
end type
type gb_5 from groupbox within tabpage_4
end type
type dw_5 from dc_uo_dw_base within tabpage_4
end type
type dw_7 from dc_uo_dw_base within tabpage_4
end type
type tabpage_4 from userobject within tab_1
gb_5 gb_5
dw_5 dw_5
dw_7 dw_7
end type
type tab_1 from tab within w_ge266_lote_devolucao_compra
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
end type
end forward

global type w_ge266_lote_devolucao_compra from dc_w_sheet
string accessiblename = "Devolu$$HEX2$$e700e300$$ENDHEX$$o de Produtos Vencidos para Fornecedor (GE266)"
integer width = 3529
integer height = 1912
string title = "GE266 - Lote de Devolu$$HEX2$$e700e300$$ENDHEX$$o de Compras"
long backcolor = 80269524
event ue_recuperar ( )
tab_1 tab_1
end type
global w_ge266_lote_devolucao_compra w_ge266_lote_devolucao_compra

type variables
uo_fornecedor ivo_fornecedor
uo_fornecedor ivo_forn
uo_produto ivo_produto
uo_usuario	ivo_Usuario

string ivs_valida_forn, ivs_situacao

long ivl_Linha_Selecionada

date ivdt_Movimento
end variables

forward prototypes
public function boolean wf_verifica_pendente ()
public subroutine wf_atualiza_valores ()
public function integer wf_verifica_produto_distribuidora (long al_produto, string as_fornecedor)
public function boolean wf_preco_reposicao (long al_produto, ref decimal adc_preco_reposicao)
public function boolean wf_atualiza_valor_lote (long al_lote)
public function boolean wf_situacao_lote (ref string as_situacao)
public function boolean wf_localiza_preco_reposicao (long al_produto, ref decimal adc_preco_reposicao, ref decimal adc_desconto_fornecedor)
public function boolean wf_atualiza_produto_lote (long al_lote, long al_produto, decimal adc_preco, decimal adc_desconto)
public function boolean wf_update_valor_lote (decimal adc_valor, long al_nr_lote)
public function boolean wf_responsavel (ref string as_matricula, string as_procedimento)
public function boolean wf_verifica_fornecedor_dev_compra (string as_fornecedor_usual, string as_fornecedor_lote)
end prototypes

event ue_recuperar();Tab_1.TabPage_1.dw_2.Event ue_Retrieve()
end event

public function boolean wf_verifica_pendente ();Long lvl_Modificado

Tab_1.TabPage_2.dw_3.AcceptText()

lvl_Modificado = Tab_1.TabPage_2.dw_3.ModifiedCount() + Tab_1.TabPage_2.dw_3.DeletedCount()
							 
If lvl_Modificado > 0 Then
	Return True
Else
	Return False
End If
end function

public subroutine wf_atualiza_valores ();Integer lvi_Linha,&
		lvi_Linhas,&
		lvi_Lote
		
Decimal lvdc_Valor
		
lvi_Linhas = Tab_1.TabPage_1.dw_2.RowCount()

For lvi_Linha = 1 To lvi_Linhas 
	
	lvi_Lote = Tab_1.TabPage_1.dw_2.Object.nr_lote[lvi_Linha]
	
	Select Sum(Round((l.qt_devolver * ( p.vl_preco_reposicao  * (1 - ( p.pc_desconto_fornecedor /100)))),2) )
	Into :lvdc_Valor
	From lote_devolucao_compra_produto l, 
		 produto_central p
	Where l.nr_lote =:lvi_Lote
  	  and p.cd_produto = l.cd_produto
	Using SqlCa;
	
	If SqlCa.Sqlcode = -1 Then
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do valor da devolu$$HEX2$$e700e300$$ENDHEX$$o")
		lvdc_Valor = 0
	End If
	
	If IsNull(lvdc_Valor) Then lvdc_Valor = 0
		
	Tab_1.TabPage_1.dw_2.Object.vl_devolucao[lvi_Linha] = lvdc_Valor
Next


end subroutine

public function integer wf_verifica_produto_distribuidora (long al_produto, string as_fornecedor);Integer lvi_Contador, lvi_Retorno = 0

Select count(id_situacao)
Into  :lvi_Contador
From distribuidora_produto
 Where cd_produto 			= :al_Produto
 And cd_distribuidora 			= :as_Fornecedor
And id_situacao				= 'A'
Using SqlCa;
			
If SqlCa.SqlCode <> -1 Then
	If lvi_Contador > 0 Then
		lvi_Retorno = lvi_Contador
	End If
Else
	SqlCa.of_MsgDbError("Erro ao localizar o produto  na distribuidora")
	lvi_Retorno = -1
End If
		
Return lvi_Retorno
end function

public function boolean wf_preco_reposicao (long al_produto, ref decimal adc_preco_reposicao);Select round(vl_preco_reposicao  * ((100 - pc_desconto_fornecedor) /100) , 2)
Into :adc_preco_reposicao
From	produto_central
Where cd_produto =:al_Produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If adc_Preco_Reposicao < 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O pre$$HEX1$$e700$$ENDHEX$$o de reposi$$HEX2$$e700e300$$ENDHEX$$o esta com o valor negativo.")
			Return False
		End If
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O pre$$HEX1$$e700$$ENDHEX$$o de reposi$$HEX2$$e700e300$$ENDHEX$$o do produto n$$HEX1$$e300$$ENDHEX$$o foi localizado.")
		Return False
	Case -1 
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do valor de reposi$$HEX2$$e700e300$$ENDHEX$$o do produto")
		Return False
End Choose

Return True
	

end function

public function boolean wf_atualiza_valor_lote (long al_lote);Decimal{2} lvdc_Valor_Lote

Tab_1.TabPage_2.dw_3.AcceptText()

lvdc_Valor_Lote = Tab_1.TabPage_2.dw_3.GetItemDecimal(Tab_1.TabPage_2.dw_3.RowCount(), "vl_preco_unitario_total")

Update lote_devolucao_compra
Set vl_lote =:lvdc_Valor_Lote
Where nr_lote =:al_Lote
Using SqlCa;

If  SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do valor do lote")
	SqlCa.of_Rollback();
	Return False
End If

Return True
end function

public function boolean wf_situacao_lote (ref string as_situacao);Long lvl_Lote

Tab_1.TabPage_1.dw_2.AcceptText()

lvl_Lote = Tab_1.TabPage_1.dw_2.Object.nr_lote[Tab_1.TabPage_1.dw_2.GetRow()]

Select id_situacao
Into :as_Situacao
From lote_devolucao_compra
Where nr_lote =:lvl_Lote
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		// Aberto
		If IsNull(as_Situacao) Then as_Situacao = 'A'
			
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O lote n$$HEX1$$e300$$ENDHEX$$o foi localizado.")
		Return False
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do lote.")
End Choose

Return True
end function

public function boolean wf_localiza_preco_reposicao (long al_produto, ref decimal adc_preco_reposicao, ref decimal adc_desconto_fornecedor);Select vl_preco_reposicao, pc_desconto_fornecedor
Into :adc_preco_reposicao,
	  :adc_desconto_fornecedor
From	produto_central
Where cd_produto =:al_Produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If adc_Preco_Reposicao < 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O pre$$HEX1$$e700$$ENDHEX$$o de reposi$$HEX2$$e700e300$$ENDHEX$$o esta com o valor negativo.")
			Return False
		End If
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O pre$$HEX1$$e700$$ENDHEX$$o de reposi$$HEX2$$e700e300$$ENDHEX$$o do produto n$$HEX1$$e300$$ENDHEX$$o foi localizado.")
		Return False
	Case -1 
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do valor de reposi$$HEX2$$e700e300$$ENDHEX$$o do produto")
		Return False
End Choose

Return True
	

end function

public function boolean wf_atualiza_produto_lote (long al_lote, long al_produto, decimal adc_preco, decimal adc_desconto);Update lote_devolucao_compra_produto
Set vl_preco = :adc_preco,
	 pc_desconto_fornecedor = :adc_desconto
where nr_lote = :al_lote
and cd_produto = :al_produto
Using SqlCa;

If  SqlCa.SqlCode = 0 Then
	//SqlCa.of_Commit()
	Return True
Else
	SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do produto do lote")
	SqlCa.of_Rollback();
	Return False
End If




end function

public function boolean wf_update_valor_lote (decimal adc_valor, long al_nr_lote);Update lote_devolucao_compra
Set 	  vl_lote =:adc_Valor
Where nr_lote =:al_Nr_Lote
Using SqlCa;

If  SqlCa.SqlCode <> 0 Then
	SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do valor total do lote")
	SqlCa.of_Rollback();
	Return False
Else
	//SqlCa.of_Commit();
	Return True
End If


end function

public function boolean wf_responsavel (ref string as_matricula, string as_procedimento);dc_uo_aplicacao lvo_Aplicacao

lvo_Aplicacao = Create dc_uo_aplicacao

lvo_Aplicacao.ivo_seguranca.cd_sistema = "CO"

If Not lvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento(as_procedimento, ref as_matricula) Then 
	Destroy(lvo_Aplicacao)
	Return False
End If

Destroy(lvo_Aplicacao)

Return True
end function

public function boolean wf_verifica_fornecedor_dev_compra (string as_fornecedor_usual, string as_fornecedor_lote);String lvs_Fornecedor_Devolucao,&
		lvs_Fantasia

Select cd_fornecedor_dev_compra
Into :lvs_Fornecedor_Devolucao
From fornecedor
Where cd_fornecedor = :as_Fornecedor_Usual
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0	
		If Not IsNull(lvs_Fornecedor_Devolucao) And lvs_Fornecedor_Devolucao <> as_Fornecedor_Lote Then

			ivo_Fornecedor.of_Localiza_Codigo(lvs_Fornecedor_Devolucao)
		
			If ivo_Fornecedor.Localizado Then
				lvs_Fantasia = ivo_Fornecedor.nm_fantasia + " - (" + lvs_Fornecedor_Devolucao + ")"
			End If
				
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Este produto s$$HEX1$$f300$$ENDHEX$$ poder$$HEX1$$e100$$ENDHEX$$ ser devolvido para o fornecedor '" + lvs_Fantasia + "' .")
			Return False
		End If
		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O fornecedor usual para a devolu$$HEX2$$e700e300$$ENDHEX$$o de compra n$$HEX1$$e300$$ENDHEX$$o foi localizado.")
		Return False
		
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do fornecedor devolu$$HEX2$$e700e300$$ENDHEX$$o compra")
		Return False
End Choose

Return True

end function

on w_ge266_lote_devolucao_compra.create
int iCurrent
call super::create
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on w_ge266_lote_devolucao_compra.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_1)
end on

event close;call super::close;Destroy(ivo_fornecedor)
Destroy(ivo_produto)
Destroy(ivo_forn)
Destroy(ivo_Usuario)
end event

event ue_postopen;call super::ue_postopen;dc_uo_dw_Base lvo_Update[]
lvo_Update = {Tab_1.TabPage_2.dw_3}
This.wf_SetUpdate_DW(lvo_Update)

Tab_1.TabPage_1.dw_1.ivo_Controle_Menu.of_Recuperar(True)
Tab_1.TabPage_1.dw_2.ivo_Controle_Menu.of_Recuperar(True)

Tab_1.TabPage_2.dw_3.ivo_Controle_Menu.of_Incluir (True)

Tab_1.TabPage_2.dw_3.ivo_Controle_Menu.of_Imprimir(True)
Tab_1.TabPage_3.dw_4.ivo_Controle_Menu.of_Imprimir(True)
Tab_1.TabPage_4.dw_5.ivo_Controle_Menu.of_Imprimir(True)

Tab_1.TabPage_1.dw_2.ivo_Controle_Menu.of_SalvarComo(True)
Tab_1.TabPage_3.dw_4.ivo_Controle_Menu.of_SalvarComo(True)
Tab_1.TabPage_4.dw_5.ivo_Controle_Menu.of_SalvarComo(True)

This.ivm_Menu.ivb_Permite_Imprimir = True

ivo_fornecedor = Create uo_Fornecedor
ivo_produto    	= Create uo_produto
ivo_forn			= Create uo_Fornecedor
ivo_Usuario		= Create uo_Usuario

String lvds_Devolucao

Tab_1.TabPage_1.dw_9.Event ue_AddRow()

Tab_1.TabPage_1.dw_1.Reset()
Tab_1.TabPage_1.dw_1.Event ue_AddRow()

DataWindowChild lvdwc

Integer 	lvi_Retorno,&
        		lvi_Row

If Tab_1.TabPage_1.dw_1.GetChild("cd_motivo_devolucao", lvdwc) = 1 Then
	lvdwc.InsertRow(1)
	
	lvdwc.SetItem(1, "cd_motivo_devolucao", 0)
	lvdwc.SetItem(1, "de_motivo_devolucao", "TODOS")
	
	Tab_1.TabPage_1.dw_1.Object.cd_motivo_devolucao [1] = 0
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild do grupo.")
End If

Tab_1.TabPage_1.dw_1.SetFocus()

Tab_1.TabPage_1.dw_1.Object.dt_registro_de [1] = gvo_Parametro.of_DH_Movimentacao()
Tab_1.TabPage_1.dw_1.Object.dt_Registro_Ate[1] = gvo_Parametro.of_DH_Movimentacao()
Tab_1.TabPage_1.dw_1.Object.dt_devolucao   [1] = RelativeDate(Date(gvo_Parametro.of_DH_Movimentacao()), - 365)

ivdt_Movimento = Date(gvo_Parametro.of_DH_Movimentacao())






end event

event open;call super::open;Tab_1.TabPage_1.dw_1.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_1.dw_2.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_2.dw_3.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_3.dw_4.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_4.dw_5.of_SetMenu(This.ivm_Menu)


end event

type tab_1 from tab within w_ge266_lote_devolucao_compra
integer x = 5
integer width = 3461
integer height = 1712
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long backcolor = 80269524
boolean raggedright = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
end on

event selectionchanged;SetPointer(HourGlass!)

Choose Case NewIndex
	Case 1
		This.Width  = 3451
		Tab_1.TabPage_1.dw_1.SetFocus()
	Case 2
		This.Width  = 2597
		Tab_1.TabPage_2.dw_3.SetFocus()
	Case 3
		This.Width  = 3287		
	Case 4
		This.Width  = 3579
End Choose
	
Parent.Width  = This.Width  + 60
Parent.Height = This.Height + 150		

SetPointer(Arrow!)

end event

event selectionchanging;SetPointer(HourGlass!)

LONG lvl_Linha

lvl_Linha = Tab_1.TabPage_1.dw_2.GetRow()

If OldIndex = 1 Then
	ivl_Linha_Selecionada = Tab_1.TabPage_1.dw_2.GetRow()
End If

If NewIndex <> 2 Then
 	If wf_Valida_Salva() = -3 Then
		Return 1
	Else
		ivm_Menu.mf_Confirmar(False)
		ivm_Menu.mf_Cancelar (False)
   End If
End If

If NewIndex = 1 and OldIndex = 2 Then
	Tab_1.TabPage_1.dw_2.Object.vl_lote[lvl_Linha] = Tab_1.TabPage_2.dw_3.GetItemDecimal(Tab_1.TabPage_2.dw_3.RowCount(), "vl_preco_unitario_total")
	
	//Tab_1.TabPage_1.dw_2.Event ue_Retrieve()
	
	//If ivl_Linha_Selecionada > 0 Then
	//	Tab_1.TabPage_1.dw_2.SetRow(ivl_Linha_Selecionada)
	//End If
End If

If NewIndex = 2 Then
	If lvl_Linha > 0 Then
		
		If Not wf_Situacao_Lote(Ref ivs_situacao) Then
			// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
			Return 1
		End If
				
		// Par$$HEX1$$e200$$ENDHEX$$metro utilizado para validar se o produto realmente $$HEX1$$e900$$ENDHEX$$ do fornecedor informado no lote.
		// Este param$$HEX1$$ea00$$ENDHEX$$tro $$HEX1$$e900$$ENDHEX$$ muito importante principalmente para a Belocap que possui v$$HEX1$$e100$$ENDHEX$$rias divis$$HEX1$$f500$$ENDHEX$$es
		Tab_1.TabPage_1.dw_1.AcceptText()
		ivs_Valida_Forn = Tab_1.TabPage_1.dw_1.Object.id_valida_forn[1]
		
		// Executa o evento de recupera$$HEX2$$e700e300$$ENDHEX$$o das linhas das DW de detalhes
		Tab_1.TabPage_2.dw_3.Event ue_Retrieve()

		If ivs_situacao <> 'A' Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Somente o lote ABERTO poder$$HEX1$$e100$$ENDHEX$$ ser alterado.")
			Tab_1.TabPage_2.dw_3.Object.qt_devolver.Protect = 1
			Tab_1.TabPage_2.dw_3.ivo_Controle_Menu.of_Incluir (False)
			Tab_1.TabPage_2.dw_3.ivo_Controle_Menu.of_Excluir(False)
		Else
			Tab_1.TabPage_2.dw_3.Object.qt_devolver.Protect = 0
			Tab_1.TabPage_2.dw_3.Event ue_AddRow()
			Tab_1.TabPage_2.dw_3.ivo_Controle_Menu.of_Incluir (True)
			Tab_1.TabPage_2.dw_3.ivo_Controle_Menu.of_Excluir(True)
		End If		
	
		// Permite a troca do folder
		Return 0
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um lote da lista para visualizar ou incluir produtos no lote.", StopSign!, Ok!)
		// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
		Return 1
	End If
End If

If NewIndex = 3 Then
		
	If lvl_Linha > 0 Then
		
		// Executa o evento de recupera$$HEX2$$e700e300$$ENDHEX$$o das linhas das DW de detalhes
		Tab_1.TabPage_3.dw_4.Event ue_Retrieve()
		
		If Tab_1.TabPage_3.dw_4.RowCount() > 0 Then
			// Permite a troca do folder
			Return 0
		Else
			// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
			Return 1
		End If
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um lote da lista para visualizar a lista do compras.", StopSign!, Ok!)
		// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
		Return 1
	End If
End If

If NewIndex = 4 Then
	If lvl_Linha > 0 Then
		
		// Executa o evento de recupera$$HEX2$$e700e300$$ENDHEX$$o das linhas das DW de detalhes
		Tab_1.TabPage_4.dw_5.Event ue_Retrieve()
		
		If Tab_1.TabPage_4.dw_5.RowCount() > 0 Then
			// Permite a troca do folder
			Return 0
		Else
			// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
			Return 1
		End If
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um lote da lista para visualizar a lista do fiscal.", StopSign!, Ok!)
		// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
		Return 1
	End If
End If

SetPointer(Arrow!)
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3424
integer height = 1596
long backcolor = 80269524
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
cb_inserir_volume cb_inserir_volume
cb_reabrir cb_reabrir
cb_resolver cb_resolver
cb_fechar cb_fechar
gb_2 gb_2
gb_1 gb_1
dw_1 dw_1
dw_2 dw_2
cb_incluir cb_incluir
cb_alterar cb_alterar
cb_cancelar cb_cancelar
gb_6 gb_6
dw_9 dw_9
end type

on tabpage_1.create
this.cb_inserir_volume=create cb_inserir_volume
this.cb_reabrir=create cb_reabrir
this.cb_resolver=create cb_resolver
this.cb_fechar=create cb_fechar
this.gb_2=create gb_2
this.gb_1=create gb_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.cb_incluir=create cb_incluir
this.cb_alterar=create cb_alterar
this.cb_cancelar=create cb_cancelar
this.gb_6=create gb_6
this.dw_9=create dw_9
this.Control[]={this.cb_inserir_volume,&
this.cb_reabrir,&
this.cb_resolver,&
this.cb_fechar,&
this.gb_2,&
this.gb_1,&
this.dw_1,&
this.dw_2,&
this.cb_incluir,&
this.cb_alterar,&
this.cb_cancelar,&
this.gb_6,&
this.dw_9}
end on

on tabpage_1.destroy
destroy(this.cb_inserir_volume)
destroy(this.cb_reabrir)
destroy(this.cb_resolver)
destroy(this.cb_fechar)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.cb_incluir)
destroy(this.cb_alterar)
destroy(this.cb_cancelar)
destroy(this.gb_6)
destroy(this.dw_9)
end on

type cb_inserir_volume from commandbutton within tabpage_1
integer x = 512
integer y = 1472
integer width = 645
integer height = 100
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Incluir/Alterar Volume"
end type

event clicked;Long lvl_Lote

String lvs_Situacao

If Tab_1.TabPage_1.dw_2.RowCount() > 0 Then

	Tab_1.TabPage_1.dw_2.AcceptText()
	
	lvl_Lote = Tab_1.TabPage_1.dw_2.Object.nr_lote[ Tab_1.TabPage_1.dw_2.GetRow() ]
	
	If Not wf_Situacao_Lote(Ref lvs_Situacao) Then Return
		
	If lvs_Situacao = 'R' Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O lote j$$HEX1$$e100$$ENDHEX$$ foi RESOLVIDO. Recupere novamente as informa$$HEX2$$e700f500$$ENDHEX$$es.")
		Tab_1.TabPage_1.dw_2.SetFocus()
		Return
	ElseIf lvs_Situacao = 'X' Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O lote j$$HEX1$$e100$$ENDHEX$$ foi CANCELADO. Recupere novamente as informa$$HEX2$$e700f500$$ENDHEX$$es.")
		Tab_1.TabPage_1.dw_2.SetFocus()
		Return
	End If
		
	OpenWithParm( w_ge266_cadastro_volume, lvl_Lote )
	
	Tab_1.TabPage_1.dw_2.Event ue_Retrieve()

End If
end event

type cb_reabrir from commandbutton within tabpage_1
integer x = 9
integer y = 1472
integer width = 480
integer height = 100
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Reabrir Lote"
end type

event clicked;String lvs_Responsavel, lvs_Situacao

Long lvl_Lote, lvl_Produtos

If Tab_1.TabPage_1.dw_2.RowCount() = 0 Then Return

Tab_1.TabPage_1.dw_2.AcceptText()

If wf_Situacao_Lote(Ref lvs_Situacao) Then
	If lvs_Situacao = 'A' Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O lote j$$HEX1$$e100$$ENDHEX$$ esta aberto. Recupere novamente as informa$$HEX2$$e700f500$$ENDHEX$$es.")
		Tab_1.TabPage_1.dw_2.SetFocus()
		Return
	End If
Else
	Return
End If

lvl_Lote = Tab_1.TabPage_1.dw_2.Object.nr_lote[Tab_1.TabPage_1.dw_2.GetRow()]

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma reabertura do lote '" + String(lvl_Lote) + "' ?", Question!, YesNo!, 2) = 2 Then
	Return
End If	

If wf_Responsavel(Ref lvs_Responsavel, "CO108_ABRIR_LOTE_DEV_COMPRA") Then
		
	Update lote_devolucao_compra
	Set dh_registro = :ivdt_Movimento, id_situacao = 'A', dh_alteracao_situacao = getdate(), nr_matric_alteracao_situacao =:lvs_Responsavel
	Where nr_lote =:lvl_Lote
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o da situa$$HEX2$$e700e300$$ENDHEX$$o do lote.")
		Return 
	End If
	
	SqlCa.of_Commit();
	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O lote  '" + String(lvl_Lote) + "' foi aberto com sucesso.")
	
	Tab_1.TabPage_1.dw_2.Event ue_Retrieve()
	
End If
end event

type cb_resolver from commandbutton within tabpage_1
integer x = 1344
integer y = 1472
integer width = 402
integer height = 100
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "&Resolver"
end type

event clicked;String lvs_Responsavel, lvs_OBS, lvs_Situacao

Long lvl_Lote

If Tab_1.TabPage_1.dw_2.RowCount() = 0 Then Return

Tab_1.TabPage_1.dw_2.AcceptText()

lvl_Lote = Tab_1.TabPage_1.dw_2.Object.nr_lote[Tab_1.TabPage_1.dw_2.GetRow()]

If wf_Situacao_Lote(Ref lvs_Situacao) Then
	If lvs_Situacao <> 'F' Then
		If lvs_Situacao = 'R' Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O lote j$$HEX1$$e100$$ENDHEX$$ foi resolvido. Recupere novamente as informa$$HEX2$$e700f500$$ENDHEX$$es.")
			Tab_1.TabPage_1.dw_2.SetFocus()
			Return
		Else 
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Somente lote FECHADO pode ser RESOLVIDO.")
			Tab_1.TabPage_1.dw_2.SetFocus()
			Return
		End If
	End If
Else
	Return
End If

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a altera$$HEX2$$e700e300$$ENDHEX$$o da situ$$HEX2$$e700e300$$ENDHEX$$o do lote '" + String(lvl_Lote) + "' para resolvido ?", Question!, YesNo!, 2) = 2 Then
	Return
End If	

If wf_Responsavel(Ref lvs_Responsavel, "CO108_LIBERACAO_PROCEDIMENTO") Then
	
	Open(w_ge266_observacao)
	
	lvs_Obs = Message.StringParm
	
	If lvs_Obs = "" Then Return
	
	Update lote_devolucao_compra
	Set	id_situacao = 'R', 
			dh_alteracao_situacao = getdate(), 
			nr_matric_alteracao_situacao =:lvs_Responsavel, 
			de_observacao =:lvs_Obs,
			dh_registro = :ivdt_Movimento
	Where nr_lote =:lvl_Lote
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o da situa$$HEX2$$e700e300$$ENDHEX$$o do lote.")
		Return 
	End If
	
	SqlCa.of_Commit();
	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O lote  '" + String(lvl_Lote) + "' foi resolvido com sucesso.")
	
	Tab_1.TabPage_1.dw_2.Event ue_Retrieve()
End If
end event

type cb_fechar from commandbutton within tabpage_1
integer x = 1765
integer y = 1472
integer width = 402
integer height = 96
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "&Fechar"
end type

event clicked;String lvs_Responsavel, lvs_Situacao

Long lvl_Lote, lvl_Produtos

If Tab_1.TabPage_1.dw_2.RowCount() = 0 Then Return

Tab_1.TabPage_1.dw_2.AcceptText()

If wf_Situacao_Lote(Ref lvs_Situacao) Then
	If lvs_Situacao <> 'A' Then
		If lvs_Situacao = 'F' Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O lote j$$HEX1$$e100$$ENDHEX$$ foi fechado. Recupere novamente as informa$$HEX2$$e700f500$$ENDHEX$$es.")
			Tab_1.TabPage_1.dw_2.SetFocus()
			Return
		Else 
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Somente lote ABERTO pode ser FECHADO.")
			Tab_1.TabPage_1.dw_2.SetFocus()
			Return
		End If
	End If
Else
	Return
End If

lvl_Lote = Tab_1.TabPage_1.dw_2.Object.nr_lote[Tab_1.TabPage_1.dw_2.GetRow()]

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma o fechamento do lote '" + String(lvl_Lote) + "' ?", Question!, YesNo!, 2) = 2 Then
	Return
End If	

Select count(cd_produto)
Into :lvl_Produtos
From lote_devolucao_compra_produto
Where nr_lote =:lvl_Lote
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	Sqlca.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o dos produtos do lote.")
	Return
End If

If lvl_Produtos = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existe produto informado para o lote '" + String(lvl_Lote) + "'.", StopSign!)
	Return 
End If

If wf_Responsavel(Ref lvs_Responsavel, "CO108_LIBERACAO_PROCEDIMENTO") Then
		
	Update lote_devolucao_compra
	Set dh_registro = :ivdt_Movimento, id_situacao = 'F', dh_alteracao_situacao = getdate(), nr_matric_alteracao_situacao =:lvs_Responsavel
	Where nr_lote =:lvl_Lote
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o da situa$$HEX2$$e700e300$$ENDHEX$$o do lote.")
		Return 
	End If
	
	SqlCa.of_Commit();
	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O lote  '" + String(lvl_Lote) + "' foi fechado com sucesso.")
	
	Tab_1.TabPage_1.dw_2.Event ue_Retrieve()
	
End If
end event

type gb_2 from groupbox within tabpage_1
integer x = 9
integer y = 356
integer width = 3374
integer height = 748
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Lista de Lotes"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within tabpage_1
integer x = 9
integer y = 12
integer width = 3374
integer height = 332
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
borderstyle borderstyle = styleraised!
end type

type dw_1 from dc_uo_dw_base within tabpage_1
integer x = 37
integer y = 72
integer width = 3323
integer height = 260
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge266_parametro"
end type

event ue_key;String lvs_Nulo

If Key = KeyEnter! Then
	
	If This.GetColumnName() = "nm_comprador" Then
		ivo_Usuario.of_Localiza_Usuario(This.GetText())
		
		If ivo_Usuario.Localizado Then
			This.Object.nr_matricula_comprador	[1] = ivo_Usuario.nr_matricula
			This.Object.nm_comprador				[1] = ivo_Usuario.nm_usuario
		End If
	End If
	
	If This.GetColumnName() = 'nm_fantasia' Then
		ivo_Fornecedor.of_Localiza_Fornecedor(dw_1.GetText())
	
		If ivo_Fornecedor.Localizado Then
			dw_1.Object.cd_fornecedor[1] = ivo_Fornecedor.cd_fornecedor
			dw_1.Object.nm_fantasia  [1] = ivo_Fornecedor.Nm_Razao_Social
		Else
			SetNull(lvs_Nulo)
					
			dw_1.Object.cd_fornecedor[1] = lvs_Nulo
			dw_1.Object.nm_fantasia  [1] = lvs_Nulo
		End If
	End If
	
End If



end event

event itemchanged;call super::itemchanged;//If dwo.name = 'nm_fantasia'    or &
//	dwo.name = 'nr_lote'        or &
//	dwo.name = 'dt_registro_de' or &
//	dwo.name = 'dt_registro_ate' Then
//	Tab_1.TabPage_1.dw_2.Reset()
//End If

If dwo.name <> 'dt_devolucao' and dwo.name <> 'id_valida_forn' Then
	Tab_1.TabPage_1.dw_2.Reset()
End If

If dwo.Name = 'nm_fantasia' Then
	If Not IsNull(data) and Trim(data) <> "" Then
		If data <> ivo_Fornecedor.Nm_Razao_Social Then
			Return 1
		End If
	Else
		ivo_Fornecedor.of_Inicializa()
	
		This.Object.cd_fornecedor[1] = ivo_Fornecedor.cd_fornecedor
		This.Object.nm_fantasia  [1] = ivo_Fornecedor.nm_razao_social
	End If
End If

If dwo.Name = "nm_comprador" Then
	If Not IsNull(Data) and Trim(Data) <> "" Then
		If Data <> ivo_Usuario.nm_usuario Then
			Return 1
		End If
	Else
		ivo_Usuario.of_Inicializa()
		
		This.Object.nr_matricula_comprador	[1] = ivo_Usuario.nr_matricula
		This.Object.nm_comprador				[1] = ivo_Usuario.nm_usuario
	End If
End If


end event

event losefocus;call super::losefocus;If IsValid(ivo_Fornecedor) Then
	This.Object.Cd_Fornecedor[1] = ivo_Fornecedor.Cd_Fornecedor
	This.Object.Nm_Fantasia  [1] = ivo_Fornecedor.Nm_Razao_Social
End If

If IsValid(ivo_Usuario) Then
	This.Object.nr_matricula_comprador	[1] = ivo_Usuario.nr_matricula
	This.Object.nm_comprador				[1] = ivo_Usuario.nm_usuario
End If
end event

event constructor;call super::constructor;This.of_SetColSelection(True)


end event

event ue_recuperar;// OverRide

Tab_1.TabPage_1.dw_2.Event ue_Retrieve()

Return 1
end event

event getfocus;call super::getfocus;dw_2.ivo_Controle_Menu.of_Atualiza()



end event

event editchanged;call super::editchanged;Date ldt_Null

Long ll_Null

SetNull( ldt_Null )
SetNull( ll_Null )

If dwo.name <> 'dt_devolucao' and dwo.name <> 'id_valida_forn' Then
	Tab_1.TabPage_1.dw_2.Reset()
	
	Tab_1.TabPage_1.dw_9.Object.nr_matricula_responsavel		[1] = ""
	Tab_1.TabPage_1.dw_9.Object.nm_responsavel					[1] = ""
	Tab_1.TabPage_1.dw_9.Object.dh_alteracao							[1] = ldt_Null
	Tab_1.TabPage_1.dw_9.Object.nr_matric_alteracao_situacao	[1] = ""
	Tab_1.TabPage_1.dw_9.Object.nm_usuario_alteracao			[1] = ""
	Tab_1.TabPage_1.dw_9.Object.de_observacao						[1] = ""
	Tab_1.TabPage_1.dw_9.Object.nr_matricula_comprador			[1] = ""
	Tab_1.TabPage_1.dw_9.Object.nm_usuario_comprador			[1] = ""
	Tab_1.TabPage_1.dw_9.Object.de_motivo_devolucao				[1] = ""
	Tab_1.TabPage_1.dw_9.Object.nr_volume								[1] = ll_Null
	
End If

ivw_ParentWindow.ivb_Valida_Salva = False
end event

type dw_2 from dc_uo_dw_base within tabpage_1
integer x = 41
integer y = 412
integer width = 3323
integer height = 672
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge266_lista_lote"
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event ue_recuperar;// OverRide

Long lvl_Lote, lvl_Linha

Long ll_Motivo_Devolucao

DateTime lvdt_Registro_de,  &
			lvdt_Registro_ate, &
			lvdt_Devolucao

String	lvs_Fornecedor,&
		lvs_Situacao,&
		lvs_Comprador

Tab_1.TabPage_1.dw_1.AcceptText()

lvl_Lote          			= Tab_1.TabPage_1.dw_1.Object.nr_lote        					[1]
lvs_Fornecedor    		= Tab_1.TabPage_1.dw_1.Object.cd_fornecedor  				[1]
lvdt_Registro_de  		= Tab_1.TabPage_1.dw_1.Object.dt_registro_de 				[1]
lvdt_Registro_ate 		= Tab_1.TabPage_1.dw_1.Object.dt_registro_ate				[1]
lvdt_Devolucao    		= Tab_1.TabPage_1.dw_1.Object.dt_devolucao   				[1]
lvs_Situacao				= Tab_1.TabPage_1.dw_1.Object.id_situacao   				[1]
lvs_Comprador			= Tab_1.TabPage_1.dw_1.Object.nr_matricula_comprador	[1]
ll_Motivo_Devolucao	= Tab_1.TabPage_1.dw_1.Object.cd_motivo_devolucao		[1]

lvl_Linha 				=  Tab_1.TabPage_1.dw_1.getrow()

If IsNull(lvdt_Registro_de) or Not IsDate(String(lvdt_Registro_de, "dd/mm/yyyy"))Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio corretamente.", Information!)
	dw_1.SetFocus()
	dw_1.Event ue_Pos(1, "dt_registro_de")
	Return -1
End If 

If IsNull(lvdt_Registro_ate) or Not IsDate(String(lvdt_Registro_ate, "dd/mm/yyyy")) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino corretamente.", Information!)
	Tab_1.TabPage_1.dw_1.SetFocus()
	Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "dt_registro_ate")
	Return -1
End If 

If lvdt_Registro_de > lvdt_Registro_ate Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio deve ser menor ou igual a de t$$HEX1$$e900$$ENDHEX$$rmino.", Information!)
	Tab_1.TabPage_1.dw_1.SetFocus()
	Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "dt_registro_de")
	Return -1
End If 

If IsNull(lvdt_Devolucao) or Not IsDate(String(lvdt_Devolucao, "dd/mm/yyyy"))Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de emiss$$HEX1$$e300$$ENDHEX$$o das notas fiscais de compras corretamente.", Information!)
	Tab_1.TabPage_1.dw_1.SetFocus()
	Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "dt_devolucao")
	Return -1
End If

If Not IsNull(lvl_Lote) or lvl_Lote > 0 Then 
	Tab_1.TabPage_1.dw_2.of_AppendWhere("l.nr_lote = " + String(lvl_Lote))
End If

If Not IsNull(lvs_Fornecedor) Then
	Tab_1.TabPage_1.dw_2.of_AppendWhere("l.cd_fornecedor = '" + lvs_Fornecedor + "'")
End If

If lvs_Situacao <> 'T' Then
	Tab_1.TabPage_1.dw_2.of_AppendWhere("l.id_situacao = '" + lvs_Situacao + "'")
End If

If Not IsNull(lvs_Comprador) and lvs_Comprador <> '' Then
	Tab_1.TabPage_1.dw_2.of_AppendWhere("f.nr_matricula_comprador = '" + lvs_Comprador + "'")
End If

If ll_Motivo_Devolucao <> 0 Then
	Tab_1.TabPage_1.dw_2.of_AppendWhere("l.cd_motivo_devolucao = " + String( ll_Motivo_Devolucao ) )
End If

Return This.Retrieve(lvdt_Registro_de, lvdt_Registro_ate)
end event

event constructor;call super::constructor;//This.of_SetRowSelection()

This.of_SetRowSelection("", "if( id_situacao  = ~"X~", RGB(255,0, 0), RGB(0,0,0))")
This.of_SetSort()
This.of_SetFilter()
end event

event getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

event ue_postretrieve;Boolean lvb_Sucesso = False

Long lvl_Linha,&
		lvl_Lote,&
		lvl_Produto,&
		lvl_Linha_DS,&
		lvl_Qt_Devolvida
		
Decimal lvdc_Valor_Reposicao,&
			lvdc_Desconto,&
			lvdc_Total_Lote

String lvs_Situacao

If pl_Linhas > 0 Then
	
	cb_inserir_volume.Enabled = True
	
	SetRedRaw(False)
	
	Open(w_aguarde)
	w_aguarde.title = "Atualizando valores dos lotes..."
	w_aguarde.uo_progress.Of_SetMax(pl_Linhas)
	
  	For lvl_Linha = 1 To pl_Linhas //Dw_2
		
		w_aguarde.uo_progress.Of_SetProgress(lvl_Linha)
		
		lvs_Situacao = Tab_1.TabPage_1.dw_2.Object.id_situacao	[lvl_Linha]
		
		If lvs_Situacao = 'A' Then
			
			lvb_Sucesso = False
			
			lvdc_Total_Lote = 0.00
			
			lvl_Lote = Tab_1.TabPage_1.dw_2.Object.nr_lote	[lvl_Linha]
			
			dc_uo_ds_base lvds_produto
			lvds_produto = Create dc_uo_ds_base
			
			If Not lvds_Produto.of_ChangeDataObject("ds_ge266_produto_lote") Then Return -1
																  
			lvds_Produto.Retrieve(lvl_Lote)
			
			If lvds_Produto.RowCount() > 0 Then
				
				For lvl_Linha_DS = 1 To lvds_Produto.RowCount() //DataStore
					
					lvl_Produto 			= lvds_Produto.Object.cd_produto		[lvl_Linha_DS]
					lvl_Qt_Devolvida	= lvds_Produto.Object.qt_devolver		[lvl_Linha_DS]
					
					If wf_localiza_preco_reposicao(lvl_Produto, Ref lvdc_Valor_Reposicao, Ref lvdc_Desconto) Then 
					
						If wf_atualiza_produto_lote(lvl_Lote, lvl_Produto, lvdc_Valor_Reposicao, lvdc_Desconto) Then
						
							//lvdc_Total_Lote	 += Round((lvdc_Valor_Reposicao - ((lvdc_Valor_Reposicao * lvdc_Desconto ) /100)) * lvl_Qt_Devolvida , 2)
							
							lvdc_Total_Lote	 +=  round(lvl_Qt_Devolvida * round(lvdc_Valor_Reposicao * ((100 - lvdc_Desconto) / 100), 2), 2)
														
							lvb_Sucesso = True
							
						End If
						
					End If
					
					If Not lvb_Sucesso Then Exit
					
				Next // Itens Produto Lote DataStore
			
			Else
				If lvds_Produto.RowCount() = 0 Then lvb_Sucesso = True
			End If // DataStore > 0
									
			If lvb_Sucesso Then
				If wf_Update_Valor_Lote(lvdc_Total_Lote, lvl_Lote) Then 
					Tab_1.TabPage_1.dw_2.Object.vl_lote	[lvl_Linha] = lvdc_Total_Lote
					SqlCa.of_Commit();
				Else
					Return -1
				End If
			End If
		
			Destroy(lvds_Produto)
					
		End If // Situa$$HEX2$$e700e300$$ENDHEX$$o 'A'
		
	Next // Situa$$HEX2$$e700e300$$ENDHEX$$o 'A' Dw_2
	
	//wf_Atualiza_Valores()
	
	Close(w_aguarde)
	
	SetRedRaw(True)
	
	This.Event RowFocusChanged(1)
	This.SetRow(1)
	This.SetFocus()
Else
	If pl_Linhas = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!)
	End If
	
	cb_inserir_volume.Enabled = False
	
End If

This.ivo_Controle_Menu.of_Imprimir(False)

Return pl_Linhas



end event

event rowfocuschanged;call super::rowfocuschanged;String lvs_Situacao

If currentrow > 0 Then
	
	cb_alterar.Enabled 				= False
	cb_cancelar.Enabled 			= False
	cb_fechar.Enabled 				= False
	cb_resolver.Enabled 			= False
	cb_inserir_volume.Enabled 	= False
	
	lvs_Situacao = This.Object.id_situacao[currentrow]
	
	// ABERTO
	If lvs_Situacao = 'A' Then
		cb_alterar.Enabled 				= True
		cb_cancelar.Enabled 			= True
		cb_fechar.Enabled 				= True
		cb_inserir_volume.Enabled 	= True
	End If
	
	If lvs_Situacao = 'A' Then
		cb_reabrir.Enabled	= False
	Else
		cb_reabrir.Enabled	= True
	End If
	
	// FECHADO
	If lvs_Situacao = 'F' Then
		cb_cancelar.Enabled 			= True
		cb_resolver.Enabled 			= True
		cb_inserir_volume.Enabled 	= True
	End If
	
	Tab_1.TabPage_1.dw_9.Object.nr_matricula_responsavel		[1] = This.Object.nr_matricula_responsavel			[currentrow]
	Tab_1.TabPage_1.dw_9.Object.nm_responsavel					[1] = This.Object.nm_usuario							[currentrow]
	Tab_1.TabPage_1.dw_9.Object.dh_alteracao						[1] = This.Object.dh_alteracao_situacao				[currentrow]
	Tab_1.TabPage_1.dw_9.Object.nr_matric_alteracao_situacao	[1] = This.Object.nr_matric_alteracao_situacao	[currentrow]
	Tab_1.TabPage_1.dw_9.Object.nm_usuario_alteracao			[1] = This.Object.nm_usuario_alteracao				[currentrow]
	Tab_1.TabPage_1.dw_9.Object.de_observacao					[1] = This.Object.de_observacao						[currentrow]
	Tab_1.TabPage_1.dw_9.Object.nr_matricula_comprador		[1] = This.Object.nr_matricula_comprador			[currentrow]
	Tab_1.TabPage_1.dw_9.Object.nm_usuario_comprador			[1] = This.Object.nm_usuario_comprador			[currentrow]
	Tab_1.TabPage_1.dw_9.Object.de_motivo_devolucao			[1] = This.Object.de_motivo_devolucao				[currentrow]
	Tab_1.TabPage_1.dw_9.Object.nr_volume							[1] = This.Object.nr_volume							[currentrow]
	
End If
end event

type cb_incluir from commandbutton within tabpage_1
integer x = 2336
integer y = 1472
integer width = 311
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Incluir "
end type

event clicked;Long lvl_Lote

SetNull(lvl_Lote)

OpenWithParm(w_ge266_Cadastro_Lote, lvl_Lote)

Tab_1.TabPage_1.dw_2.Event ue_Retrieve()
end event

type cb_alterar from commandbutton within tabpage_1
integer x = 2665
integer y = 1472
integer width = 311
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "&Alterar"
end type

event clicked;Long lvl_Lote

String lvs_Situacao

If Tab_1.TabPage_1.dw_2.RowCount() = 0 Then Return

Tab_1.TabPage_1.dw_2.AcceptText()

lvl_Lote = Tab_1.TabPage_1.dw_2.Object.nr_lote[Tab_1.TabPage_1.dw_2.GetRow()]

If Not wf_Situacao_Lote(Ref lvs_Situacao) Then Return

If lvs_Situacao <> 'A' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Somente lote ABERTO pode ser ALTERADO. Recupere novamente as informa$$HEX2$$e700f500$$ENDHEX$$es.")
	Tab_1.TabPage_1.dw_2.SetFocus()
	Return
End If

OpenWithParm(w_ge266_Cadastro_Lote, lvl_Lote)

Tab_1.TabPage_1.dw_2.Event ue_Retrieve()
end event

type cb_cancelar from commandbutton within tabpage_1
integer x = 3067
integer y = 1472
integer width = 325
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "&Cancelar"
end type

event clicked;String lvs_Responsavel, lvs_OBS, lvs_Situacao

Long lvl_Lote

If Tab_1.TabPage_1.dw_2.RowCount() = 0 Then Return

Tab_1.TabPage_1.dw_2.AcceptText()

lvl_Lote = Tab_1.TabPage_1.dw_2.Object.nr_lote[Tab_1.TabPage_1.dw_2.GetRow()]

If Not wf_Situacao_Lote(Ref lvs_Situacao) Then Return

If lvs_Situacao = 'X' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O lote j$$HEX1$$e100$$ENDHEX$$ foi CANCELADO. Recupere novamente as informa$$HEX2$$e700f500$$ENDHEX$$es.")
	Tab_1.TabPage_1.dw_2.SetFocus()
	Return
Else 
	If lvs_Situacao = 'R' Then
		
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O lote j$$HEX1$$e100$$ENDHEX$$ foi RESOLVIDO e n$$HEX1$$e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ ser cancelado.")
		Tab_1.TabPage_1.dw_2.SetFocus()
		Return
		
//		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O lote '" + String(lvl_Lote) + "' j$$HEX1$$e100$$ENDHEX$$ foi RESOLVIDO.~r~r" +&
//							"Confirma o canlamento mesmo assim ?", Question!, YesNo!, 2) = 2 Then
//			Return
//		End If	
	Else
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma o cancelamento do lote '" + String(lvl_Lote) +&
							"' ?", Question!, YesNo!, 2) = 2 Then
			Return
		End If	
	End If
End If

If wf_Responsavel(Ref lvs_Responsavel, "CO108_LIBERACAO_PROCEDIMENTO") Then
	
	Open(w_ge266_observacao)
	
	lvs_Obs = Message.StringParm
	
	If lvs_Obs = "" Then Return
	
	Update lote_devolucao_compra
	Set	id_situacao = 'X', 
			dh_alteracao_situacao = getdate(), 
			nr_matric_alteracao_situacao =:lvs_Responsavel, 
			de_observacao =:lvs_Obs
	Where nr_lote =:lvl_Lote
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o da situa$$HEX2$$e700e300$$ENDHEX$$o do lote.")
		Return 
	End If
	
	SqlCa.of_Commit();
	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O lote  '" + String(lvl_Lote) + "' foi cancelado com sucesso.")
	
	Tab_1.TabPage_1.dw_2.Event ue_Retrieve()
End If

end event

type gb_6 from groupbox within tabpage_1
integer x = 9
integer y = 1108
integer width = 3374
integer height = 344
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Detalhes"
borderstyle borderstyle = styleraised!
end type

type dw_9 from dc_uo_dw_base within tabpage_1
integer x = 41
integer y = 1180
integer width = 3278
integer height = 236
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_ge266_detalhe_lote"
end type

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3424
integer height = 1596
long backcolor = 80269524
string text = "Lista de Produtos para Devolu$$HEX2$$e700e300$$ENDHEX$$o"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
gb_3 gb_3
dw_3 dw_3
dw_8 dw_8
end type

on tabpage_2.create
this.gb_3=create gb_3
this.dw_3=create dw_3
this.dw_8=create dw_8
this.Control[]={this.gb_3,&
this.dw_3,&
this.dw_8}
end on

on tabpage_2.destroy
destroy(this.gb_3)
destroy(this.dw_3)
destroy(this.dw_8)
end on

type gb_3 from groupbox within tabpage_2
integer x = 9
integer y = 12
integer width = 2505
integer height = 1536
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Lista de Produtos"
borderstyle borderstyle = styleraised!
end type

type dw_3 from dc_uo_dw_base within tabpage_2
integer x = 27
integer y = 68
integer width = 2446
integer height = 1440
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge266_lista_produto"
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event ue_recuperar;// OverRide

Long lvl_Lote

Tab_1.TabPage_1.dw_2.AcceptText()

lvl_Lote = Tab_1.TabPage_1.dw_2.Object.nr_lote[Tab_1.TabPage_1.dw_2.GetRow()]

Return This.Retrieve(lvl_Lote)

end event

event ue_postretrieve;Long lvl_Linha

For lvl_Linha = 1 To This.RowCount()
	Tab_1.TabPage_2.dw_3.Object.nm_produto[lvl_Linha] = Tab_1.TabPage_2.dw_3.Object.de_produto[lvl_Linha] + " : " +&
																		 Tab_1.TabPage_2.dw_3.Object.de_apresentacao_estoque[lvl_Linha]
	
Next

// Ap$$HEX1$$f300$$ENDHEX$$s o retrieve a DW j$$HEX1$$e100$$ENDHEX$$ vem modificada, essa fun$$HEX2$$e700e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ para n$$HEX1$$e300$$ENDHEX$$o vir modificada
This.ResetUpdate()

Return 1
end event

event ue_key;Long lvl_Find, &
	  lvl_Linha, &
	  lvl_Qtde_Produto
	  
String lvs_Nulo,&
	  lvs_Fornecedor,&
	  lvs_Id_Distribuidora,&
	  lvs_Situacao,lvs_Fornecedor_Usual
	  
Decimal 	lvdc_Preco_Reposicao,&
			lvdc_Desconto_Fornecedor

Integer lvi_Retorno
		 
Tab_1.TabPage_1.dw_2.AcceptText()

lvs_Fornecedor 		= Tab_1.TabPage_1.dw_2.Object.cd_fornecedor	[Tab_1.TabPage_1.dw_2.GetRow()]
lvs_Id_Distribuidora 	= Tab_1.TabPage_1.dw_2.Object.id_distribuidora	[Tab_1.TabPage_1.dw_2.GetRow()]


If key = KeyEnter! Then
	If This.GetColumnName() = "nm_produto" Then
		
		ivo_Produto.of_Localiza_Produto(This.GetText())
		
		If ivo_Produto.Localizado Then
			
			lvl_Linha = Tab_1.TabPage_2.dw_3.GetRow()
			
			/*Valida$$HEX2$$e700e300$$ENDHEX$$o Projeto 154
			Lotes da GAM s$$HEX1$$f300$$ENDHEX$$ porder$$HEX1$$e100$$ENDHEX$$ ter produtos liberados para a dev. Compra
			*/
			If lvs_Fornecedor = '053400528' Then
				
				lvs_Fornecedor_Usual = ivo_Produto.cd_fornecedor_usual
				
				If Not wf_Verifica_Fornecedor_Dev_Compra(lvs_Fornecedor_Usual, lvs_Fornecedor) Then	
					Return -1
				End If
			
			End If
				
			If ivs_Valida_Forn = "S" Then
				If lvs_Fornecedor <> ivo_Produto.Cd_Fornecedor_Usual Then
					ivo_Forn.of_Localiza_Fornecedor(ivo_Produto.Cd_Fornecedor_Usual)
								
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto '" + ivo_Produto.ivs_Descricao_Apresentacao_Estoque + " (" + String(ivo_Produto.cd_produto) + ")'  n$$HEX1$$e300$$ENDHEX$$o pertence ao fornecedor informado no lote.~r~r" + &
												"O fornecedor correto do produto $$HEX1$$e900$$ENDHEX$$ '" + ivo_Forn.nm_razao_social + " (" + ivo_Produto.Cd_Fornecedor_Usual + ")'.", Information!)
					SetNull(lvs_Nulo)
					Tab_1.TabPage_2.dw_3.Object.nm_Produto  [lvl_Linha] = lvs_Nulo
					Return 
				End If
			End If
					
			//Verifica Produto Ativo na Distribuidora
			If lvs_Id_Distribuidora = "S" Then
				
				lvi_Retorno = wf_Verifica_Produto_Distribuidora(ivo_Produto.cd_produto,lvs_Fornecedor)
				
				If  lvi_Retorno = 0 Then
					//n$$HEX1$$e300$$ENDHEX$$o tem
					//incluir mesmo assim
					If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O produto : " + ivo_Produto.ivs_Descricao_Apresentacao_Estoque + " (" + String(ivo_Produto.cd_Produto) + ")" + " n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ relacionado com a distribuidora selecionada. ~r~r" + &
									"Deseja inclu$$HEX1$$ed00$$ENDHEX$$-lo mesmo assim?.",Question!, yesNo!, 2) = 2 Then
						Return -1
					End If
				Else
					If lvi_Retorno = -1 Then
						Return -1
					End If
				End If
						
			End If
			//		
			
			lvl_Find = Tab_1.TabPage_2.dw_3.Find("cd_produto = " + String(ivo_Produto.cd_produto), 1, This.RowCount())
			
			If lvl_Find = -1 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar no lote de devolu$$HEX2$$e700e300$$ENDHEX$$o de compra.")
				Return -1
			End If
			
			If lvl_Find > 0 Then
				
				Tab_1.TabPage_2.dw_3.Object.qt_devolver [lvl_Find]  		= Tab_1.TabPage_2.dw_3.Object.qt_devolver[lvl_Find] + 1
				
				SetNull(lvs_Nulo)
				Tab_1.TabPage_2.dw_3.Object.nm_Produto  [lvl_Linha] 	= lvs_Nulo
			Else
				Tab_1.TabPage_2.dw_3.Object.cd_Produto              				[lvl_Linha] = ivo_Produto.cd_produto
				Tab_1.TabPage_2.dw_3.Object.nm_Produto              			[lvl_Linha] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
				Tab_1.TabPage_2.dw_3.Object.cd_unidade_medida_compra	[lvl_Linha] = ivo_Produto.cd_unidade_medida_compra
				
				Tab_1.TabPage_2.dw_3.Object.qt_devolver							[lvl_Linha] = 1
				
				If wf_Localiza_Preco_Reposicao(ivo_Produto.cd_produto, Ref lvdc_Preco_Reposicao, Ref lvdc_Desconto_Fornecedor) Then
					Tab_1.TabPage_2.dw_3.Object.vl_preco						[lvl_Linha] = lvdc_Preco_Reposicao
					Tab_1.TabPage_2.dw_3.Object.pc_desconto_fornecedor[lvl_Linha] = lvdc_Desconto_Fornecedor
				Else
					Return -1
				End If
										
				This.Event ue_AddRow()
			End If	
		End If
	End If
	
	If This.GetColumnName() = "qt_devolver" Then
		If IsNull(This.Object.cd_produto[This.RowCount()]) Then
			This.Event ue_Pos(This.RowCount(), "nm_produto")
		Else
	   	This.Event ue_AddRow()
		End If
	End If
End If
end event

event ue_preinsertrow;call super::ue_preinsertrow;If This.RowCount() > 0 Then
//	If ivs_Situacao <> 'A' Then
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A inclus$$HEX1$$e300$$ENDHEX$$o de produto so $$HEX1$$e900$$ENDHEX$$ permitida em lote ABERTO.")
//		Return -1
//	Else
		If IsNull(Tab_1.TabPage_2.dw_3.Object.cd_produto[This.RowCount()]) Then Return -1
//	End If
End If

Return 1
end event

event editchanged;call super::editchanged;If Not This.of_Coluna_Sem_Validacao_Salva(dwo.Name) Then
	ivm_Menu.mf_Confirmar(True)
	ivm_Menu.mf_Cancelar(True)
End If

end event

event itemchanged;call super::itemchanged;If Not This.of_Coluna_Sem_Validacao_Salva(dwo.Name) Then
	ivm_Menu.mf_Confirmar(True)
	ivm_Menu.mf_Cancelar(True)
End If

end event

event ue_preupdate;call super::ue_preupdate;Long lvl_Lote,  &
	  lvl_Linha

Tab_1.TabPage_1.dw_2.AcceptText()

lvl_Lote = Tab_1.TabPage_1.dw_2.Object.nr_lote[Tab_1.TabPage_1.dw_2.GetRow()]

If This.RowCount() > 0 Then
	
	If IsNull(This.Object.cd_produto[This.RowCount()]) Then
		This.DeleteRow(This.RowCount())
	End If
	
	For lvl_Linha = 1 To This.RowCount()
		This.Object.nr_Lote[lvl_Linha] = lvl_Lote
	Next
	
	//If This.RowCount() > 0 Then
		If Not wf_Atualiza_Valor_Lote(lvl_Lote) Then
			Return -1
		End If
	//End If
		
End If

Return 1
end event

event getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()

end event

event ue_addrow;call super::ue_addrow;// Lote aberto
//If This.RowCount() > 0 and ivs_Situacao = 'A' Then
//	This.ivo_Controle_Menu.of_Excluir(True)
//End If

Return AncestorReturnValue

end event

event constructor;call super::constructor;This.of_SetRowSelection()

This.ShareData(dw_8)
end event

event ue_update;call super::ue_update;If AncestorReturnValue = 1 Then
	This.Sort()
	This.Event ue_AddRow()
End If

Return AncestorReturnValue
end event

event ue_printimmediate;//OverRide

If wf_Verifica_Pendente() Then
	If Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existem altera$$HEX2$$e700f500$$ENDHEX$$es que n$$HEX1$$e300$$ENDHEX$$o foram salvas.~r~r" +&
			  	     "Deseja imprimir mesmo assim ?", Question!, YesNo!, 2) = 1 Then
					  
		dw_8.Event ue_Print()
	End If
Else
	dw_8.Event ue_Print()
End If
end event

event ue_saveas;dw_8.Event ue_SaveAs()
end event

type dw_8 from dc_uo_dw_base within tabpage_2
boolean visible = false
integer x = 512
integer y = 916
integer width = 1586
integer height = 492
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge266_lista_produto_relatorio"
boolean border = true
borderstyle borderstyle = styleraised!
end type

event ue_preprint;call super::ue_preprint;If AncestorReturnValue > 0 Then
	dw_8.Object.st_lote.text		 = String(Tab_1.TabPage_1.dw_2.Object.nr_lote          [Tab_1.TabPage_1.dw_2.GetRow()])
	dw_8.Object.st_emissao.text    = STring((Tab_1.TabPage_1.dw_2.Object.dh_registro      [Tab_1.TabPage_1.dw_2.GetRow()]), "dd/mm/yyyy")
	dw_8.Object.st_fornecedor.text = Tab_1.TabPage_1.dw_2.Object.nm_razao_social  [Tab_1.TabPage_1.dw_2.GetRow()] + "(" +&
												Tab_1.TabPage_1.dw_2.Object.cd_fornecedor    [Tab_1.TabPage_1.dw_2.GetRow()] + ")"
End If

Return AncestorReturnValue
end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3424
integer height = 1596
long backcolor = 80269524
string text = "Lista do Compras"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
gb_4 gb_4
dw_4 dw_4
dw_6 dw_6
end type

on tabpage_3.create
this.gb_4=create gb_4
this.dw_4=create dw_4
this.dw_6=create dw_6
this.Control[]={this.gb_4,&
this.dw_4,&
this.dw_6}
end on

on tabpage_3.destroy
destroy(this.gb_4)
destroy(this.dw_4)
destroy(this.dw_6)
end on

type gb_4 from groupbox within tabpage_3
integer x = 9
integer y = 12
integer width = 3200
integer height = 1536
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Lista de Produtos"
borderstyle borderstyle = styleraised!
end type

type dw_4 from dc_uo_dw_base within tabpage_3
integer x = 27
integer y = 72
integer width = 3145
integer height = 1460
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge266_lista_nota_compras"
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event ue_recuperar;// OverRide

Long lvl_Lote

Tab_1.TabPage_1.dw_2.AcceptText()

lvl_Lote = Tab_1.TabPage_1.dw_2.Object.nr_lote[Tab_1.TabPage_1.dw_2.GetRow()]

Return This.Retrieve(lvl_Lote)

end event

event getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

event constructor;call super::constructor;This.ShareData(dw_6)
end event

event ue_printimmediate;//OverRide

dw_6.Event ue_Print()
end event

event ue_postretrieve;Boolean lvb_Imprimir

If pl_Linhas > 0 Then
	This.Event RowFocusChanged(1)
	This.SetRow(1)
	This.SetFocus()
	lvb_Imprimir = True
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!)
	lvb_Imprimir = False
End If

This.ivo_Controle_Menu.of_Imprimir(lvb_Imprimir)

Return pl_Linhas
end event

event ue_saveas;dw_6.Event ue_SaveAs()
end event

type dw_6 from dc_uo_dw_base within tabpage_3
boolean visible = false
integer x = 91
integer y = 584
integer width = 2418
integer height = 780
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge266_lista_notas_compra_relatorio"
boolean border = true
borderstyle borderstyle = styleraised!
end type

event ue_preprint;call super::ue_preprint;If AncestorReturnValue > 0 Then
	dw_6.Object.st_lote.text		 = String(Tab_1.TabPage_1.dw_2.Object.nr_lote          [Tab_1.TabPage_1.dw_2.GetRow()])
	dw_6.Object.st_emissao.text    = STring((Tab_1.TabPage_1.dw_2.Object.dh_registro      [Tab_1.TabPage_1.dw_2.GetRow()]), "dd/mm/yyyy")
	dw_6.Object.st_fornecedor.text = Tab_1.TabPage_1.dw_2.Object.nm_razao_social  [Tab_1.TabPage_1.dw_2.GetRow()] + "(" +&
												Tab_1.TabPage_1.dw_2.Object.cd_fornecedor    [Tab_1.TabPage_1.dw_2.GetRow()] + ")"
End If

Return AncestorReturnValue
end event

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3424
integer height = 1596
long backcolor = 80269524
string text = "Lista do Fiscal"
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
gb_5 gb_5
dw_5 dw_5
dw_7 dw_7
end type

on tabpage_4.create
this.gb_5=create gb_5
this.dw_5=create dw_5
this.dw_7=create dw_7
this.Control[]={this.gb_5,&
this.dw_5,&
this.dw_7}
end on

on tabpage_4.destroy
destroy(this.gb_5)
destroy(this.dw_5)
destroy(this.dw_7)
end on

type gb_5 from groupbox within tabpage_4
integer x = 9
integer y = 12
integer width = 3515
integer height = 1536
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista de Produtos"
borderstyle borderstyle = styleraised!
end type

type dw_5 from dc_uo_dw_base within tabpage_4
integer x = 37
integer y = 76
integer width = 3465
integer height = 1432
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge266_lista_nota_fiscal"
boolean vscrollbar = true
end type

event ue_recuperar;// OverRide

Long lvl_Lote

String lvs_Fornecedor

DateTime lvdt_Devolucao

Tab_1.TabPage_1.dw_1.AcceptText()
Tab_1.TabPage_1.dw_2.AcceptText()

lvl_Lote       = Tab_1.TabPage_1.dw_2.Object.nr_lote      [Tab_1.TabPage_1.dw_2.GetRow()]
lvs_Fornecedor = Tab_1.TabPage_1.dw_2.Object.cd_fornecedor[Tab_1.TabPage_1.dw_2.GetRow()]
lvdt_Devolucao = Tab_1.TabPage_1.dw_1.Object.dt_devolucao [1]

Return This.Retrieve(lvl_Lote, lvs_Fornecedor, lvdt_Devolucao)

end event

event getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

event constructor;call super::constructor;This.ShareData(dw_7)

String lvs_Coluna[], &
       lvs_Nome[]

lvs_Coluna = {"item_nf_compra_cd_produto", "de_produto"}

lvs_Nome = {"C$$HEX1$$f300$$ENDHEX$$digo", "Descri$$HEX2$$e700e300$$ENDHEX$$o"}

This.of_SetSort(lvs_Coluna, lvs_Nome)
This.of_SetFilter(lvs_Coluna, lvs_Nome)


end event

event ue_printimmediate;//OverRide

dw_7.Event ue_Print()


end event

event ue_postretrieve;Boolean lvb_Habilitar

If pl_Linhas > 0 Then
	This.Event RowFocusChanged(1)
	This.SetRow(1)
	This.SetFocus()
	lvb_Habilitar = True
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!)
	lvb_Habilitar = False
End If

This.ivo_Controle_Menu.of_Imprimir   (lvb_Habilitar)
This.ivo_Controle_Menu.of_Classificar(lvb_Habilitar)
This.ivo_Controle_Menu.of_Filtrar    (lvb_Habilitar)

Return pl_Linhas
end event

type dw_7 from dc_uo_dw_base within tabpage_4
boolean visible = false
integer x = 82
integer y = 580
integer width = 3209
integer height = 852
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge266_lista_notas_fiscal_relatorio"
boolean border = true
borderstyle borderstyle = StyleRaised!
end type

event ue_preprint;call super::ue_preprint;If AncestorReturnValue > 0 Then
	dw_7.Object.st_lote.text		 = String(Tab_1.TabPage_1.dw_2.Object.nr_lote          [Tab_1.TabPage_1.dw_2.GetRow()])
	dw_7.Object.st_emissao.text    = STring((Tab_1.TabPage_1.dw_2.Object.dh_registro      [Tab_1.TabPage_1.dw_2.GetRow()]), "dd/mm/yyyy")
	dw_7.Object.st_fornecedor.text = Tab_1.TabPage_1.dw_2.Object.nm_razao_social  [Tab_1.TabPage_1.dw_2.GetRow()] + "(" +&
												Tab_1.TabPage_1.dw_2.Object.cd_fornecedor    [Tab_1.TabPage_1.dw_2.GetRow()] + ")"
End If

Return AncestorReturnValue
end event

