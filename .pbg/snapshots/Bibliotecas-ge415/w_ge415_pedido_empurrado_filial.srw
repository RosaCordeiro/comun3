HA$PBExportHeader$w_ge415_pedido_empurrado_filial.srw
forward
global type w_ge415_pedido_empurrado_filial from dc_w_sheet
end type
type gb_3 from groupbox within w_ge415_pedido_empurrado_filial
end type
type gb_2 from groupbox within w_ge415_pedido_empurrado_filial
end type
type gb_1 from groupbox within w_ge415_pedido_empurrado_filial
end type
type dw_1 from dc_uo_dw_base within w_ge415_pedido_empurrado_filial
end type
type dw_2 from dc_uo_dw_base within w_ge415_pedido_empurrado_filial
end type
type dw_3 from dc_uo_dw_base within w_ge415_pedido_empurrado_filial
end type
type cb_importar from commandbutton within w_ge415_pedido_empurrado_filial
end type
type dw_4 from dc_uo_dw_base within w_ge415_pedido_empurrado_filial
end type
type cb_historico from commandbutton within w_ge415_pedido_empurrado_filial
end type
type cb_descancelar from commandbutton within w_ge415_pedido_empurrado_filial
end type
type cb_motivo from commandbutton within w_ge415_pedido_empurrado_filial
end type
end forward

global type w_ge415_pedido_empurrado_filial from dc_w_sheet
integer width = 5760
integer height = 1764
string title = "GE415 - Cadastro de Pedidos Empurrados por Filial"
boolean resizable = false
long backcolor = 80269524
event ue_addrow ( )
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
dw_1 dw_1
dw_2 dw_2
dw_3 dw_3
cb_importar cb_importar
dw_4 dw_4
cb_historico cb_historico
cb_descancelar cb_descancelar
cb_motivo cb_motivo
end type
global w_ge415_pedido_empurrado_filial w_ge415_pedido_empurrado_filial

type variables
uo_produto					ivo_Produto	//ge001
uo_filial						ivo_Filial		//ge009
uo_pedido_empurrado	ivo_Pedido	//ge198

Long ivl_pedido_existente,&
	   il_Cod_Motivo,&
	   il_Cod_Motivo_Atual
end variables

forward prototypes
public subroutine wf_inicializar ()
public subroutine wf_carrega_produto (datastore ads_produto)
public function boolean wf_pertence_mix (long al_produto, boolean ab_importacao)
public function integer wf_valida_salva_local ()
public function boolean wf_salva ()
public function boolean wf_valida_qtde_pedida (long al_produto, long al_qt_pedida, long al_vl_fat_conv)
public subroutine wf_insere_motivo_padrao ()
public function boolean wf_verifica_tipo_alteracao (long al_filial, long al_pedido, long al_produto, long al_qt_empurrada_nova, long al_qt_empurrada_atual)
public function boolean wf_localiza_resumo_reposicao_estoque (long al_filial, long al_produto, ref string as_classe, ref long al_venda)
end prototypes

event ue_addrow;dw_2.Event ue_AddRow()
end event

public subroutine wf_inicializar ();SetNull(ivl_Pedido_Existente)

ivo_Filial.of_Inicializa()
ivo_Produto.of_Inicializa()

ivm_Menu.mf_Recuperar(False)
ivm_Menu.mf_Confirmar(False)
ivm_Menu.mf_Cancelar(False)
ivm_Menu.mf_Excluir(False)
ivm_Menu.mf_Incluir(False)

dw_1.Event ue_Reset()
dw_2.Event ue_Reset()
dw_3.Event ue_Reset()
dw_4.Event ue_Reset()

dw_1.Event ue_AddRow()
dw_3.Event ue_AddRow()

ivb_Valida_Salva = False
dw_1.Enabled = True

cb_historico.Enabled = False

dw_1.Object.nm_filial.Protect = 0

dw_1.SetFocus()

dw_1.Event ue_Pos(1, "nm_filial")
end subroutine

public subroutine wf_carrega_produto (datastore ads_produto);Long lvl_Produto, &
	  lvl_Filial,  &
	  lvl_Qt_venda

Integer lvi_Qtde,&
		lvi_Linha,&
		lvi_Find,&
		lvi_Insert,&
		lvi_Contador

String lvs_Descricao,&
	   lvs_Pertence_Mix, &
		lvs_Classe
	   
dw_2.SetRedRaw(False)

dw_1.AcceptText ()

lvl_Filial = dw_1.Object.cd_filial [1]

If dw_2.RowCount() > 0 Then
	// Exclui a $$HEX1$$fa00$$ENDHEX$$ltima linha se estiver em branco
	If IsNull(dw_2.Object.cd_produto[dw_2.RowCount()]) Then
		dw_2.DeleteRow(dw_2.RowCount())
	End If
End If
	 
For lvi_Linha = 1 To ads_Produto.RowCount()
	
	lvl_Produto = ads_Produto.Object.cd_produto[lvi_Linha]
	lvi_Qtde    = ads_Produto.Object.qt_produto[lvi_Linha]
	
	ivo_Produto.of_Localiza_Codigo_Interno(lvl_Produto)
	
	If mid(ivo_Produto.cd_subcategoria, 1,1) = '5' Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitido empurrar produto do grupo ALMOXARIFADO. Produto '" + String(lvl_Produto) + "'.", StopSign!)
		Continue
	End If
	
	If ivo_Produto.Localizado Then
		lvs_Descricao = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto '" + String(lvl_Produto) + "' n$$HEX1$$e300$$ENDHEX$$o foi localizado.")
		Continue
	End If
	
	lvi_Find = dw_2.Find("cd_produto =" + String(lvl_Produto), 1, dw_2.RowCount())
	
	If lvi_Find = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o produto.")
		Exit
	End If
	
	If lvi_Find > 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto '" + String(lvl_Produto) + "' j$$HEX1$$e100$$ENDHEX$$ foi inclu$$HEX1$$ed00$$ENDHEX$$do neste pedido.") 
	Else
		If wf_Pertence_Mix(ivo_Produto.Cd_Produto, True) Then
			lvs_Pertence_Mix = "S"
		Else
			lvs_Pertence_Mix = "N"
		End If
		
		lvi_Insert = dw_2.InsertRow(0) 
		
		dw_2.Object.cd_produto     	  [lvi_Insert] = lvl_Produto	
		dw_2.Object.de_produto     	  [lvi_Insert] = lvs_Descricao
		dw_2.Object.qt_empurrada   	  [lvi_Insert] = lvi_Qtde
		dw_2.Object.id_pertence_mix	  [lvi_Insert] = lvs_Pertence_Mix
		dw_2.Object.vl_fator_conversao[lvi_Insert] = ivo_Produto.vl_fator_conversao
		
		If not wf_localiza_resumo_reposicao_estoque (lvl_Filial, lvl_Produto, Ref lvs_Classe, Ref lvl_Qt_venda) then
			Return
		else
			dw_2.Object.cd_classe_reposicao [lvi_Insert] = lvs_Classe
			dw_2.Object.qt_venda_periodo    [lvi_Insert] = lvl_Qt_venda
		End if
		
		lvi_Contador ++
	End If
Next

If lvi_Contador > 0 Then
	ivm_Menu.mf_Excluir(True)
	ivm_Menu.mf_Confirmar(True)	
	ivm_Menu.mf_Cancelar(True)	
	ivb_Valida_Salva = True
	dw_2.Sort()
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum produto foi inclu$$HEX1$$ed00$$ENDHEX$$do.")
End If

dw_2.SetRedRaw(True)

end subroutine

public function boolean wf_pertence_mix (long al_produto, boolean ab_importacao);Boolean lvb_Sucesso = False

Long lvl_Mix

Select cd_mix_produto Into :lvl_Mix
From produto_central
Where cd_produto = :al_Produto
  and cd_mix_produto in (Select cd_mix_produto
                         From mix_produto_filial
								 Where cd_filial = :ivo_Filial.Cd_Filial)
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		lvb_Sucesso = True
		
	Case 100
		// Se for por importado do arquivo n$$HEX1$$e300$$ENDHEX$$o mostra esta mensagem.
		If Not ab_Importacao Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto '" + String(al_Produto) + "' n$$HEX1$$e300$$ENDHEX$$o pertence ao mix da filial '" + String(ivo_Filial.Cd_Filial) + "'.")
		End If
	Case -1
		SqlCa.of_MsgdbError("Verifica$$HEX2$$e700e300$$ENDHEX$$o do Mix do Produto")
End Choose

Return lvb_Sucesso
end function

public function integer wf_valida_salva_local ();Integer lvi_Retorno_Update, &
        lvi_Retorno_Msg, &
		  lvi_Retorno

If Not This.ivb_Valida_Salva Then Return OK_SEM_PENDENCIAS

SetPointer(HourGlass!)

If wf_AcceptText() Then
	If wf_UpdatesPending() Then
		// Existem updates pendentes
		// Pergunta se o usu$$HEX1$$e100$$ENDHEX$$rio deseja salvar as informa$$HEX2$$e700f500$$ENDHEX$$es
		lvi_Retorno_Msg = MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja salvar as altera$$HEX2$$e700f500$$ENDHEX$$es antes de continuar ?", Question!, YesNoCancel!, 1)
	
		Choose Case lvi_Retorno_Msg
			Case 1
				// YES - Update
				If This.Event ue_Save() = 1 Then
					// Update com sucesso
					// Continua o processo
					lvi_Retorno = OK_SUCESSO_UPDATE
				Else
					// Houve erros durante o udpate
					// Aguarda a resolu$$HEX2$$e700e300$$ENDHEX$$o dos erros
					lvi_Retorno = CANCELAR_ERRO_UPDATE
				End If
			Case 2
				// NO - Continua o processo sem salvar as altera$$HEX2$$e700f500$$ENDHEX$$es
				lvi_Retorno = OK_SEM_UPDATE
				//This.ivb_Valida_Salva = False
			Case 3
				// CANCEL - N$$HEX1$$e300$$ENDHEX$$o continua o processo
				lvi_Retorno = CANCELAR_UPDATE
		End Choose		
	Else
		// N$$HEX1$$e300$$ENDHEX$$o existem updates pendentes. Continuar o processo normalmente
		lvi_Retorno = OK_SEM_PENDENCIAS		
	End If
Else
	// Existem updates pendentes, mas foram encontradas entrada de dados com erros
	// Permite que o usu$$HEX1$$e100$$ENDHEX$$rio continue o processo sem salvar
	lvi_Retorno_Msg = MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "As informa$$HEX2$$e700f500$$ENDHEX$$es n$$HEX1$$e300$$ENDHEX$$o passaram nas valida$$HEX2$$e700f500$$ENDHEX$$es e devem " + &
													    "estar corrigidas antes de serem salvas.~r~n~r~n" + &
													    "Continuar sem salvar?", &
													    Question!, YesNo!, 2)
	
	If lvi_Retorno_Msg = 1 Then
		// Continuar o processo sem salvar
		lvi_Retorno = OK_COM_PENDENCIAS
		This.ivb_Valida_Salva = False
	Else
		// N$$HEX1$$e300$$ENDHEX$$o continua o processo e aguarda a resolu$$HEX2$$e700e300$$ENDHEX$$o dos erros
		lvi_Retorno = CANCELAR_ERRO_PENDENCIAS
	End If	
End If

SetPointer(Arrow!)
Return lvi_Retorno
end function

public function boolean wf_salva ();Boolean lb_Sucesso = False

Long	lvl_Linha, &
		lvl_Produto, &
		lvl_Pedido_Update, &
		ll_Qt_Final, &
		ll_Fator, &
		ll_Qt_Empurrada, &
		ll_Qt_Emp_Atual,&
		ll_Qt_Aprovada

DateTime ldt_hoje 
ldt_hoje  =  gf_getserverdate() 


Try

	dw_2.AcceptText()
	
	If dw_2.RowCount() > 0 Then
		If IsNull(dw_2.Object.cd_produto[dw_2.RowCount()]) Then
			dw_2.DeleteRow(dw_2.RowCount())
		End If
	End If
	
	
	If IsNull(ivl_Pedido_Existente) Then
		If Not ivo_Pedido.of_Inclui_Pedido(ivo_Filial.Cd_Filial, Ref lvl_Pedido_Update) Then
			Return False
		End If
	Else
		lvl_Pedido_Update = ivl_Pedido_Existente
	End If
	
	
	
	If dw_2.RowCount() > 0 Then
		For lvl_Linha = 1 To dw_2.RowCount()
			
			lvl_Produto = dw_2.Object.Cd_Produto[lvl_Linha]
				
			If ivo_Pedido.of_Produto_Colocado(ivo_Filial.Cd_Filial, lvl_Produto, "F", lvl_Pedido_Update) Then
				lb_Sucesso = False
				dw_2.Event ue_Pos(lvl_Linha, "qt_empurrada")
				Return False
			End If
			
			
			ll_Qt_Final				= dw_2.Object.Qt_Final								[lvl_Linha]
			ll_Fator					= dw_2.Object.Vl_Fator_Conversao				[lvl_Linha]
			ll_Qt_Empurrada		= dw_2.Object.Qt_Empurrada						[lvl_Linha]
			ll_Qt_Emp_Atual		= dw_2.Object.Qt_Empurrada_Atual  			[lvl_Linha]
			il_Cod_Motivo 			= dw_2.Object.Cd_Motivo_Empurrado			[lvl_Linha]
			il_Cod_Motivo_Atual 	= dw_2.Object.Cd_Motivo_Empurrado_Atual	[lvl_Linha]
			
			If il_Cod_Motivo = 0 Or isnull(il_Cod_Motivo) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Selecione o motivo do pedido empurrado.",Exclamation!)
				dw_2.Event ue_Pos(lvl_Linha, "cd_motivo_empurrado")
				Return False
			End If
			
			If ll_Qt_Empurrada = 0 Then
				lb_Sucesso = False
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Quantidade deve ser maior que zero.~rRealize a EXCLUS$$HEX1$$c300$$ENDHEX$$O caso n$$HEX1$$e300$$ENDHEX$$o queira pedir o produto.")
				dw_2.Event ue_Pos(lvl_Linha, "qt_empurrada")
				Return False
			End If
			
			If Not wf_Valida_Qtde_Pedida(lvl_Produto, ll_Qt_Final, ll_Fator) Then
				lb_Sucesso = False
				Return False
			End If
			
			If Not wf_Verifica_Tipo_Alteracao(ivo_Filial.Cd_Filial, lvl_Pedido_Update, lvl_Produto, ll_Qt_Empurrada, ll_Qt_Emp_Atual) Then
				lb_Sucesso = False
				Return False
			End If
		Next
	End If
	
	//Verifica a exclus$$HEX1$$e300$$ENDHEX$$o
	If Not wf_Verifica_Tipo_Alteracao(ivo_Filial.Cd_Filial, lvl_Pedido_Update, 0, 0, 0) Then
		lb_Sucesso = False
		Return False
	End If
	
	lb_Sucesso = True	
	Return True

Finally

	If lb_Sucesso Then
		SqlCa.of_Commit();
	Else
		SqlCa.of_Rollback();
	End If
End Try
end function

public function boolean wf_valida_qtde_pedida (long al_produto, long al_qt_pedida, long al_vl_fat_conv);Long ll_Dobro
Long ll_Eb

dw_3.AcceptText()

Select qt_estoque_base
	Into :ll_Eb
From resumo_reposicao_estoque
Where cd_filial = :ivo_Filial.Cd_Filial
	And cd_produto = :al_Produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		//
		
	Case 100
		ll_Eb = 0
		
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar a quantidade do estoque base.", StopSign!)
		Return False
End Choose

If ll_Eb > 0 Then

	ll_Dobro = ll_Eb * 2 //Dobro do estoque base
	
	If al_Qt_Pedida > ll_Dobro Then
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Quantidade pedida $$HEX1$$e900$$ENDHEX$$ maior que o dobro do estoque base." + &
										"~rQuantidade Pedida: " + String(al_Qt_Pedida) + &
										"~rEstoque Base: " + String(ll_Eb) + &
										"~r~rDeseja continuar mesmo assim?", Question!, YesNo!, 2) = 2 Then Return False
	End If

Else
	
	If al_Vl_Fat_Conv > 1 Then
		If al_Qt_Pedida > 50 Then
			If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Estoque base do produto $$HEX1$$e900$$ENDHEX$$ zero na filial.~rTem certeza que deseja pedir '" + String(al_Qt_Pedida) + "'?", Question!, YesNo!, 2) = 2 Then Return False
		End If
	Else
		If al_Qt_Pedida > 10 Then
			If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Estoque base do produto $$HEX1$$e900$$ENDHEX$$ zero na filial.~rTem certeza que deseja pedir '" + String(al_Qt_Pedida) + "'?", Question!, YesNo!, 2) = 2 Then Return False
		End If
	End If	
End If

Return True
end function

public subroutine wf_insere_motivo_padrao ();DataWindowChild lvdwc

Integer lvi_Retorno,&
        lvi_Row

If dw_1.GetChild("cd_motivo", lvdwc) = 1 Then
	lvdwc.InsertRow(1)
	
	lvdwc.SetItem(1, "cd_motivo_empurrado", 0)
	lvdwc.SetItem(1, "de_motivo_empurrado", "NENHUM")
	
	dw_1.Object.Cd_Motivo[1] = 0
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild do Motivo.")
End If
end subroutine

public function boolean wf_verifica_tipo_alteracao (long al_filial, long al_pedido, long al_produto, long al_qt_empurrada_nova, long al_qt_empurrada_atual);Long ll_Find
Long ll_Linha
Long ll_Produto



If al_Produto > 0 Then //Inclus$$HEX1$$e300$$ENDHEX$$o e/ou altera$$HEX2$$e700e300$$ENDHEX$$o
	ll_Find = dw_4.Find("cd_produto = " + String(al_Produto), 1, dw_4.RowCount())
	
	If ll_Find = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find da dw_4. Fun$$HEX2$$e700e300$$ENDHEX$$o wf_verifica_tipo_alteracao.", StopSign!)
		Return False
	End If
	
	If ll_Find > 0 Then
		If al_Qt_Empurrada_Atual <> al_Qt_Empurrada_Nova  Or il_Cod_Motivo <> il_Cod_Motivo_Atual Then
			//Atualiza$$HEX2$$e700e300$$ENDHEX$$o		
			If Not ivo_Pedido.of_Atualiza_Produto_Pedido(al_Filial, al_Pedido, al_Produto, al_Qt_Empurrada_Nova, al_Qt_Empurrada_Atual, True, il_Cod_Motivo, il_Cod_Motivo_Atual, al_Qt_Empurrada_Nova ) Then Return False
		End If
	Else
		//Inclus$$HEX1$$e300$$ENDHEX$$o
		If Not ivo_Pedido.of_Inclui_Produto_Pedido(al_Filial, al_Pedido, al_Produto, al_Qt_Empurrada_Nova, True, il_Cod_Motivo, al_Qt_Empurrada_Nova ) Then Return False
	End If
	
Else //Exclus$$HEX1$$e300$$ENDHEX$$o

	SetNull(ll_Find)
	
	For ll_Linha = 1 To dw_4.RowCount()
		ll_Produto = dw_4.Object.Cd_Produto[ll_Linha]
		
		ll_Find = dw_2.Find("cd_produto = " + String(ll_Produto), 1, dw_2.RowCount())
		
		If ll_Find = -1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find da dw_2. Fun$$HEX2$$e700e300$$ENDHEX$$o wf_verifica_tipo_alteracao.", StopSign!)
			Return False
		End If
		
		If ll_Find = 0 Then
			//Exclus$$HEX1$$e300$$ENDHEX$$o
			If Not ivo_Pedido.of_Exclui_Produto_Pedido(al_Filial, al_Pedido, ll_Produto, dw_4.Object.Qt_Empurrada[ll_Linha], True) Then Return False
		End If
	Next
End If

Return True
end function

public function boolean wf_localiza_resumo_reposicao_estoque (long al_filial, long al_produto, ref string as_classe, ref long al_venda);SetNull (as_classe)
SetNull (al_venda)

SELECT cd_classe_reposicao
	  , COALESCE (qt_venda_periodo, 0) AS qt_venda_periodo  
  INTO :as_classe
	  , :al_venda
  FROM resumo_reposicao_estoque
 WHERE cd_filial  = :al_filial
   AND cd_produto = :al_produto
 USING SQLCA;

Choose case SQLCA.SQLCode
	case is < 0
		SQLCA.of_Msgdberror ('Erro ao pesquisar a classe de reposi$$HEX2$$e700e300$$ENDHEX$$o e a quantidade de vendas')
		Return False
//	case 100
//		MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Classe de reposi$$HEX2$$e700e300$$ENDHEX$$o e quantidade de vendas n$$HEX1$$e300$$ENDHEX$$o localizadas para a filial/produto', Exclamation!)
//		Return False
End choose

Return True
end function

on w_ge415_pedido_empurrado_filial.create
int iCurrent
call super::create
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.dw_3=create dw_3
this.cb_importar=create cb_importar
this.dw_4=create dw_4
this.cb_historico=create cb_historico
this.cb_descancelar=create cb_descancelar
this.cb_motivo=create cb_motivo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_3
this.Control[iCurrent+2]=this.gb_2
this.Control[iCurrent+3]=this.gb_1
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.dw_2
this.Control[iCurrent+6]=this.dw_3
this.Control[iCurrent+7]=this.cb_importar
this.Control[iCurrent+8]=this.dw_4
this.Control[iCurrent+9]=this.cb_historico
this.Control[iCurrent+10]=this.cb_descancelar
this.Control[iCurrent+11]=this.cb_motivo
end on

on w_ge415_pedido_empurrado_filial.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.cb_importar)
destroy(this.dw_4)
destroy(this.cb_historico)
destroy(this.cb_descancelar)
destroy(this.cb_motivo)
end on

event ue_postopen;call super::ue_postopen;wf_Inicializar()

wf_insere_motivo_padrao()
end event

event close;call super::close;Destroy(ivo_Produto)
Destroy(ivo_Filial)
Destroy(ivo_Pedido)
end event

event ue_cancel;call super::ue_cancel;wf_Inicializar()
end event

event ue_save;call super::ue_save;If wf_Salva() Then	
	dw_2.Event ue_Retrieve()
	
	ivb_Valida_Salva = False
	dw_1.Enabled = True
	dw_1.Object.nm_filial.Protect = 0
	
	dw_1.SetFocus()
	
	ivm_Menu.mf_Cancelar(False)
	ivm_Menu.mf_Confirmar(False)
End If

Return AncestorReturnValue
end event

event open;call super::open;ivo_Produto	= Create uo_Produto
ivo_Filial		= Create uo_Filial
ivo_Pedido	= Create uo_Pedido_Empurrado
end event

event closequery;call super::closequery;If ivb_Valida_Salva Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existem altera$$HEX2$$e700f500$$ENDHEX$$es pendentes. Se fechar a tela ser$$HEX1$$e300$$ENDHEX$$o desfeitas.~rDeseja continuar?", Question!, YesNo!, 2) = 2 Then Return -1
End If
end event

type dw_visual from dc_w_sheet`dw_visual within w_ge415_pedido_empurrado_filial
integer x = 87
end type

type gb_aux_visual from dc_w_sheet`gb_aux_visual within w_ge415_pedido_empurrado_filial
integer x = 50
end type

type gb_3 from groupbox within w_ge415_pedido_empurrado_filial
integer x = 4251
integer y = 284
integer width = 1477
integer height = 1304
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

type gb_2 from groupbox within w_ge415_pedido_empurrado_filial
integer x = 27
integer y = 284
integer width = 4206
integer height = 1304
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista dos Produtos do Pedido"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within w_ge415_pedido_empurrado_filial
integer x = 27
integer width = 1687
integer height = 252
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
borderstyle borderstyle = styleraised!
end type

type dw_1 from dc_uo_dw_base within w_ge415_pedido_empurrado_filial
integer x = 50
integer y = 60
integer width = 1646
integer height = 180
boolean bringtotop = true
string dataobject = "dw_ge415_selecao"
end type

event itemchanged;call super::itemchanged;If dwo.Name = "nm_filial" Then
	If Data <> ivo_Filial.Nm_Fantasia Then
		Return 1
	dw_2.Event ue_Reset()
	dw_4.Event ue_Reset()
	Else
		cb_importar.Enabled = False
		cb_historico.Enabled = False
	End If	
End If	

end event

event ue_key;String lvs_Filial

If Key = KeyEnter! Then
	If This.GetColumnName() = "nm_filial" Then
		lvs_Filial = This.GetText()
	
		ivo_Filial.of_Localiza_Filial(lvs_Filial)
		
		If ivo_Filial.Localizada Then
			This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
			This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
			
			ivm_Menu.mf_Incluir(True)
			
			cb_importar.Enabled = True
			cb_motivo.Enabled    = True
			
			dw_2.Event ue_Retrieve()
		End If
	End If
End If
end event

event losefocus;If IsValid(ivo_Filial) Then
	This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
End If
end event

event editchanged;call super::editchanged;Choose Case dwo.Name
		Case "nm_fantasia"
			dw_2.Event ue_Reset()
			dw_4.Event ue_Reset()

			cb_importar.Enabled = False
			cb_historico.Enabled = False
End Choose
end event

event ue_deleterow;//OverRide

dw_2.Event ue_DeleteRow()

Return True
end event

type dw_2 from dc_uo_dw_base within w_ge415_pedido_empurrado_filial
integer x = 46
integer y = 336
integer width = 4155
integer height = 1236
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge415_lista"
boolean vscrollbar = true
boolean livescroll = false
end type

event ue_key;Long lvl_Linha,  &
     lvl_Find,   &
	  lvl_Filial, &
	  lvl_Qt_venda
 
String lvs_Pertence_Mix, lvs_Coluna, lvs_Classe

This.AcceptText()

lvs_Coluna = This.GetColumnName()

Choose Case lvs_Coluna
	Case "de_produto"
		If Key = KeyEnter! Then
			ivo_Produto.of_Localiza_Produto(This.GetText())
			
			If Mid(ivo_Produto.cd_subcategoria, 1,1) = '5' Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitido empurrar produto do grupo ALMOXARIFADO.", StopSign!)
				Return
			End If
			
			If ivo_Produto.Localizado Then
				lvl_Linha = This.GetRow()
				
				lvl_Find = This.Find("cd_produto = " + String(ivo_Produto.Cd_Produto), 1, This.RowCount())
				
				If lvl_Find > 0 Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Este produto j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ colocado neste pedido.", Information!)
					This.DeleteRow(lvl_Linha)
					This.Post Event ue_Pos(lvl_Find, "qt_empurrada")
				Else
					If wf_Pertence_Mix(ivo_Produto.Cd_Produto, False) Then
						lvs_Pertence_Mix = "S"
					Else
						lvs_Pertence_Mix = "N"
					End If
					
					dw_2.Object.Cd_Produto        		[lvl_Linha] = ivo_Produto.Cd_Produto
					dw_2.Object.De_Produto        		[lvl_Linha] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
					dw_2.Object.vl_fator_conversao	[lvl_Linha] = ivo_Produto.vl_fator_conversao
					dw_2.Object.Qt_Empurrada      	[lvl_Linha] = 1
					dw_2.Object.Id_Pertence_Mix   	[lvl_Linha] = lvs_Pertence_Mix
					dw_2.Object.Qt_Final					[lvl_Linha] = dw_2.Object.Vl_Fator_Conversao[lvl_Linha] * dw_2.Object.Qt_Empurrada[lvl_Linha]
					
					lvl_Filial = dw_1.Object.cd_filial [1]
					
					If not wf_localiza_resumo_reposicao_estoque (lvl_Filial, ivo_Produto.Cd_Produto, Ref lvs_Classe, Ref lvl_Qt_venda) then
						Return
					else
						dw_2.Object.cd_classe_reposicao [lvl_Linha] = lvs_Classe
						dw_2.Object.qt_venda_periodo    [lvl_Linha] = lvl_Qt_venda
					End if
					
					dw_3.Event ue_Retrieve()
					
					
					If This.Object.Id_Situacao[This.GetRow()] = 'X' Then
						This.SetTabOrder('qt_empurrada', 0)
						This.SetTabOrder('cd_produto', 0)
						This.SetTabOrder('qt_final', 0)
						cb_Descancelar.Enabled = True
					Else
						This.SetTabOrder('qt_empurrada', 20)

						dw_2.Event ue_Pos(lvl_Linha, "qt_empurrada")
						This.Object.DataWindow.HorizontalScrollPosition = 0

						cb_Descancelar.Enabled = False
					End If

					dw_2.Event ue_Pos(lvl_Linha, "qt_empurrada")
					This.Object.DataWindow.HorizontalScrollPosition = 0
				End If
			End If	
		End If
		
	Case "qt_empurrada"
		If Key = KeyEnter! Then
			This.Event ue_Addrow()
		End If
End Choose
end event

event ue_recuperar;// Override
Long ll_linhas
String nr_matricula
nr_matricula = gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
// Verifica se existe algum pedido n$$HEX1$$e300$$ENDHEX$$o processado
If ivo_Pedido.of_Pedido_Nao_Processado(ivo_Filial.Cd_Filial, ref ivl_Pedido_Existente) Then
	If Not IsNull(ivl_Pedido_Existente) Then 
		Return This.Retrieve(ivo_Filial.Cd_Filial, ivl_Pedido_Existente,nr_matricula )	
	Else
		This.Event ue_Reset()
		This.Event ue_AddRow()
		This.SetFocus()
		Return 0
	End If
End If
end event

event itemfocuschanged;This.SelectText(1, 100)
end event

event ue_preinsertrow;call super::ue_preinsertrow;Long lvl_Linha

If This.RowCount() > 0 Then
	lvl_Linha = This.Find("isnull(cd_produto)", 1, This.RowCount())
	
	If lvl_Linha > 0 Then
		This.Event ue_Pos(lvl_Linha, "de_produto")
		Return -1
	End If
End If

Return 1
end event

event itemchanged;call super::itemchanged;string ls_id_ecommerce

ivm_Menu.mf_Confirmar(True)
ivm_Menu.mf_Cancelar(True)

ivb_Valida_Salva = True
//dw_1.Enabled = False
dw_1.Object.nm_filial.Protect = 1

If dwo.Name = "qt_empurrada" Then
	
	ls_id_ecommerce = this.object.id_ecommerce[row] 
	
	if ls_id_ecommerce = 'S' then
		
		if messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'H$$HEX1$$e100$$ENDHEX$$ quantidade solicitada pelo e-Ecommerce para esse produto.~n~nDeseja alterar mesmo assim? ',question!,yesno!,2) = 2 then
			return 2
		end if
		
	ENd if
	
	This.Object.Qt_Final[This.GetRow()] = This.Object.Vl_Fator_Conversao[This.GetRow()] * Long(Data)
End If
end event

event editchanged;call super::editchanged;ivm_Menu.mf_Confirmar(True)
ivm_Menu.mf_Cancelar(True)

ivb_Valida_Salva = True
//dw_1.Enabled = False
dw_1.Object.nm_filial.Protect = 1
end event

event constructor;call super::constructor;This.of_SetRowSelection("", "if(id_pertence_mix = ~"S~", rgb(0,0,0), rgb(255,0,0))")
end event

event ue_addrow;call super::ue_addrow;If AncestorReturnValue > 0 Then
	ivm_Menu.mf_Excluir(True)
End If

Return AncestorReturnValue
end event

event ue_deleterow;call super::ue_deleterow;If This.RowCount() > 0 Then
	ivm_Menu.mf_Excluir(True)
	
	This.Event RowFocusChanged(This.GetRow())
Else
	ivm_Menu.mf_Excluir(False)
End If

Return AncestorReturnValue
end event

event rowfocuschanged;If CurrentRow > 0 Then
	
	This.AcceptText()
	
	If This.Object.Id_Situacao[CurrentRow] = 'X' Then
		This.Event ue_Pos(CurrentRow, 'qt_empurrada')
		This.SetTabOrder('qt_empurrada', 0)
		This.SetTabOrder('cd_produto', 0)
		This.SetTabOrder('qt_final', 0)
		cb_Descancelar.Enabled = True
	Else
		This.SetTabOrder('qt_empurrada', 20)
		dw_2.Event ue_Pos(CurrentRow, "qt_empurrada")
		cb_Descancelar.Enabled = False
	End If

	dw_3.Event ue_Retrieve()

	dw_3.Object.nm_usuario_inclusao[1] = dw_2.Object.nm_usuario[CurrentRow]
	
End If





end event

event ue_postretrieve;dw_4.Event ue_Reset()

If pl_Linhas > 0 Then
	This.Event RowFocusChanged(1)
		
	cb_historico.Enabled = True
	ivm_Menu.mf_Excluir(True)
	
	If dw_2.RowsCopy(1,dw_2.RowCount(), Primary!, dw_4, 1, Primary!) <> 1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no RowsCopy da dw_4.", StopSign!)
		Return -1
	End If
Else
	dw_3.Event ue_Retrieve()
	cb_historico.Enabled = False
End If

Return pl_Linhas
end event

event clicked;call super::clicked;If row > 0 Then
	This.Event RowFocusChanged(row)
End If
end event

type dw_3 from dc_uo_dw_base within w_ge415_pedido_empurrado_filial
integer x = 4279
integer y = 336
integer width = 1435
integer height = 1224
integer taborder = 0
boolean bringtotop = true
string dataobject = "dw_ge415_detalhe"
end type

event ue_recuperar;// Override

Long lvl_Linha, &
     lvl_Filial, &
	  lvl_Produto, &
	  lvl_Total

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvl_Filial  = ivo_Filial.Cd_Filial
	lvl_Produto = dw_2.Object.Cd_Produto[lvl_Linha]
	
	If Not IsNull(lvl_Produto) Then
		lvl_Total = This.Retrieve(lvl_Filial, lvl_Produto)
	End If
End If

If lvl_Total = 0 Then
	This.Reset()
	This.InsertRow(0)
End If	

Return This.RowCount()
end event

type cb_importar from commandbutton within w_ge415_pedido_empurrado_filial
integer x = 1765
integer y = 24
integer width = 672
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Importar do Arquivo"
end type

event clicked;If ivb_Valida_Salva Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existem altera$$HEX2$$e700f500$$ENDHEX$$es pendentes.~rEfetue a salva ou cancelamento para prosseguir.", Exclamation!)
	Return -1
End If

dc_uo_ds_base lvo_Produto
lvo_Produto = Create dc_uo_ds_base

If Not lvo_Produto.of_ChangeDataObject("dw_ge415_produto") Then 
	Destroy(lvo_Produto)
	Return 
End If

OpenWithParm(w_ge415_importa_produto, lvo_Produto)

lvo_Produto = Message.PowerObjectParm

If IsValid(lvo_Produto) Then
	wf_Carrega_Produto(lvo_Produto)
End If

Destroy(lvo_Produto)
end event

type dw_4 from dc_uo_dw_base within w_ge415_pedido_empurrado_filial
boolean visible = false
integer x = 1001
integer y = 780
integer width = 750
integer height = 348
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge415_lista"
string ivs_cor_linha_padrao = ""
end type

type cb_historico from commandbutton within w_ge415_pedido_empurrado_filial
integer x = 2473
integer y = 24
integer width = 699
integer height = 100
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Hist$$HEX1$$f300$$ENDHEX$$rico das Altera$$HEX2$$e700f500$$ENDHEX$$es"
end type

event clicked;Long lvl_Filial, lvl_PedidoEmpurrado, lvl_produto, ll_row
String ls_chave_pesquisa

//If wf_valida_salva_local() = -3 Then Return

If ivb_Valida_Salva Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existem altera$$HEX2$$e700f500$$ENDHEX$$es pendentes.~rEfetue a salva ou cancelamento para prosseguir.", Exclamation!)
	Return -1
End If

ll_row						= dw_2.GetRow()
lvl_Filial					= dw_2.Object.cd_filial						[ll_row]
lvl_PedidoEmpurrado	= dw_2.Object.nr_pedido_empurrado	[ll_row]
lvl_produto 				= dw_2.Object.cd_produto					[ll_row]

ls_chave_pesquisa = String(lvl_Filial) +  '@#!' + String(lvl_PedidoEmpurrado) +  '@#!' + String(lvl_produto)

// Abre a Tela com a Chave para DataWindow
If Len(ls_chave_pesquisa) > 0 Then
	Openwithparm(w_ge135_historico_alteracao, ls_chave_pesquisa)
End If
end event

type cb_descancelar from commandbutton within w_ge415_pedido_empurrado_filial
integer x = 3209
integer y = 24
integer width = 594
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Descancelar Produto"
end type

event clicked;dw_1.AcceptText()
dw_2.AcceptText()

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tem certeza que deseja DESCANCELAR o produto do pedido?", Question!, YesNo!, 2) = 2 Then Return -1

If Not ivo_Pedido.of_Descancela_Produto_Pedido(dw_1.Object.Cd_Filial[1], ivl_pedido_existente, dw_2.Object.Cd_Produto[dw_2.GetRow()]) Then Return -1

SqlCa.of_Commit();

dw_2.Event ue_Retrieve()
end event

type cb_motivo from commandbutton within w_ge415_pedido_empurrado_filial
integer x = 1765
integer y = 156
integer width = 672
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Atualizar Motivos Abaixo"
end type

event clicked;Boolean lb_Alterado = False //manter at$$HEX1$$e900$$ENDHEX$$ verificar com o Engelberto

String ls_De_Motivo_Novo,&
		ls_De_Motivo
		
Long ll_Linha,&
	   ll_Cod_Motivo,&
	   ll_Cod_Motivo_Novo	
		
//cd_motivo_empurrado
dw_1.AcceptText()

ll_Cod_Motivo = dw_1.Object.cd_motivo [1]

If dw_2.RowCount() = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem registros para serem atualizados.")
	Return -1
End If

If IsNull(ll_Cod_Motivo) Or ll_Cod_Motivo = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Valor do [Motivo] deve ser diferente de Nenhum.")
	dw_1.Event ue_Pos(1, "cd_motivo")
	Return -1
End If

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Todos os registros abaixo SEM MOTIVO selecionado ser$$HEX1$$e300$$ENDHEX$$o substituidos." + &
					"~r~rDeseja continuar mesmo assim?", Question!, YesNo!, 2) = 2 Then Return -1


ls_De_Motivo = dw_1.Describe ("Evaluate('LookupDisplay(cd_motivo)', " + String(1) + ")")

For ll_Linha = 1 To dw_2.RowCount()
	ll_Cod_Motivo_Novo  = dw_2.Object.cd_motivo_empurrado[ll_Linha]
	
	If IsNull(ll_Cod_Motivo_Novo) Then
		dw_2.Object.cd_motivo_empurrado[ll_Linha] = ll_Cod_Motivo
		
		lb_Alterado = True
	End If
Next

//Aguardando valida$$HEX2$$e700e300$$ENDHEX$$o do GC
If lb_Alterado Then
	ivm_Menu.mf_Confirmar(True)
	ivm_Menu.mf_Cancelar(True)
	
	ivb_Valida_Salva = True
	//dw_1.Enabled = False
	dw_1.Object.nm_filial.Protect = 1
End If
end event

