HA$PBExportHeader$w_ge578_pedido_pescador_manual.srw
forward
global type w_ge578_pedido_pescador_manual from dc_w_sheet
end type
type gb_2 from groupbox within w_ge578_pedido_pescador_manual
end type
type gb_1 from groupbox within w_ge578_pedido_pescador_manual
end type
type dw_1 from dc_uo_dw_base within w_ge578_pedido_pescador_manual
end type
type dw_2 from dc_uo_dw_base within w_ge578_pedido_pescador_manual
end type
type cb_1 from commandbutton within w_ge578_pedido_pescador_manual
end type
end forward

global type w_ge578_pedido_pescador_manual from dc_w_sheet
integer width = 3566
integer height = 1716
string title = "GE578 - Inser$$HEX2$$e700e300$$ENDHEX$$o Manual de Pedido Pescador"
boolean controlmenu = false
boolean resizable = false
event ue_retrieve ( )
gb_2 gb_2
gb_1 gb_1
dw_1 dw_1
dw_2 dw_2
cb_1 cb_1
end type
global w_ge578_pedido_pescador_manual w_ge578_pedido_pescador_manual

type variables
uo_produto  ivo_produto
uo_filial	ivo_filial

Long il_Contador_Lote_Controlados, il_filial_referencia_preco_venda, il_nr_pedido_filial, il_cd_filial

Date		idt_data
Dec		idc_pc_limite_aceite_preco_distrib
String	is_bloq_compra_maior_limite, is_uf_filial, is_rede_filial

Long		il_resp_libera_produto_bahia = 0

end variables

forward prototypes
public subroutine wf_inicializar ()
public subroutine wf_localiza_filial ()
public function boolean wf_localiza_odbc_destino (long pl_filial)
public function boolean wf_saldo_flow (long al_produto, ref long al_saldo_flow)
public function boolean wf_possui_saldo_positivo (long pl_produto, long pl_filial_destino, ref long rf_saldo)
public function boolean wf_possui_saldo_wms (long pl_produto, ref long rf_saldo)
public function boolean wf_valida_dh_movimentacao_parametro ()
public function boolean wf_localiza_estoque_base (long al_cd_filial, long al_cd_produto, ref long al_qt_estoque_base)
public function boolean wf_localiza_saldo_filial (long al_cd_filial, long al_cd_produto, ref long al_qt_saldo_final)
public function boolean wf_inclui_pedido_filial (long al_cd_filial)
public function boolean wf_localiza_parametro_aceite_preco ()
public function boolean wf_filial_referencia_preco_venda (long al_cd_filial)
public function boolean wf_preco_venda (long al_cd_produto, decimal adc_fator_conv, ref decimal adc_preco_venda)
public function boolean wf_inclui_pedido_filial_item (long al_nr_pedido_filial, long al_cd_filial, long al_cd_produto, decimal adc_fator_conv, long al_saldo, long al_qtde_sugerida, long al_qtde_pedida, decimal adc_custo, long al_promocao, long al_estoque_minimo, long al_reforco, long al_reforco_estoque, decimal adc_cobertura_extra, decimal adc_demanda_diaria, long al_dias_cobertura, string as_classe_reposicao, long al_qtd_remanej, string as_alteracao_eb, string as_alteracao_eb_alterada, string as_cd_grupo, string as_id_lei_generico)
public function boolean wf_pedido_gerando (datetime adt_pedido)
public function boolean wf_gera_picking ()
public function boolean wf_carrega_saldo_conta_corrente ()
public function boolean wf_processar_picking ()
public function boolean wf_separar_nao_controlado (long al_nr_pedido_distribuidora, long al_cd_filial)
public function boolean wf_insere_lote (long al_filial, long al_pedido, long al_volume, long al_produto, string as_endereco, string as_lote, long al_qtde, ref string as_erro)
public function boolean wf_gera_abast (date adt_pedido)
public function boolean wf_localiza_produto ()
public function boolean wf_insere_produtos_via_planilha (string as_arquivo)
end prototypes

public subroutine wf_inicializar ();ivm_Menu.mf_Recuperar(False)
ivm_Menu.mf_Confirmar(False)
ivm_Menu.mf_Cancelar(False)
ivm_Menu.mf_Excluir(False)

dw_1.SetReDraw(False)
dw_1.Reset()
dw_1.InsertRow(0)
dw_1.Enabled = True
dw_1.SetFocus()
dw_1.SetReDraw(True)

dw_2.SetReDraw(False)
dw_2.Reset()
dw_2.SetReDraw(True)

il_Contador_Lote_Controlados=0

if Not wf_localiza_parametro_aceite_preco() Then Close(This)

end subroutine

public subroutine wf_localiza_filial ();STRING lvs_Filial, ls_erro


// Verifica o par$$HEX1$$e200$$ENDHEX$$metro digitado pelo usu$$HEX1$$e100$$ENDHEX$$rio
lvs_Filial = dw_1.GetText()

ivo_Filial.of_Localiza_Filial(lvs_Filial)

// Verifica se a Filial foi localizada e atualiza a DW
If ivo_Filial.Localizada Then
	If ivo_Filial.id_Situacao <> "A" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","A filial " + ivo_Filial.nm_fantasia + " n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ ativa.")
		Return
	End If
	
	If Not wf_Localiza_Odbc_destino(ivo_Filial.cd_filial) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado o par$$HEX1$$e200$$ENDHEX$$metro de conex$$HEX1$$e300$$ENDHEX$$o com a filial selecionada.~r" + &
						"Verifique se a filial j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ ativa.",Exclamation!)
		Return
	End If
	
	if Not wf_filial_referencia_preco_venda(ivo_Filial.cd_filial) Then
		Return
	End If

	dw_1.Object.cd_filial	[1] = ivo_Filial.cd_filial
	dw_1.Object.nm_filial	[1] = ivo_Filial.nm_fantasia
	
	ivm_Menu.mf_Incluir(True)
	
	If dw_2.Find("isnull(cd_produto)", 1, dw_2.RowCount()) > 0 Then
		dw_2.SetFocus()
	Else
		dw_2.InsertRow(0)
		dw_2.SetFocus()
	End If
	
	select c.cd_unidade_federacao, 
			 f.id_rede_filial
  	  Into :is_UF_Filial, 
			 :is_Rede_Filial
  	  From cidade c
	 inner join filial f
		      on f.cd_cidade = c.cd_cidade
 	 Where f.cd_filial = :ivo_Filial.cd_filial
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode 
		Case 0
		Case 100
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "UF da filial '" + String(ivo_Filial.cd_filial) + "' n$$HEX1$$e300$$ENDHEX$$o foi localizada ou Codigo da Cidade.", StopSign!)
			Return
		Case -1
			ls_erro	= SQLCA.SQLErrText
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao buscar UF da filial '" + String(ivo_Filial.cd_filial) + ". " + ls_erro, StopSign!)
			Return
	End Choose
Else
	ivo_Filial.of_Inicializa()
	
	dw_1.Object.cd_filial	[1] = ivo_filial.cd_filial
	dw_1.Object.nm_filial	[1] = ivo_filial.nm_fantasia
End If

end subroutine

public function boolean wf_localiza_odbc_destino (long pl_filial);Long lvl_Localizado

Select cd_filial
   Into :lvl_Localizado
from parametro_odbc
where cd_filial = :pl_Filial
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Return True
	Case 100
		Return False
	Case -1
		SqlCa.of_MsgdbError("Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro ODBC da filial destino")
		Return False
End Choose
end function

public function boolean wf_saldo_flow (long al_produto, ref long al_saldo_flow);
select coalesce(sum(b.qt_saldo), 0) 
Into :al_Saldo_Flow
from wms_endereco_produto a
inner join wms_localizacao b on b.cd_endereco = a.cd_endereco
where a.cd_produto = :al_Produto
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	Sqlca.of_MsgDbError('Localizar o saldo do produto no flow rack')
	Return False
End If		

Return True

end function

public function boolean wf_possui_saldo_positivo (long pl_produto, long pl_filial_destino, ref long rf_saldo);Long	ll_Saldo = 0,&
		ll_Saldo_Urgente


select dbo.saldo_atual_estoque_central(:pl_Filial_Destino, :pl_Produto, 'N')
Into :ll_Saldo
from produto_geral
where cd_produto = :pl_Produto
Using SqlCa;
	  
If SqlCa.SqlCode = -1 Then
	Sqlca.of_MsgDbError('Saldo Produto.')
	Return False
End If	

select coalesce(sum(b.qt_aprovada), 0)
into :ll_Saldo_Urgente
from pedido_empurrado a
inner join pedido_empurrado_produto b on b.cd_filial = a.cd_filial and b.nr_pedido_empurrado = a.nr_pedido_empurrado
where a.cd_filial = :pl_Filial_Destino
and a.id_situacao = 'S'
and a.id_tipo_pedido = 'U'
and a.id_processado = 'N'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		ll_Saldo += ll_Saldo_Urgente
	Case -1
		MessageBox("Erro","Erro ao verificar o saldo do pedido urgente da filial '" + String(pl_Produto) + "'.")
		Return False
End Choose
	
If ll_Saldo <= 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O produto:'" + String(pl_Produto) + "' n$$HEX1$$e300$$ENDHEX$$o possui saldo positivo em estoque para realizar a opera$$HEX2$$e700e300$$ENDHEX$$o. Acesse o Consulta Produto por Endere$$HEX1$$e700$$ENDHEX$$o!")
	Return False
Else	
	rf_saldo = ll_Saldo
	Return True
End if
end function

public function boolean wf_possui_saldo_wms (long pl_produto, ref long rf_saldo);Long ll_Saldo = 0


select qt_saldo 
Into	:ll_Saldo
from vw_saldo_produto_wms 
where cd_produto = :pl_Produto
and id_utiliza_saldo = 'S'
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	Sqlca.of_MsgDbError('Saldo Produto.')
	Return False
End If		
	
If ll_Saldo <= 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Os Endere$$HEX1$$e700$$ENDHEX$$os que tem saldo para o produto:'" + String(pl_Produto) + "' n$$HEX1$$e300$$ENDHEX$$o podem ser utilizados. Acesse o Consulta Produto por Endere$$HEX1$$e700$$ENDHEX$$o!")
	Return False
Else
	rf_saldo = ll_Saldo
	Return True
End if
end function

public function boolean wf_valida_dh_movimentacao_parametro ();DateTime	ldt_dh_movimentacao, ldt_dh_atual


select dh_movimentacao
  into :ldt_dh_movimentacao
  from parametro
 where id_parametro = '1'
using SQLCA;

Choose Case SQLCA.SQLCode
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar a coluna dh_movimentacao na tabela parametro. " + SQLCA.SQLErrText, StopSign!)
		Return False
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foram encontrados dados na tabela parametro.", StopSign!)
		Return False
	Case 0
		ldt_dh_atual	= gf_getserverdate()
		
		If Date(ldt_dh_movimentacao) < Date(ldt_dh_atual) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A Data de Movimenta$$HEX2$$e700e300$$ENDHEX$$o da tabela parametro est$$HEX1$$e100$$ENDHEX$$ menor que a data atual, n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel continuar essa opera$$HEX2$$e700e300$$ENDHEX$$o.", StopSign!)
			Return False
		End If
		
		Return True
End Choose
end function

public function boolean wf_localiza_estoque_base (long al_cd_filial, long al_cd_produto, ref long al_qt_estoque_base);al_qt_estoque_base	= 0

select qt_estoque_base
  into :al_qt_estoque_base
  from resumo_reposicao_estoque 
 where cd_filial	= :al_cd_filial
 	and cd_produto	= :al_cd_produto
using SQLCA;

Choose Case SQLCA.SQLCode
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar a coluna qt_estoque_base na tabela resumo_reposicao_estoque. " + SQLCA.SQLErrText, StopSign!)
		Return False
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foram localizados dados de reposi$$HEX2$$e700e300$$ENDHEX$$o de estoque. " + "~n Produto: " + String(al_cd_produto) + " Filial: " + String(al_cd_filial), StopSign!)
		Return False
End Choose

Return True
end function

public function boolean wf_localiza_saldo_filial (long al_cd_filial, long al_cd_produto, ref long al_qt_saldo_final);DateTime	ldt_dh_atual, ldt_dh_Saldo


ldt_dh_atual	= gf_getserverdate()
ldt_dh_Saldo	= DateTime(String(ldt_dh_atual, "01/mm/yyyy"))

select qt_saldo_final
  Into :al_qt_saldo_final
  from saldo_produto
 where cd_filial = :al_cd_filial
	and cd_produto = :al_cd_Produto
	and dh_saldo = :ldt_dh_Saldo
Using SqlCa;

Choose Case SQLCA.SQLCode
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o saldo do produto da filial selecionada. " + SQLCA.SQLErrText, StopSign!)
		Return False
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel localizar o saldo do produto da filial selecionada.", StopSign!)
		Return False
	Case 0
		Return True
End Choose
end function

public function boolean wf_inclui_pedido_filial (long al_cd_filial);DateTime	ldt_atual
Dec{2}	ldc_vl_custo, ldc_vl_fator_conversao, ldc_Total_Pedido
Long		ll_null, ll_for, ll_cd_Produto, ll_qt_estoque_filial, ll_qt_pedida, &
			ll_Promocao_Estoque_Minimo, ll_qt_remanejamento
String	ls_Mensagem, ls_cd_classe_reposicao, ls_cd_grupo, ls_id_lei_generico


SetNull(ll_null)
ldt_atual	= DateTime(Date(gf_getserverdate()))

Select coalesce(max(nr_pedido_filial), 0) + 1
Into :il_nr_pedido_filial
From pedido_filial
Where cd_filial = :al_cd_filial
Using SqlCa;

If Sqlca.SqlCode = -1 Then
	ls_Mensagem = "Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o do pr$$HEX1$$f300$$ENDHEX$$ximo pedido. " + SqlCa.SqlErrText 
	SqlCa.of_RollBack()
	Return False
End If

if wf_pedido_gerando(ldt_atual) then return false

Insert Into pedido_filial (cd_filial,   
									nr_pedido_filial,   
									dh_emissao,   
									vl_total_pedido,   
									nr_matricula_cadastramento,   
									id_situacao,   
									nr_prioridade_distribuidora,   
									id_geracao_matriz,
									dh_geracao,
									id_gerado_logistica,
									pc_limite_aceite_preco_distrib,
									id_bloq_compra_maior_limite,
									cd_filial_ref_preco_venda,
									nr_requisicao_sap,
									dh_rateio_estoque_central,
									id_rateio_estoque_central)  
						  Select :al_cd_filial,
									:il_nr_pedido_filial,
									dh_movimentacao,
									0,
									'14330',
									'C',
									0,
									'S',
									getdate(),
									'S',
									:idc_pc_limite_aceite_preco_distrib,
									:is_bloq_compra_maior_limite,
									:il_filial_referencia_preco_venda,
									:ll_null,
									getdate(),
									'S'
							 From parametro
Using SqlCa;
	
If SqlCa.SqlCode = -1 Then
	ls_Mensagem = "Erro na inclus$$HEX1$$e300$$ENDHEX$$o do pedido. " + SqlCa.SqlErrText 
	SqlCa.of_RollBack()
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_mensagem, StopSign!)
	Return False
End If

for ll_for = 1 to dw_2.RowCount()
	ll_cd_Produto	= dw_2.Object.cd_produto[ll_For]
	
	if IsNull(ll_cd_Produto) then continue
	
	ll_qt_pedida	= dw_2.Object.qt_pedida[ll_For]
	
	if ll_qt_pedida <= 0 then continue
	
	select qt_estoque_filial,
			 cd_classe_reposicao,
			 coalesce(qt_remanejamento, 0)
	  into :ll_qt_estoque_filial,
	  		 :ls_cd_classe_reposicao,
			 :ll_qt_remanejamento
	  from resumo_reposicao_estoque
	 where cd_produto	 	= :ll_cd_produto
	 	and cd_filial		= :al_cd_filial;
		 
	select vl_custo_gerencial
	  into :ldc_vl_custo
	  from produto_central
	 where cd_produto	= :ll_cd_produto;
	 
	select vl_fator_conversao,
			 substring(cd_subcategoria, 1, 1),
			 id_lei_generico
	  into :ldc_vl_fator_conversao,
	  		 :ls_cd_grupo,
			 :ls_id_lei_generico
	  from produto_geral
	 where cd_produto	= :ll_cd_produto;
	 
	ldc_vl_custo	= ldc_vl_custo * ldc_vl_fator_conversao
	
	SetNull(ll_Promocao_Estoque_Minimo)

	If Not wf_Inclui_pedido_filial_item(il_nr_pedido_filial, &
													al_cd_filial, &
													ll_cd_Produto, &
													ldc_vl_fator_conversao,&
													ll_qt_estoque_filial, &
													ll_qt_pedida, &
													ll_qt_pedida, &
													ldc_vl_custo, &
													ll_Promocao_Estoque_Minimo,&
													0,&
													0,&
													0,&
													0,&
													0,&
													0,&
													ls_cd_classe_reposicao, &
													ll_qt_remanejamento,&
													'N',&
													'N', &
													ls_cd_grupo, &
													ls_id_lei_generico) Then
		Return False
	End If
	
	ldc_Total_Pedido += Round(ldc_vl_custo * ll_qt_pedida, 2)
next

if ldc_Total_Pedido > 0 then
	Update pedido_filial
		Set vl_total_pedido = :ldc_Total_Pedido
	 Where cd_filial        = :al_cd_filial
	   and nr_pedido_filial = :il_nr_pedido_filial
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		ls_Mensagem = "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do total do pedido. " + SqlCa.SqlErrText 
		SqlCa.of_RollBack()
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_mensagem, StopSign!)
		Return False
	End If
end if

SqlCa.of_Commit()

uo_ro034_distribui_pedido lo
lo = create uo_ro034_distribui_pedido
lo.of_processa_distribuicao(al_cd_filial, il_nr_pedido_filial, 'S')
destroy lo

if not wf_gera_picking() then
	SqlCa.of_Rollback()
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao realizar o picking", StopSign!)
	return false
end if

Return True
end function

public function boolean wf_localiza_parametro_aceite_preco ();String	ls_Parametro, ls_Erro


Select vl_parametro 
  Into :is_bloq_compra_maior_limite
  From parametro_geral
 Where cd_parametro = 'ID_BLOQ_COMPRA_MAIOR_LIMITE'
Using SqlCa;

Choose Case SqlCa.SqlCode 
	Case 0
		If Upper(is_bloq_compra_maior_limite) <>  'S' and Upper(is_bloq_compra_maior_limite) <>  'N' Then
			SqlCa.of_RollBack();
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metro geral [ID_BLOQ_COMPRA_MAIOR_LIMITE] diferente do esperado (S/N). ", StopSign!)
			Return False
		End If
	Case 100
		is_bloq_compra_maior_limite = 'N'
	Case -1
		ls_Erro	= SQLCA.SQLErrText
		SqlCa.of_RollBack();
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Localiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro geral [ID_BLOQ_COMPRA_MAIOR_LIMITE]. " + ls_Erro, StopSign!)
		Return False
End Choose

Select vl_parametro 
  Into :ls_Parametro
  From parametro_geral
 Where cd_parametro = 'PC_LIMITE_ACEITE_PRECO_DISTRIB'
Using SqlCa;

Choose Case SqlCa.SqlCode 
	Case 0
		idc_pc_limite_aceite_preco_distrib = dec(ls_Parametro)
	Case 100
		SqlCa.of_RollBack();
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metro geral [PC_LIMITE_ACEITE_PRECO_DISTRIB] n$$HEX1$$e300$$ENDHEX$$o foi localizado.", StopSign!)
		Return False		
	Case -1
		ls_Erro	= SQLCA.SQLErrText
		SqlCa.of_RollBack();
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Localiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro geral [PC_LIMITE_ACEITE_PRECO_DISTRIB]. " + ls_Erro, StopSign!)
		Return False
End Choose

Return True
end function

public function boolean wf_filial_referencia_preco_venda (long al_cd_filial);Long 		ll_Produtos
String 	ls_UF, ls_Rede, ls_erro


Select c.cd_unidade_federacao, 
		 coalesce(f.id_rede_filial, 'XX')
  Into :ls_UF, 
  		 :ls_Rede 
  From filial f
 Inner join cidade c
	 on c.cd_cidade 	= f.cd_cidade
 Where cd_filial 		= :al_cd_filial
Using SqlCa;	

Choose Case Sqlca.SqlCode
	Case 100
		Sqlca.of_RollBack();
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi encontrado registro na tabela filial.", StopSign!)
		
		Return False
	Case -1
		ls_erro	= SQLCA.SQLErrText
		Sqlca.of_RollBack();
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar registro na tabela filial. " + ls_erro, StopSign!)
		
		Return False
End Choose

Choose Case ls_UF
	Case 'SP'; il_filial_referencia_preco_venda = 402
	Case 'MS'; il_filial_referencia_preco_venda = 950		
	Case 'PR'; il_filial_referencia_preco_venda = 753
	Case 'RS'; il_filial_referencia_preco_venda = 799
	Case 'BA'; il_filial_referencia_preco_venda = 603
	Case 'SC'
		If ls_Rede = 'XX' Then
			Sqlca.of_RollBack();			
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Filial esta sem rede definida. " + String(al_cd_Filial), StopSign!)
			Return False
		End If
		
		If ls_Rede = 'PP' Then
			il_filial_referencia_preco_venda = 737
		Else
			il_filial_referencia_preco_venda = 149
		End If
	Case Else
		Sqlca.of_RollBack();
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "UF n$$HEX1$$e300$$ENDHEX$$o prevista. " + String(al_cd_Filial), StopSign!)
		Return False
End Choose

Select count(*)
  Into :ll_Produtos
  from preco_venda_filial
 where cd_filial 	= :il_filial_referencia_preco_venda
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	Sqlca.of_RollBack();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar os pre$$HEX1$$e700$$ENDHEX$$os de venda da filial refer$$HEX1$$ea00$$ENDHEX$$ncia '" + String(il_filial_referencia_preco_venda), StopSign!)
	Return False
End If

If ll_Produtos = 0 Then
	Sqlca.of_RollBack();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foram localizados os pre$$HEX1$$e700$$ENDHEX$$os de venda para da filial refer$$HEX1$$ea00$$ENDHEX$$ncia '" + String(il_filial_referencia_preco_venda), StopSign!)
	Return False
End If

Return True 
end function

public function boolean wf_preco_venda (long al_cd_produto, decimal adc_fator_conv, ref decimal adc_preco_venda);String	ls_erro


Select coalesce(vl_preco_liquido, 0)
Into :adc_preco_venda
from preco_venda_filial
where cd_produto = :al_cd_Produto
  	and cd_filial 	= :il_filial_referencia_preco_venda
Using SqlCa;

Choose Case SqlCa.Sqlcode
	Case 0
	Case 100
		adc_preco_venda = 0.00
	Case -1
		ls_erro = SqlCa.SqlErrText
		Sqlca.of_RollBack();
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Localiza$$HEX2$$e700e300$$ENDHEX$$o do pre$$HEX1$$e700$$ENDHEX$$o de venda do produto '" + String(al_cd_Produto) + "' do pedido da filial refer$$HEX1$$ea00$$ENDHEX$$ncia. " + ls_erro, StopSign!)
		Return False
End Choose

adc_preco_venda = round(adc_preco_venda * adc_fator_conv, 2)
end function

public function boolean wf_inclui_pedido_filial_item (long al_nr_pedido_filial, long al_cd_filial, long al_cd_produto, decimal adc_fator_conv, long al_saldo, long al_qtde_sugerida, long al_qtde_pedida, decimal adc_custo, long al_promocao, long al_estoque_minimo, long al_reforco, long al_reforco_estoque, decimal adc_cobertura_extra, decimal adc_demanda_diaria, long al_dias_cobertura, string as_classe_reposicao, long al_qtd_remanej, string as_alteracao_eb, string as_alteracao_eb_alterada, string as_cd_grupo, string as_id_lei_generico);Decimal 	ldc_Preco_Venda, lvdc_pc_limite_aceite_preco_distrib
Long 		lvl_cd_bloqueio, ll_qt_estoque_base
String 	ls_mensagem, ls_erro


If Not wf_preco_venda(al_cd_produto, adc_fator_conv, Ref ldc_Preco_Venda) Then Return False

if not f_ge568_busca_dados_bloqueio(al_cd_produto, as_cd_grupo, is_uf_filial, is_rede_filial, as_id_lei_generico, lvl_cd_bloqueio, REF lvdc_pc_limite_aceite_preco_distrib, REF ls_mensagem) then 
	Sqlca.of_RollBack();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao buscar dados do bloqueio. " + ls_mensagem, StopSign!)
	Return False
end if

select qt_estoque_base
  into :ll_qt_estoque_base
  from resumo_reposicao_estoque
 where cd_produto	= :al_cd_produto
 	and cd_filial	= :al_cd_filial;

Choose Case SQLCA.SQLCode
	Case -1
		ls_erro	= SQLCA.SQLErrText
		Sqlca.of_RollBack();
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao buscar o estoque base. " + ls_erro, StopSign!)
		Return False		
	Case 100
		Sqlca.of_RollBack();
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao buscar o estoque base. " + ls_erro, StopSign!)
		Return False		
End Choose

Insert Into pedido_filial_produto (cd_filial,   
											  nr_pedido_filial,   
											  cd_produto,   
											  qt_saldo_momento,   
											  qt_sugerida,   
											  qt_pedida,   
											  qt_rateada,
											  vl_custo_unitario,   
											  nr_pedido_distribuidora,
											  cd_promocao_sos,
											  qt_estoque_base,
											  qt_estoque_minimo,
											  qt_dias_reforco,
											  qt_dias_reforco_estoque,
											  qt_cobertura_extra,
											  qt_demanda_diaria,
											  qt_dias_cobertura,
											  cd_classe_reposicao,
											  vl_preco_venda_filial,
											  qt_remanejamento,
											  id_alteracao_eb,
											  id_alteracao_eb_alterada,
											  cd_bloqueio_preco,
											  pc_limite_aceite_preco_distrib)  
Values (:al_cd_filial,
        :al_nr_pedido_filial,
		  :al_cd_produto,
		  :al_Saldo, &
		  :al_Qtde_Sugerida, &
		  :al_Qtde_Pedida, &
		  :al_Qtde_Pedida, &
		  :adc_Custo, &
		  null,
		  :al_Promocao,
		  :ll_qt_estoque_base,
		  :al_estoque_minimo,
		  :al_reforco,
		  :al_reforco_estoque,
		  :adc_cobertura_extra,
		  :adc_demanda_diaria,
		  :al_dias_cobertura,
		  :as_classe_reposicao,
		  :ldc_Preco_Venda,
		  :al_qtd_remanej,
		  :as_alteracao_eb,
		  :as_alteracao_eb_alterada,
		  :lvl_cd_bloqueio,
		  coalesce(:lvdc_pc_limite_aceite_preco_distrib, :idc_pc_limite_aceite_preco_distrib))
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_erro	= SQLCA.SQLErrText
	Sqlca.of_RollBack();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao inserir na pedido_filial_produto. " + ls_erro, StopSign!)
	Return False
Else
	Return True
End If
end function

public function boolean wf_pedido_gerando (datetime adt_pedido);Long 		ll_Achou
DateTime lvdh_termino


select dh_termino_geracao
  Into :lvdh_termino
  from controle_geracao_pedido
 where id_multitask_logistica = 'S'
   and dh_pedido = :adt_pedido
Using SqlCa;

Choose Case SqlCa.Sqlcode
	Case 0
		Select count(*) 
		  Into :ll_Achou
		  From pedido_filial
		 Where dh_emissao = :adt_pedido
		  	and id_gerado_logistica = 'S'
		Using SqlCa;
		
		If SqlCa.Sqlcode = -1 Then
			SqlCa.of_RollBack()
			MessageBox("Erro","Erro ao localizar se existem pedidos gerados. " + SqlCa.SqlErrText)
			Return True
		End If
		
		If ll_Achou > 0 Then
			If gvo_Aplicacao.ivo_Seguranca.nr_matricula = '14231' or &
			gvo_Aplicacao.ivo_Seguranca.nr_matricula = '14174' or &
			gvo_Aplicacao.ivo_Seguranca.nr_matricula = '215117' or &
			gvo_Aplicacao.ivo_Seguranca.nr_matricula = '505091' or &
			gvo_Aplicacao.ivo_Seguranca.nr_matricula = '505107' or &
			gvo_Aplicacao.ivo_Seguranca.nr_matricula = '995670' or &
			gvo_Aplicacao.ivo_Seguranca.nr_matricula = '505315' Then
				If MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o',  "O pedido ja est$$HEX1$$e100$$ENDHEX$$ sendo processado.~r~r" +  "Deseja continuar mesmo assim ?", Question!, YesNo!, 2) =2 Then
					Return True
				End If
				ll_Achou = 0
			End If	
		End If
		
		If ll_Achou > 0 Then
			Return False
		Else		
			Update controle_geracao_pedido
			   Set dh_inicio_geracao = getdate()
			 where id_multitask_logistica = 'S'
			  	and dh_pedido 				 = :adt_pedido
			Using SqlCa;
			
			If SqlCa.Sqlcode = -1 Then
				SqlCa.of_RollBack()
				MessageBox("Erro","Erro ao atualizar controle_geracao_pedido'. " + SqlCa.SqlErrText)
				Return True
			End If
			
			If Sqlca.SQLNRows = 1 Then
				SqlCa.of_Commit()
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O controle de gera$$HEX2$$e700e300$$ENDHEX$$o de pedido n$$HEX1$$e300$$ENDHEX$$o foi atualizado [wf_pedido_gerando]. ", StopSign!)
				Return True
			End If
			
			Return False
		End If
	Case 100
		INSERT INTO controle_geracao_pedido (id_multitask_logistica,   
												       dh_pedido,   
														 dh_inicio_geracao,   
														 dh_termino_geracao,
														 dh_inicio_corte_pedido,
														 dh_termino_corte_pedido) 			
												Values('S',
														 :adt_pedido,
														 GetDate(),
														 GetDate(),
														 GetDate(),
														 GetDate())
		Using SqlCa;
		
		If SqlCa.Sqlcode = -1 Then
			SqlCa.of_RollBack()
			MessageBox("Erro","Erro no insert controle_geracao_pedido'. " + SqlCa.SqlErrText)
			Return True
		End If
		
		SqlCa.of_Commit()
		Return False
End Choose

Return False
end function

public function boolean wf_gera_picking ();Date 		ldt_Parametro
String 	ls_MSG, ls_Anexo[]
Long 		ll_Lista_Separacao, ll_Pedido_Nao_Gerado


Select count(*)
  Into :ll_Pedido_Nao_Gerado
  From pedido_filial a
 where a.dh_emissao = :ldt_Parametro
   and a.id_gerado_logistica = 'S'
   and exists (select 1
					  from pedido_filial_produto p
				    where p.cd_filial = a.cd_filial
					   and p.nr_pedido_filial = a.nr_pedido_filial
					   and p.qt_rateada > 0)
   and not exists (select 1
							from pedido_distribuidora d
					     where d.cd_filial = a.cd_filial
						    and d.nr_pedido_filial = a.nr_pedido_filial
						    and d.id_pedido_almoxarifado = 'N')
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_msg	= "Erro ao localizar os pedidos gerados do CD '" + SQLCA.SQLErrText + "'."
	
	SqlCa.of_RollBack()
	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_msg, StopSign!)
	Return False
End If

If ll_Pedido_Nao_Gerado > 0 Then
	ls_msg	= "Total de lojas '" + String(ll_Pedido_Nao_Gerado) + "' n$$HEX1$$e300$$ENDHEX$$o gerou o pedido para o estoque central." +&
				  "Ser$$HEX1$$e100$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio distribuir as lojas faltantes e depois gerar o picking - Objeto: w_ro033_geracao_pedido_filial na fun$$HEX2$$e700e300$$ENDHEX$$o wf_gera_picking."

	SqlCa.of_RollBack()
	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o",  ls_msg, StopSign!)
	Return False
End If

Select count(*)
  Into :ll_Lista_Separacao
  From pedido_distribuidora p
 Where p.id_situacao = 'S'
   and exists (select 1 
				     from wms_lista_separacao w
				    where w.cd_filial = p.cd_filial
					   and w.nr_pedido_distribuidora = p.nr_pedido_distribuidora)
   and p.dh_emissao 					= :ldt_Parametro
   and p.id_pedido_almoxarifado 	= 'N'
Using SqlCa;
	
If SqlCa.SqlCode = -1 Then
	ls_msg = "Erro ao verificar a exist$$HEX1$$ea00$$ENDHEX$$ncia de lista de separa$$HEX2$$e700e300$$ENDHEX$$o para a exclus$$HEX1$$e300$$ENDHEX$$o dos registros da WMS_RESERVA_FLOW_RACK '" + SQLCA.SQLErrText + "'."
	
	SqlCa.of_RollBack()
	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o",  ls_msg, StopSign!)
	Return False
End If	
	
If ll_Lista_Separacao > 0 Then
	SqlCa.of_RollBack()
	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "J$$HEX1$$e100$$ENDHEX$$ existe lista de separa$$HEX2$$e700e300$$ENDHEX$$o para os pedidos que foram gerados no dia '" + String(ldt_Parametro) + "', neste caso a reserva n$$HEX1$$e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ ser exclu$$HEX1$$ed00$$ENDHEX$$da [PINCKING N$$HEX1$$c300$$ENDHEX$$O FOI GERADO].")
	
	Return False
End If

Delete From wms_reserva_flow_rack
Using SqlCa;
	
If SqlCa.SqlCode = -1 Then
	ls_msg = "Erro ao excluir os registros da tabela wms_reserva_flow_rack '" + SQLCA.SQLErrText + "'."
	
	SqlCa.of_RollBack()
	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o",  ls_msg, StopSign!)
Else
	SqlCa.of_Commit()		
End If

Delete From wms_reserva_pulmao
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_msg = "Erro ao excluir os registros da tabela wms_reserva_pulmao '" + SQLCA.SQLErrText + "'."
	
	SqlCa.of_RollBack()
	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o",  ls_msg, StopSign!)
Else
	SqlCa.of_Commit()
End If
	
uo_ge259_pedido_filial lds
lds = Create uo_ge259_pedido_filial

If Not lds.of_processa_geracao_picking() Then Return False

Destroy(lds)

Return True
end function

public function boolean wf_carrega_saldo_conta_corrente ();Long 		ll_Qtd, ll_Linha, ll_Linhas, ll_Produto, ll_Saldo_Utilizado
String 	ls_MSG, lvs_Endereco


Select Coalesce(count(*),0) 
  Into :ll_Qtd
  From wms_localizacao_pedido_cc
 Where dh_pedido = :idt_data
Using SqlCA;

If SqlCa.SqlCode = -1  Then 
	ls_MSG = "Erro ao Consultar os dados na WMS_LOCALIZACAO_PEDIDO_CC '" + SQLCA.SQLErrText + "'."
	SqlCa.of_RollBack()
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_MSG, StopSign!)
	Return False
Else
	If ll_Qtd = 0 Then 
		Insert Into wms_localizacao_pedido_cc (dh_pedido,  
															cd_endereco, 
															cd_produto, 
															nr_lote, 
															qt_saldo, 
															qt_saldo_utilizado) 
										 		  Select :idt_data, 
															w.cd_endereco, 
															w.cd_produto, 
															w.nr_lote, 
															sum(w.qt_saldo * w.qt_caixa_padrao), 
															0
											 		 From wms_localizacao w
											 Inner join wms_endereco e on e.cd_endereco = w.cd_endereco
											 Inner join wms_bairro b on b.cd_bairro = e.cd_bairro
											 Inner join produto_geral g on g.cd_produto = w.cd_produto
												   Where b.id_flow_rack = 'S'
												     And g.cd_grupo_psico is not null
												Group by w.cd_endereco, 
															w.cd_produto, 
															w.nr_lote
		Using SqlCA;

		If Sqlca.SqlCode = -1 Then
			ls_MSG = 	"Erro ao Inserir na WMS_LOCALIZACAO_PEDIDO_CC '" + SQLCA.SQLErrText + "'."
			SqlCa.of_RollBack()
			Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_MSG, StopSign!)
			Return False
		End If
	Else
		Delete From wms_localizacao_pedido_cc
				Where dh_pedido=:idt_data
		Using SqlCA;
		
		If Sqlca.SqlCode = -1 Then
			ls_MSG = "Erro ao Apagar os dados da WMS_LOCALIZACAO_PEDIDO_CC '" + SQLCA.SQLErrText + "'."
			SqlCa.of_RollBack()
			Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_MSG, StopSign!)
			Return False
		End If
		
		Insert Into wms_localizacao_pedido_cc (dh_pedido,
															cd_endereco, 
															cd_produto, 
															nr_lote, 
															qt_saldo, 
															qt_saldo_utilizado) 
												  Select :idt_data, 
												  		 	w.cd_endereco, 
															w.cd_produto, 
															w.nr_lote, 
															sum(w.qt_saldo * w.qt_caixa_padrao), 
															0
												    From wms_localizacao w
											 Inner join wms_endereco e on e.cd_endereco = w.cd_endereco
											 Inner join wms_bairro b on b.cd_bairro = e.cd_bairro
											 Inner join produto_geral g on g.cd_produto = w.cd_produto
												   Where b.id_flow_rack = 'S'
												     And g.cd_grupo_psico is not null
												Group by w.cd_endereco, 
															w.cd_produto, 
															w.nr_lote
		Using SqlCA;

		If Sqlca.SqlCode = -1 Then
			ls_MSG = "Erro ao Inserir na WMS_LOCALIZACAO_PEDIDO_CC '" + SQLCA.SQLErrText + "'."
			SqlCa.of_RollBack()
			Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_MSG, StopSign!)
			Return False
		End If 
	End If 
End If 

// Ser$$HEX1$$e100$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio sempre verificar se n$$HEX1$$e300$$ENDHEX$$o existem volumes que ainda n$$HEX1$$e300$$ENDHEX$$o foram conferidos
dc_uo_ds_base lds_NaoConferidos
lds_NaoConferidos = Create dc_uo_ds_base

If Not lds_NaoConferidos.of_ChangeDataObject("dw_ge563_lista_pedidos_nao_conferidos", True) Then 
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao trocar a DW [dw_ge563_lista_pedidos_nao_conferidos].", StopSign!)
	SqlCa.of_Rollback()
	Return False
End If

ll_Linhas = lds_NaoConferidos.Retrieve(idt_data)

For ll_Linha = 1 To ll_Linhas 
	ll_Produto				= lds_NaoConferidos.Object.cd_produto [ll_Linha]						
	lvs_Endereco 			= lds_NaoConferidos.Object.cd_endereco_localizacao [ll_Linha]
	ll_Saldo_Utilizado 	= lds_NaoConferidos.Object.qt_saldo_utilizado [ll_Linha]						

	Update wms_localizacao_pedido_cc
	   Set  qt_saldo_utilizado =:ll_Saldo_Utilizado
	 Where cd_produto =:ll_Produto
	   And  cd_endereco=:lvs_Endereco
	Using SqlCA;
	
	If Sqlca.SqlCode = -1 Then
		ls_MSG = "Erro ao Atualizar o qt_saldo_utilizado da WMS_LOCALIZACAO_PEDIDO_CC '" + SQLCA.SQLErrText + "'."
		SqlCa.of_RollBack()
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_MSG, StopSign!)
		Return False
	End If 			
Next 
	
SqlCa.of_commit( )

Return True
end function

public function boolean wf_processar_picking ();Boolean	lb_Pedido_Almoxarifado = False, lb_Pedido_Controlado = True, lb_Sucesso = True
Long		ll_Filial, ll_Pedido_distribuidora, ll_Linhas, ll_for
String	ls_MSG, ls_Anexo

dc_uo_ds_base lds_lista_pedido_distribuidora
uo_ge259_pedido_filial luo_pedido_filial

try

	lds_lista_pedido_distribuidora = Create dc_uo_ds_base
	
	If Not lds_lista_pedido_distribuidora.of_ChangeDataObject("ds_ge578_lista_pedido_distribuidora", True) Then 
		SqlCa.of_Rollback()
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao trocar a DW [ds_ge578_lista_pedido_distribuidora].", StopSign!)		
		Return False
	End If

	ll_Filial	= dw_1.Object.cd_filial[1] 

	ll_Linhas = lds_lista_pedido_distribuidora.Retrieve(il_nr_pedido_filial, ll_Filial)

	Open(w_Aguarde)
	
	for ll_for = 1 to ll_Linhas
		luo_pedido_filial = Create uo_ge259_pedido_filial
		
		ll_pedido_distribuidora	= lds_lista_pedido_distribuidora.Object.nr_pedido_distribuidora[ll_for]
		
		If Not luo_pedido_filial.of_processa_geracao_picking(ll_Filial, ll_Pedido_distribuidora, lb_Pedido_Almoxarifado, lb_Pedido_Controlado, idt_data) Then 
			lb_Sucesso = False
			ls_MSG = "Erro ao gerar picking para Filial:"+String(ll_Filial) + "Pedido:" + String(ll_Pedido_distribuidora) +". Entre em Contato com TI" 
			SqlCa.of_RollBack()
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_MSG )
			Return False
		End If 
	next
finally
	Close(w_Aguarde)
	Destroy(luo_pedido_filial)
	
	return lb_Sucesso
end try

return false
end function

public function boolean wf_separar_nao_controlado (long al_nr_pedido_distribuidora, long al_cd_filial);Long		ll_itens, ll_quantidades, ll_linhas, ll_for, ll_cd_produto, ll_linhas_lote, &
			ll_for_lote, ll_qt_lote, ll_sequencial, ll_qt_separada, ll_qt_temp, ll_nr_volume
String	ls_matricula, ls_erro, ls_grupo_nao_psico, ls_cd_grupo_psico, ls_id_controlado, &
			ls_cd_endereco, ls_lote

dc_uo_ds_base	lds_lista_pedido_distribuidora_produtos, ldc_lista_produto_separacao


ls_matricula = gvo_Aplicacao.ivo_seguranca.nr_matricula	

lds_lista_pedido_distribuidora_produtos 	= Create dc_uo_ds_base
ldc_lista_produto_separacao 					= Create dc_uo_ds_base

update wms_lista_separacao 
	set dh_termino_separacao 		= :idt_data,
		 dh_inicio_conferencia 		= :idt_data,
		 nr_matricula_conferente	= :ls_matricula
 where nr_pedido_distribuidora 	= :al_nr_pedido_distribuidora and 
		 cd_filial 						= :al_cd_filial;
		 
Choose Case SQLCA.SQLCode
	Case -1
		ls_erro	= SQLCA.SQLErrText
		SQLCA.of_rollback()
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel atualizar a lista de separa$$HEX2$$e700e300$$ENDHEX$$o para apontar o in$$HEX1$$ed00$$ENDHEX$$cio da confer$$HEX1$$ea00$$ENDHEX$$ncia. ' + ls_erro, StopSign!)
		return False
End Choose

update wms_lista_separacao_produto
	set qt_separada = qt_pedida,
		 qt_divergencia = 0
 where nr_pedido_distribuidora 	= :al_nr_pedido_distribuidora and 
		 cd_filial 						= :al_cd_filial;
		 
Choose Case SQLCA.SQLCode
	Case -1
		ls_erro	= SQLCA.SQLErrText
		SQLCA.of_rollback()
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel atualizar o produto da lista de separa$$HEX2$$e700e300$$ENDHEX$$o para apontar a quantidade separada. ' + ls_erro, StopSign!)
		return False
End Choose

select count(*)
  into :ll_itens
  from wms_lista_separacao_produto
 where nr_pedido_distribuidora 	= :al_nr_pedido_distribuidora and 
		 cd_filial 						= :al_cd_filial;
		 
Choose Case SQLCA.SQLCode
	Case -1
		ls_erro	= SQLCA.SQLErrText
		SQLCA.of_rollback()
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel buscar a quantidade de produtos da lista de separa$$HEX2$$e700e300$$ENDHEX$$o. ' + ls_erro, StopSign!)
		return False
	Case 100
		SQLCA.of_rollback()
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'N$$HEX1$$e300$$ENDHEX$$o foi encontrados os produtos da lista de separa$$HEX2$$e700e300$$ENDHEX$$o.', StopSign!)
		return False
End Choose

select sum(qt_separada)
  into :ll_quantidades
  from wms_lista_separacao_produto
 where nr_pedido_distribuidora 	= :al_nr_pedido_distribuidora and 
		 cd_filial 						= :al_cd_filial;
		 
Choose Case SQLCA.SQLCode
	Case -1
		ls_erro	= SQLCA.SQLErrText
		SQLCA.of_rollback()
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel buscar o total das quantidades separadas de produtos da lista de separa$$HEX2$$e700e300$$ENDHEX$$o. ' + ls_erro, StopSign!)
		return False
	Case 100
		SQLCA.of_rollback()
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'N$$HEX1$$e300$$ENDHEX$$o foi encontrados os produtos da lista de separa$$HEX2$$e700e300$$ENDHEX$$o.', StopSign!)
		return False
End Choose

Update wms_lista_separacao
	Set dh_termino_conferencia 	= :idt_data,
		 qt_itens 						= :ll_itens,
		 qt_unidades 				 	= :ll_quantidades,
		 nr_matricula_conferente 	= :ls_matricula
 where nr_pedido_distribuidora 	= :al_nr_pedido_distribuidora and 
		 cd_filial 						= :al_cd_filial;

Choose Case SQLCA.SQLCode
	Case -1
		ls_erro	= SQLCA.SQLErrText
		SQLCA.of_rollback()
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel atualizar a lista de separa$$HEX2$$e700e300$$ENDHEX$$o para apontar o t$$HEX1$$e900$$ENDHEX$$rmino da confer$$HEX1$$ea00$$ENDHEX$$ncia. ' + ls_erro, StopSign!)
		return False
End Choose

Update pedido_distribuidora_produto
	Set qt_separada = qt_pedida 
 where nr_pedido_distribuidora 	= :al_nr_pedido_distribuidora and 
		 cd_filial 						= :al_cd_filial;
		 
Choose Case SQLCA.SQLCode
	Case -1
		ls_erro	= SQLCA.SQLErrText
		SQLCA.of_rollback()
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel atualizar a quantidade separada do pedido distribuidora. ' + ls_erro, StopSign!)
		return False
End Choose

If Not lds_lista_pedido_distribuidora_produtos.of_ChangeDataObject("ds_ge578_lista_pedido_distribuidora_produtos", True) Then 
	SqlCa.of_Rollback()
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao trocar a DW [ds_ge578_lista_pedido_distribuidora_produtos].", StopSign!)		
	Return False
End If

ll_linhas = lds_lista_pedido_distribuidora_produtos.Retrieve(al_nr_pedido_distribuidora, al_cd_filial)

for ll_for = 1 to ll_linhas
	ll_cd_produto 	= lds_lista_pedido_distribuidora_produtos.Object.cd_produto[ll_for]
	ll_qt_separada	= lds_lista_pedido_distribuidora_produtos.Object.qt_separada[ll_for]
	
	select cd_grupo_psico
	  into :ls_cd_grupo_psico
	  from produto_geral
	 where cd_produto = :ll_cd_produto;
	 
	Choose Case SQLCA.SQLCode
		Case -1
			ls_erro	= SQLCA.SQLErrText
			SQLCA.of_rollback()
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel buscar dados do produto separado. ' + ls_erro, StopSign!)
			return False
		Case 100
			SQLCA.of_rollback()
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'N$$HEX1$$e300$$ENDHEX$$o foi encontrados os dados do produto separado.', StopSign!)
			return False
	End Choose
	
	If gf_Grupo_Nao_Psico_Matriz(ls_cd_grupo_psico, ref ls_grupo_nao_psico) Then
		If ls_grupo_nao_psico = 'N' Then
			ls_id_controlado = 'S'
		else
			ls_id_controlado = 'N'
		End If
	End If
	
	select max(cd_endereco) 
	  into :ls_cd_endereco
 	  from wms_endereco_produto 
    where cd_produto = :ll_cd_produto;
	
	Choose Case SQLCA.SQLCode
		Case -1
			ls_erro	= SQLCA.SQLErrText
			SQLCA.of_rollback()
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel buscar o endere$$HEX1$$e700$$ENDHEX$$o do produto separado. ' + ls_erro, StopSign!)
			return False
		Case 100
	   	select max(cd_endereco) 
		  	  into :ls_cd_endereco
		  	  from wms_localizacao 
		    where cd_produto = :ll_cd_produto;
			 
			Choose Case SQLCA.SQLCode
				Case -1
					ls_erro	= SQLCA.SQLErrText
					SQLCA.of_rollback()
					MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel buscar o endere$$HEX1$$e700$$ENDHEX$$o do produto separado. ' + ls_erro, StopSign!)
					return False
				Case 100
					SQLCA.of_rollback()
					MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'N$$HEX1$$e300$$ENDHEX$$o foi encontrados o enbdere$$HEX1$$e700$$ENDHEX$$o do produto separado.', StopSign!)
					return False
			End Choose
	End Choose
	
	If Not ldc_lista_produto_separacao.of_ChangeDataObject("ds_ge578_lista_produto_separacao") Then
		SQLCA.of_rollback()
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', "Erro ao criar a 'ds_ge578_lista_produto_separacao'", StopSign!)
		return False
	End If
	
	ll_linhas_lote = ldc_lista_produto_separacao.Retrieve(ll_cd_produto, ls_cd_endereco)
				
	If (ll_linhas_lote < 0) or IsNull(ll_linhas_lote) Then
		SQLCA.of_rollback()
		MessageBox("Erro", "Erro no retrieve dos lotes dos produtos n$$HEX1$$e300$$ENDHEX$$o controlados.", StopSign!)
		return False
	End If
		
	If ll_linhas_lote > 0 Then
		For ll_for_lote = 1 To ll_linhas_lote
			ls_lote			= ldc_lista_produto_separacao.Object.nr_lote[ll_for_lote]
			ll_qt_lote 		= ldc_lista_produto_separacao.Object.qt_saldo[ll_for_lote]
			ll_sequencial	= ldc_lista_produto_separacao.Object.nr_sequencial[ll_for_lote]
			ll_nr_volume	= ldc_lista_produto_separacao.Object.nr_volume[ll_for_lote]
			
			If ll_qt_separada <= ll_qt_lote Then
				ll_qt_temp = ll_qt_separada						
			Else
				ll_qt_temp = ll_qt_lote					
			End If
								 
			If Not wf_Insere_Lote(al_cd_filial, al_nr_pedido_distribuidora, ll_nr_volume, ll_cd_produto, ls_cd_endereco, ls_lote, ll_qt_temp, Ref ls_erro) Then
				SQLCA.of_rollback()
				MessageBox("Erro", ls_erro, StopSign!)
				Return False	
			End If

			ll_qt_separada = ll_qt_separada - ll_qt_temp

			If ll_qt_separada > 0 and ll_for_lote = ll_linhas_lote Then
				If Not wf_Insere_Lote(al_cd_filial, al_nr_pedido_distribuidora, ll_nr_volume, ll_cd_produto, ls_cd_endereco, "LOTE CONF", ll_qt_separada, Ref ls_erro) Then
					Return False	
				End If
				
				ll_qt_separada = 0
			End If

			If ll_qt_separada = 0 Then
				Exit
			End If
		Next
	Else
		ls_lote 			= "SEM LOTE"
		ll_qt_lote 		= ll_qt_separada
		ll_Sequencial 	= 1
		ll_qt_Temp 		= ll_qt_separada
		
		If Not wf_Insere_Lote(al_cd_filial, al_nr_pedido_distribuidora, ll_nr_volume, ll_cd_produto, ls_cd_endereco, ls_lote, ll_qt_Temp, Ref ls_erro) Then
			Return False	
		End If
	End If
next

return True
end function

public function boolean wf_insere_lote (long al_filial, long al_pedido, long al_volume, long al_produto, string as_endereco, string as_lote, long al_qtde, ref string as_erro);String ls_Achou


Select nr_lote
Into :ls_Achou
From wms_lista_separacao_prd_lote
Where cd_filial 							= :al_Filial
  	and nr_pedido_distribuidora		= :al_Pedido
  	and cd_produto						= :al_produto
	and nr_volume						= :al_volume
	and cd_endereco_localizacao 	= :as_endereco
  	and nr_lote							= :as_Lote
Using SqlCa;

Choose Case SqlCa.Sqlcode
	Case 0
		
		  UPDATE wms_lista_separacao_prd_lote  
     		SET   qt_lote =   qt_lote +  :al_Qtde
		  Where	cd_filial						= :al_Filial
		  	 and 	nr_pedido_distribuidora 	= :al_Pedido
			 and 	cd_produto 					= :al_Produto
			 and nr_volume					= :al_volume
			and cd_endereco_localizacao 	= :as_endereco
			 and	nr_lote						= :as_Lote
		Using SqlCa;
		
		If SqlCa.SqlCode = - 1 Then
			as_Erro = "Erro ao atualizar o lote: "+Sqlca.sqlErrText
			Return False
		End If
		
	Case 100
		
		INSERT INTO wms_lista_separacao_prd_lote ( 
						cd_filial, 
						nr_pedido_distribuidora,  
						cd_produto,
						nr_volume,
						cd_endereco_localizacao,
						nr_lote, 
						qt_lote )  
		VALUES (:al_Filial, 
					:al_Pedido, 
					:al_Produto, 
					:al_volume,
					:as_endereco,
					:as_Lote, 
					:al_Qtde)
		Using SqlCa;
		
		If SqlCa.SqlCode = - 1 Then
			as_Erro = "Erro ao inserir o lote: "+Sqlca.sqlErrText
			Return False
		End If

	Case -1
		as_Erro = "Erro ao localizar o lote: "+Sqlca.sqlErrText
		Return False
End Choose

Return True
end function

public function boolean wf_gera_abast (date adt_pedido);String ls_Erro
//Date ldh_Data_Pedido

// Pega sempre de dois dias para tr$$HEX1$$e100$$ENDHEX$$s caso tenha algum pedido n$$HEX1$$e300$$ENDHEX$$o tenha sido faturado ainda.
//ldh_Data_Pedido = RelativeDate(ivdt_Pedido, -2)

Open(w_Aguarde)
w_Aguarde.Title = "Inserindo a Base p/ Gerar o Abastecimento"

// **** NESTE PONTO AINDA N$$HEX1$$c300$$ENDHEX$$O TEM PICKING DE CAIXA FECHADA, POR ESTE MOTIVO A qt_saida_pulmao E ATUALIZADA VIA TRIGGER
//A trigger wms_lista_separacao_produto ir$$HEX1$$e100$$ENDHEX$$ incluir os registros na tabela pedido_distribuidora_prd_abast [SOMENTE CAIXA FECHADA], por este motivo primeiro deve fazer um update (caso existam registros, depois faz o insert
//para os itens que n$$HEX1$$e300$$ENDHEX$$o foram gravados pela trigger

// O ABASTECIMENTO DEVE SER LIBERADO SOMENTE DEPOIS QUE TIVER GERADO O PICKING DE CAIXA FECHADA, AI A BASE ESTARA COMPLETA

update pedido_distribuidora_prd_abast
set ab.qt_atendida = pp.qt_atendida, ab.dh_alteracao = getdate()
from pedido_distribuidora_prd_abast ab
inner join pedido_distribuidora p on p.cd_filial = ab.cd_filial and p.nr_pedido_distribuidora = ab.nr_pedido_distribuidora
inner join pedido_distribuidora_produto pp on pp.cd_filial = p.cd_filial and pp.nr_pedido_distribuidora = p.nr_pedido_distribuidora and pp.cd_produto = ab.cd_produto
inner join pedido_filial f on f.cd_filial = p.cd_filial and f.nr_pedido_filial = p.nr_pedido_filial
where p.cd_distribuidora = '053404705'
and p.dh_emissao = :adt_Pedido
and f.id_gerado_logistica = 'S'
and p.id_situacao in ('C', 'S')
Using SqlCa;

If SqlCa.SqlCode = -1 Then	
	ls_Erro = SqlCa.SqlErrText
	SqlCa.of_Rollback();
	Close(w_Aguarde)
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao atualizar os registros da pedido_distribuidora na pedido_distribuidora_prd_abast. " + ls_Erro, StopSign!)
	Return False
End If

insert into pedido_distribuidora_prd_abast(id_multitask_logistica, dh_pedido, cd_filial, nr_pedido_distribuidora, cd_distribuidora, id_considera_abast, cd_produto, qt_atendida)
select f.id_gerado_logistica, :adt_Pedido, p.cd_filial, p.nr_pedido_distribuidora, p.cd_distribuidora, 'S', pp.cd_produto, pp.qt_atendida
from pedido_distribuidora p
	inner join pedido_distribuidora_produto pp
		on pp.cd_filial = p.cd_filial
		and pp.nr_pedido_distribuidora = p.nr_pedido_distribuidora
	inner join pedido_filial f
		on f.cd_filial = p.cd_filial
		and f.nr_pedido_filial = p.nr_pedido_filial
where p.cd_distribuidora = '053404705'
and p.dh_emissao = :adt_Pedido
and f.id_gerado_logistica = 'S'
and p.id_situacao in ('C', 'S')
and not exists (select * from pedido_distribuidora_prd_abast x
					where x.id_multitask_logistica 		= 'S'
						and x.dh_pedido 						= :adt_Pedido
						and x.cd_filial 						= p.cd_filial
					    and x.nr_pedido_distribuidora 	= p.nr_pedido_distribuidora
						and x.cd_distribuidora 				= p.cd_distribuidora
					    and x.cd_produto						= pp.cd_produto)
Using SqlCa;

If SqlCa.SqlCode = -1 Then	
	ls_Erro = SqlCa.SqlErrText
	SqlCa.of_Rollback();
	Close(w_Aguarde)
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gravar os registros da pedido_distribuidora na pedido_distribuidora_prd_abast. " + ls_Erro, StopSign!)
	Return False
End If

SqlCa.of_commit( )

Close(w_Aguarde)

Return True
end function

public function boolean wf_localiza_produto ();String  	lvs_Produto, &
			ls_Nr_Lote,&
			lvs_Parametro
Long 		ll_Find_dw3, &
			ll_qt_Saldo,&
			ll_Achou,&
			ll_Qtde_Lote = 1,&
			ll_Saldo_Flow,&
			ll_Qt_Saldo_Disponivel, &
			lvl_Find,&
	  		lvl_Linha,&
	  		ll_Filial, &
		   ll_qt_estoque_base, &
			ll_qt_estoque_filial
Boolean 	lb_Add_Produto_Dw2, &
			lb_Controlado 			= False

		  
SetPointer(HourGlass!)

dw_1.AcceptText()		 

lvs_Produto = Trim(dw_2.GetText())

ll_Filial	= dw_1.Object.cd_filial[1]

If IsNull(ll_Filial) or (ll_Filial < 1) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma filial.")
	dw_1.SetFocus()
	Return False
End If

ivo_Produto.of_localiza_produto(lvs_produto,false)

If ivo_Produto.Localizado Then
	If IsNull(ivo_Produto.Cd_Produto_SAP) Or ivo_Produto.Cd_Produto_SAP = "" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto sem cadastro no SAP n$$HEX1$$e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ ser selecionado.", Exclamation!)
		dw_2.Event ue_Pos(dw_2.GetRow(), "de_produto")
		Return False
	End If
	
	If ivo_Filial.cd_unidade_federacao <> "BA" Then
		If ivo_Produto.id_exclusivo_pedido_falta_ba = "S" Then
			if il_resp_libera_produto_bahia = 2 then
				Return False
			end if
			
			if il_resp_libera_produto_bahia = 0 then
				If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto exclusivo para atender pedidos de faltas da Bahia!"+".~Deseja Continuar?",Question!,YesNo!,2)=2 Then 
					il_resp_libera_produto_bahia	= 2
					Return False
				else
					il_resp_libera_produto_bahia	= 1
				End If
			end if
		End If
	End If
		
	// Adicionado para Bloqueio de Movimento de Vacinas
	If Not gf_parametro_filial_vacina(ll_Filial, ivo_produto.cd_produto) Then Return False		
	
	///Validacao Saldo Produto
	If Not wf_Possui_Saldo_Wms(ivo_produto.cd_produto, Ref ll_qt_Saldo) Then Return False
	
	//Validacao Saldo Produto
	If Not wf_Possui_Saldo_Positivo(ivo_produto.cd_produto, ll_Filial, Ref ll_Qt_Saldo_Disponivel) Then Return False
		
	//Localiza o estoque base do produto na filial
	If Not wf_localiza_estoque_base(ll_Filial, ivo_produto.cd_produto, Ref ll_qt_estoque_base) Then Return False
	
	//Localiza o estoque do produto na filial
	If Not wf_localiza_saldo_filial(ll_Filial, ivo_produto.cd_produto, Ref ll_qt_estoque_filial) Then Return False
	
	//Localiza o saldo no Flow
	If Not wf_Saldo_Flow(ivo_produto.cd_produto, ll_Saldo_Flow) Then Return False
		
	Select count(*)
	  Into :ll_Achou
	  From wms_endereco_produto a
	 inner join wms_endereco e 
	 			on e.cd_endereco = a.cd_endereco
	 Inner join wms_esteira b 
	 			on b.cd_esteira = e.cd_esteira
	 Where b.id_situacao = 'A'
		and a.cd_produto = :ivo_produto.cd_produto
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgDbError("Erro ao localizar o produto.")
		
		Return False
	Else
		If ll_Achou = 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O produto " + String(ivo_produto.cd_produto) + " deve ser faturado pelo sistema do faturamento, pois, o mesmo est$$HEX1$$e100$$ENDHEX$$ com problema no endere$$HEX1$$e700$$ENDHEX$$amento.",Exclamation!)
			
			Return False
		End If
	End If
			
	If IsNull(ivo_Produto.cd_grupo_psico) Then
		If Mid(ivo_Produto.cd_subcategoria, 1,1) <> '5' Then
			//Localiza produto na ds onde est$$HEX1$$e300$$ENDHEX$$o todos os produtos do pedido
			lvl_Find = dw_2.Find("cd_produto = " + String(ivo_produto.cd_produto) , 1, dw_2.RowCount())
			
			If lvl_Find > 0 Then
				dw_2.Object.qt_pedida[lvl_Find] = dw_2.Object.qt_pedida[lvl_Find] + 1
			Else
				lb_Add_Produto_Dw2 = True
			End If
		Else	
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitida a sele$$HEX2$$e700e300$$ENDHEX$$o de produtos do grupo ALMOXARIFADO.",Exclamation!)		
			Return False
		End If
	Else
		//Controles de lotes de produtos controlados
		lb_Controlado = True
		
		//Localiza produto na ds onde est$$HEX1$$e300$$ENDHEX$$o todos os produtos do pedido
		lvl_Find = dw_2.Find("cd_produto = " + String(ivo_produto.cd_produto) , 1, dw_2.RowCount())
		
		If lvl_Find > 0 Then
			dw_2.Object.qt_pedida			[lvl_Find] = dw_2.Object.qt_pedida[lvl_Find] + ll_Qtde_Lote
			dw_2.Object.qt_Saldo_Flow		[lvl_Find] = ll_Saldo_Flow
		Else
			lb_Add_Produto_Dw2 = True	
		End If	
	End If
Else	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Produto n$$HEX1$$e300$$ENDHEX$$o foi localizado.",Exclamation!)
	Return False
End If	

If lb_Add_Produto_Dw2 Then
	lvl_Linha = dw_2.RowCount()
	
	dw_2.Object.cd_produto[lvl_Linha] 			= ivo_Produto.cd_produto
	dw_2.Object.cd_produto_sap[lvl_Linha] 		= ivo_Produto.cd_produto_sap
	dw_2.Object.vl_fator_conversao[lvl_Linha] = ivo_Produto.vl_fator_conversao
	dw_2.Object.de_produto[lvl_Linha] 			= ivo_Produto.ivs_Descricao_Apresentacao_Estoque
	dw_2.Object.qt_pedida[lvl_Linha] 			= ll_Qtde_Lote
	dw_2.Object.qt_saldo[lvl_Linha] 				= ll_qt_Saldo
	dw_2.Object.qt_saldo_loja[lvl_Linha] 		= ll_qt_estoque_filial
	dw_2.Object.qt_disponivel[lvl_Linha] 		= ll_Qt_Saldo_Disponivel
	dw_2.Object.qt_Saldo_Flow[lvl_Linha]		= ll_Saldo_Flow
	dw_2.Object.qt_estoque_base[lvl_Linha]		= ll_qt_estoque_base
	
	// Utilizando tamb$$HEX1$$e900$$ENDHEX$$m para quebrar a nota	
	If lb_Controlado Then
		dw_2.Object.id_controlado[ lvl_Linha ] = "S"
	Else
		dw_2.Object.id_controlado[ lvl_Linha ] = "N"
	End If
		
	dw_2.InsertRow(0)
	
	//Habilita menu para faturamento
	ivm_Menu.mf_Confirmar(True)
	ivm_Menu.mf_Cancelar(True)		
End If

lvl_Linha = dw_2.RowCount()

dw_2.Object.de_produto[lvl_Linha] = ""

dw_2.Event ue_Pos(lvl_Linha, "de_produto")

Return True
end function

public function boolean wf_insere_produtos_via_planilha (string as_arquivo);Any		la_valor_coluna_a, la_valor_coluna_b
Long 		ll_contador_linhas_excel, ll_for, ll_row, ll_cd_produto, ll_quantidade, &
			ll_for_quantidade
String	ls_cd_grupo_psico

dc_uo_excel ldc_uo_excel


Try
	if IsNull(as_arquivo) or as_arquivo = '' then return false
	
	ldc_uo_excel = Create dc_uo_excel
	
	if ldc_uo_excel.uo_referencia_objeto_excel(as_arquivo) Then
		ll_contador_linhas_excel = ldc_uo_excel.uo_verifica_tamanho_arquivo("A") 
	End If
	
	dw_2.Reset()
	
	For ll_for = 1 To ll_contador_linhas_excel
		if ll_for = 1 Then 
			ll_row	= dw_2.InsertRow(0)
		else
			ll_row	= dw_2.RowCount()
		end if
		
		ll_cd_produto	= Long(ldc_uo_excel.uo_lendo_dados(ll_for, "A"))
		ll_quantidade	= Long(ldc_uo_excel.uo_lendo_dados(ll_for, "B"))
		
		select cd_grupo_psico
		  into :ls_cd_grupo_psico
		  from produto_geral
		 where cd_produto	= :ll_cd_produto;
		 
		Choose Case SQLCA.SQLCode
			Case -1
				MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao verificar se produto $$HEX1$$e900$$ENDHEX$$ controlado. ' + SQLCA.SQLErrText, StopSign!)
				Continue
		End Choose
		
		dw_2.SetRow(ll_row)
		
		dw_2.Object.de_produto[ll_row]	= String(ll_cd_produto)
		
		wf_localiza_produto()
		
		if IsNull(ls_cd_grupo_psico) or Trim(ls_cd_grupo_psico) = '' then
			dw_2.Object.qt_pedida[ll_row]		= ll_quantidade
			
			dw_2.Trigger Event ItemChanged(ll_row, dw_2.Object.qt_pedida, String(ll_quantidade))
		else
			if ll_quantidade > 1 then
				for ll_for_quantidade = 1 to ll_quantidade - 1
					dw_2.SetRow(dw_2.RowCount())
					
					dw_2.Object.de_produto[dw_2.RowCount()]	= String(ll_cd_produto)
					
					wf_localiza_produto()
				next
			end if
		end if
	Next
Finally
	Destroy ldc_uo_excel
End Try

return true
end function

on w_ge578_pedido_pescador_manual.create
int iCurrent
call super::create
this.gb_2=create gb_2
this.gb_1=create gb_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.cb_1
end on

on w_ge578_pedido_pescador_manual.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.cb_1)
end on

event ue_postopen;call super::ue_postopen;ivo_produto   = Create uo_produto
ivo_filial    = Create uo_filial

wf_Inicializar()
end event

event close;call super::close;Destroy(ivo_produto)
Destroy(ivo_filial)

end event

event ue_cancel;//OVERRIDE

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja cancelar faturamento ?", Question!, YesNo!, 2) = 1 Then

	This.ivb_Valida_Salva = False

	Wf_inicializar()
	
End If	
		
end event

event closequery;//OVERRIDE

Return 0
end event

event ue_save;Long	ll_cd_filial, ll_row


If Not wf_valida_dh_movimentacao_parametro() Then Return 1

If Not gf_Valida_Versao(gvo_Aplicacao.ivo_Seguranca.Cd_Sistema, gvo_Aplicacao.ivs_Versao, False) Then Return 1

dw_1.AcceptText()
dw_2.AcceptText()

ll_row	= dw_1.GetRow()

if ll_row < 1 then 
	return -1
else
	ll_cd_filial	= dw_1.Object.cd_filial[ll_row]
end if

idt_data = Date(gf_getserverdate())

if wf_inclui_pedido_filial(ll_cd_filial) then 
	if MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Deseja fazer a separa$$HEX2$$e700e300$$ENDHEX$$o autom$$HEX1$$e100$$ENDHEX$$tica dos pedidos?",Question!,YesNo!) = 1 then
		if not wf_carrega_saldo_conta_corrente() then
			return -1
		end if
		
		if not wf_processar_picking() then
			return -1
		end if
		
		if not wf_gera_abast(idt_data) then
			return -1
		end if
	end if
	
	wf_inicializar()
end if

Return 1
end event

type dw_visual from dc_w_sheet`dw_visual within w_ge578_pedido_pescador_manual
end type

type gb_aux_visual from dc_w_sheet`gb_aux_visual within w_ge578_pedido_pescador_manual
end type

type gb_2 from groupbox within w_ge578_pedido_pescador_manual
integer x = 23
integer y = 192
integer width = 3502
integer height = 1348
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within w_ge578_pedido_pescador_manual
integer x = 23
integer width = 3502
integer height = 180
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

type dw_1 from dc_uo_dw_base within w_ge578_pedido_pescador_manual
integer x = 41
integer y = 64
integer width = 2071
integer height = 92
boolean bringtotop = true
string dataobject = "dw_ge578_selecao_filial"
end type

event constructor;call super::constructor;ivb_UpdateAble = False
end event

event itemchanged;call super::itemchanged;Choose Case dwo.name 
	Case "nm_filial"
		
		If IsNull(data) or data = "" Then
				
			SetNull(ivo_Filial.cd_filial)			
			ivo_filial.nm_fantasia = ""
		
			This.Object.cd_filial[row] = ivo_filial.cd_filial
			This.Object.nm_filial[row] = ivo_filial.nm_fantasia
		
		End If
		
		If data <> ivo_filial.nm_fantasia Then
			Return 1
		End If
End Choose	

end event

event ue_key;call super::ue_key;STRING lvs_Coluna

lvs_Coluna = This.GetColumnName()

If	lvs_Coluna = "nm_filial" Then
		
	If key = KeyEnter! Then	Wf_Localiza_Filial()
	
End If


end event

type dw_2 from dc_uo_dw_base within w_ge578_pedido_pescador_manual
event posicionar ( long pl_linha,  string ps_coluna )
integer x = 59
integer y = 252
integer width = 3456
integer height = 1280
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge578_lista_produtos_pedido"
boolean vscrollbar = true
boolean livescroll = false
end type

event posicionar;//
This.SetRedraw(False)
This.SetRow(pl_linha)
This.ScrollToRow(pl_linha)
This.SetColumn(ps_coluna)

If ps_coluna = "de_produto" Then This.Object.de_produto[pl_linha] = ''

This.SetRedraw(True)
//

end event

event ue_key;call super::ue_key;String lvs_Coluna


lvs_Coluna = This.GetColumnName()

Choose Case Key
	Case KeyEscape!	
		Parent.Event ue_cancel()	
	Case KeyEnd!
		Parent.Event ue_save()	
	Case Else	
		Choose Case lvs_Coluna
			Case "de_produto"			
				If Key = KeyEnter! Then wf_localiza_produto()
		
				If Key = KeyUpArrow! Then This.Event Posicionar(This.GetRow()-1,"qt_pedida")
			Case "qt_pedida"
				If Key = KeyEnter! Then This.Event Posicionar(This.RowCount(),"de_produto")
				
				If Key = KeyDownArrow! and This.GetRow() = This.RowCount() - 1 Then
					This.Event Posicionar(This.RowCount(),"de_produto")
				End If
		End Choose
End Choose
end event

event itemfocuschanged;call super::itemfocuschanged;If dwo.name = 'qt_pedida' Then SelectText(1,10)
	
end event

event ue_preinsertrow;call super::ue_preinsertrow;Long lvl_Row 


lvl_Row = dw_2.GetRow()

If IsNull(dw_2.Object.de_produto[lvl_Row]) Then Return 0

Return 1
end event

event rowfocuschanged;call super::rowfocuschanged;Boolean lvb_Excluir = True

If currentrow = This.RowCount() Then lvb_Excluir = False
	
ivm_Menu.mf_Excluir(lvb_Excluir)
end event

event ue_deleterow;call super::ue_deleterow;This.Event RowFocusChanged(This.GetRow())

Return AncestorReturnValue
end event

event itemchanged;call super::itemchanged;Long	ll_Qtde,&
		ll_Disponivel,&
		ll_Produto,&
		ll_Saldo_Final,&
		ll_Saldo_Flow


If dwo.Name = "qt_pedida" Then
	If This.Object.id_controlado[ row ] = "S" Then	
		ll_Qtde = This.Object.qt_pedida[ row ]
		
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ permitido alterar a quantidade de produtos controlados.")
		
		This.Object.qt_pedida[ row ] = ll_Qtde
		Return 1 
	Else
		ll_Qtde 			= Long(data)
		ll_Disponivel	= This.Object.qt_disponivel	[row]
		ll_Produto		= This.Object.cd_produto	[row]
		ll_Saldo_Final	= This.Object.qt_saldo		[row]
		ll_Saldo_Flow	= This.Object.qt_saldo_flow	[row]
		
		If ll_Qtde = 0 or IsNull(ll_Qtde) or ll_Qtde < 0  Then 
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe a quantidade do produto " +String(ll_Produto) + ". N$$HEX1$$e300$$ENDHEX$$o Pode ser Zero ou Negativo!")
			This.Event ue_Pos(row, "qt_pedida")
			This.Object.qt_pedida[ row ] = 1
			Return 1	
		End If 
		
		//Valida$$HEX2$$e700e300$$ENDHEX$$o do Saldo Produto
		If ll_Qtde > ll_Saldo_Final Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Saldo insufici$$HEX1$$ea00$$ENDHEX$$nte do produto " +String(ll_Produto) +" para atender ~ra qtde pedida de: "+String(ll_Qtde))
			This.Event ue_Pos(row, "qt_pedida")
			This.Object.qt_pedida[ row ] = 1
			Return 1
		End If
		
		If ll_Qtde > ll_Saldo_Flow Then
			If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Quantidade $$HEX1$$e900$$ENDHEX$$ maior do que saldo do flow rack: "+String(ll_Saldo_Flow)+".~rDeseja continuar?", Question!, YesNo!, 2) = 2 Then
				This.Object.qt_pedida[ row ] = 1
				Return 1 	
			End If
		End If
		
		If ll_Qtde > ll_Disponivel Then
			If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Quantidade $$HEX1$$e900$$ENDHEX$$ maior do que a dispon$$HEX1$$ed00$$ENDHEX$$vel: "+String(ll_Disponivel)+".~rDeseja continuar?", Question!, YesNo!, 2) = 2 Then
				This.Object.qt_pedida[ row ] = 1
				Return 1 	
			End If
		End If
	End If
End If
end event

type cb_1 from commandbutton within w_ge578_pedido_pescador_manual
integer x = 2464
integer y = 48
integer width = 1038
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Selecionar Produtos via Planilha"
end type

event clicked;Int	 	li_retorno
Long		ll_cd_filial, ll_row
String 	ls_arquivo, ls_caminho_arquivo


ll_row	= dw_1.GetRow()

if ll_row <= 0 then return -1

ll_cd_filial	= dw_1.Object.cd_filial[ll_row]

if ll_cd_filial = 0 or IsNull(ll_cd_filial) then 
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Favor informar uma filial.', StopSign!)
	return -1
end if

li_retorno = GetFileOpenName("Selecione o Arquivo (C$$HEX1$$f300$$ENDHEX$$digo Produto, Quantidade)", ls_caminho_arquivo, ls_arquivo, "XLSX", "Excel")

If li_retorno = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Ocorreu um erro ao selecionar o arquivo.", StopSign!)
	return -1
End If

il_resp_libera_produto_bahia	= 0

wf_insere_produtos_via_planilha(ls_caminho_arquivo)
end event

