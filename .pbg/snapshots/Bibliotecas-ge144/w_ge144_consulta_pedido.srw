HA$PBExportHeader$w_ge144_consulta_pedido.srw
forward
global type w_ge144_consulta_pedido from dc_w_2tab_consulta_selecao_lista_2det
end type
type cb_cancelar from commandbutton within tabpage_1
end type
type cb_imprimir from commandbutton within tabpage_1
end type
type cb_situacao from commandbutton within tabpage_1
end type
type cb_volta_situacao from commandbutton within tabpage_1
end type
type cb_pausar_alerta from commandbutton within tabpage_1
end type
type tabpage_3 from userobject within tab_1
end type
type gb_5 from groupbox within tabpage_3
end type
type dw_6 from dc_uo_dw_base within tabpage_3
end type
type tabpage_3 from userobject within tab_1
gb_5 gb_5
dw_6 dw_6
end type
type tabpage_4 from userobject within tab_1
end type
type dw_5 from dc_uo_dw_base within tabpage_4
end type
type tabpage_4 from userobject within tab_1
dw_5 dw_5
end type
end forward

global type w_ge144_consulta_pedido from dc_w_2tab_consulta_selecao_lista_2det
integer x = 631
integer y = 20
integer width = 3703
integer height = 1912
string title = "GE144 - Consulta de Pedidos eCommerce"
long backcolor = 80269524
end type
global w_ge144_consulta_pedido w_ge144_consulta_pedido

type prototypes

end prototypes

type variables
uo_ge150_cliente_drogaexpress		ivo_Cliente
uo_ge144_pedido_drogaexpress 	ivo_Pedido
uo_filial                           			ivo_Filial

dc_uo_dw_base ivdw_obs

Integer ivl_Largura_3
Integer ivl_Altura_3
end variables

forward prototypes
public subroutine wf_localiza_cliente ()
public subroutine wf_localiza_filial ()
public function boolean wf_verica_impressao (string ps_pedido, ref datetime pdt_impressao, ref string ps_situacao)
public function boolean wf_atualiza_impressao (string ps_pedido)
public function boolean wf_proximo_nr_lancamento (string as_caixa, long al_controle, ref long al_nr_lancamento)
public function boolean wf_cancela_comprovante_cartao (long al_cd_filial, string al_pedido_drogaexpress, string al_situacao)
public function boolean wf_atualiza_pedido_ecommerce_matriz (long al_filial_ecommerce, long al_pedido, string as_matricula, string as_situacao)
public function boolean wf_atualiza_pedido_ecommerce_matriz (long al_filial_ecommerce, long al_pedido, string as_matricula, string as_situacao, long al_nf_servico)
public subroutine wf_verifica_pendentes ()
end prototypes

public subroutine wf_localiza_cliente ();Long ll_Linha

String ls_Cd_Cliente

Tab_1.TabPage_1.dw_1.AcceptText()

ll_Linha 			= Tab_1.TabPage_1.dw_1.GetRow()
ls_Cd_Cliente	= Tab_1.TabPage_1.dw_1.GetText()

ivo_Cliente.Of_Localiza_Cliente(ls_Cd_Cliente)

If ivo_Cliente.Localizado Then
	Tab_1.TabPage_1.dw_1.Object.Nm_Cliente	[1]	= ivo_Cliente.Nm_Cliente
	Tab_1.TabPage_1.dw_1.Object.Cd_Cliente	[1]	= ivo_Cliente.Cd_Cliente_Drogaexpress
End If
end subroutine

public subroutine wf_localiza_filial ();String lvs_Filial
Long linha

Tab_1.TabPage_1.dw_1.AcceptText()
linha = Tab_1.TabPage_1.dw_1.GetRow()

lvs_Filial = Tab_1.TabPage_1.dw_1.GetText()

ivo_Filial.of_localiza_Filial(lvs_Filial)

If ivo_Filial.localizada Then
	
	Tab_1.TabPage_1.dw_1.Object.nm_Fantasia[1] = ivo_Filial.nm_fantasia
	Tab_1.TabPage_1.dw_1.Object.cd_Filial	[1] = ivo_Filial.cd_Filial
	
End If
end subroutine

public function boolean wf_verica_impressao (string ps_pedido, ref datetime pdt_impressao, ref string ps_situacao);Select dh_impressao, id_situacao
	Into :pdt_impressao, :ps_situacao
from pedido_drogaexpress
Where nr_pedido_drogaexpress = :ps_Pedido
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	Sqlca.of_MsgDbError("Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da situa$$HEX2$$e700e300$$ENDHEX$$o do pedido.")
	Return False
End If 

Return True
end function

public function boolean wf_atualiza_impressao (string ps_pedido);//Grava a data de impressao

Update pedido_drogaexpress
	Set dh_impressao = getdate()
Where nr_pedido_drogaexpress = :ps_Pedido
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	Sqlca.of_Rollback()
	Sqlca.of_MsgDbError( "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da situa$$HEX2$$e700e300$$ENDHEX$$o do pedido." )
	Return False
End If 

SqlCa.Of_Commit()

Return True
end function

public function boolean wf_proximo_nr_lancamento (string as_caixa, long al_controle, ref long al_nr_lancamento);

SELECT MAX(nr_lancamento)
  INTO :al_nr_lancamento
  FROM lancamento_caixa
 WHERE cd_caixa = :as_Caixa
   AND nr_controle_caixa = :al_Controle
Using Sqlca;

Choose Case SqlCa.SqlCode
	Case 0
		If IsNull(al_nr_lancamento) Then al_nr_lancamento = 0
		al_nr_lancamento ++
	Case 100
		al_nr_lancamento = 1
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Pr$$HEX1$$f300$$ENDHEX$$ximo Lan$$HEX1$$e700$$ENDHEX$$amento")
		Return False
End Choose

Return True
end function

public function boolean wf_cancela_comprovante_cartao (long al_cd_filial, string al_pedido_drogaexpress, string al_situacao);
Date lvdt_Parametro

Datetime lvdt_Movimentacao, lvdt_emissao

Decimal {2} lvdc_total_pedido

String lvs_Historico, &
		 lvs_Caixa, &
	     lvs_Caixa_Incluir, &
		 lvs_Mensagem, &
		 lvs_Operador, &
		 lvs_Cancelado, &
		 lvs_cd_forma_pagamento, &
		 lvs_cd_estabelecimento , &
		 lvs_autorizacao_cartao, &
		 lvs_comprovante_cartao, &
		 lvs_de_historico, &
		 lvs_plataforma

String ls_Pedido_Ecommerce

Long lvl_Linha, &
	  lvl_Comprovante, &
	  lvl_Lancamento_Estornar, &
	  lvl_Lancamento_Incluir, &
	  lvl_Nr_Lancamento, &
	  lvl_Controle, &
	  lvl_Controle_Incluir, &
	  lvl_pedido_ecommerce, &
	  lvl_nr_sequencial, &
	  lvl_conta_adiant

Select vl_total_pedido, cd_forma_pagamento, cd_estabelecimento_cartao_credito, 
          nr_autorizacao_cartao_credito, nr_comprovante_cartao_credito, nr_pedido_ecommerce, dh_emissao, id_plataforma_ecommerce
   Into :lvdc_total_pedido, :lvs_cd_forma_pagamento, :lvs_cd_estabelecimento, :lvs_autorizacao_cartao, 
		:lvs_comprovante_cartao, :lvl_pedido_ecommerce, :lvdt_emissao, :lvs_plataforma
  From pedido_drogaexpress
Where cd_filial = :al_Cd_Filial
    and nr_pedido_drogaexpress = :al_pedido_drogaexpress
Using Sqlca;

If SqlCa.SqlCode <> 0 Then
	SqlCa.of_MsgdbError("Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o dos dados do Pedido Drogaexpress.")
	Return False
End If

If lvdt_emissao < Datetime('01/07/2014 00:00:00') Then
	Return True
End If

If lvs_cd_forma_pagamento <> 'CP' Then
	Return True
End If
	
 Select cd_caixa, nr_controle_caixa, nr_sequencial, nr_lancamento_caixa, id_cancelamento
    Into :lvs_Caixa, :lvl_Controle, :lvl_nr_sequencial, :lvl_Lancamento_Estornar, :lvs_Cancelado
   from cartao_comprovante_venda
Where nr_autorizacao = :lvs_autorizacao_cartao
    and nr_nsu 			 = :lvs_comprovante_cartao
    and cd_estabelecimento = :lvs_cd_estabelecimento
Using SqlCa;

ls_Pedido_Ecommerce = String( lvl_pedido_ecommerce)

If lvs_Cancelado = 'S' Then
	If al_Situacao = 'F' or al_Situacao = 'D' Then //Cancelamento do comprovante feito pelo Retaguarda. Pedido Faturado = Adiantamento j$$HEX1$$e100$$ENDHEX$$ estornado.
		Return True
	End If
End If

If SqlCa.SqlCode <> 0 Then
	SqlCa.of_MsgdbError("Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o dos dados do Comprovante do Cart$$HEX1$$e300$$ENDHEX$$o")
	Return False
End If

SELECT MAX(nr_controle_caixa)
  INTO :lvl_Controle_Incluir
  FROM controle_caixa
 WHERE cd_caixa = :lvs_Caixa
	AND dh_conferencia IS NULL
Using Sqlca;

If (Sqlca.SqlCode <> 0) Then
	SqlCa.of_MsgdbError("Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o dos caixa aberto.")
	Return False
End If

If lvl_Controle_Incluir <=0 or IsNull(lvl_Controle_Incluir) Then
	SqlCa.of_MsgdbError("Nenhum caixa aberto encontrado.")
	Return False
End If
	
// Grava lan$$HEX1$$e700$$ENDHEX$$amento de estorno na conta de adiantamento caso ainda n$$HEX1$$e300$$ENDHEX$$o tenha sido faturado
If al_situacao = 'A' Then	
	If Not wf_proximo_nr_lancamento(lvs_Caixa, lvl_Controle_Incluir, Ref lvl_nr_lancamento ) Then
		Return False
	End If
	
	If lvs_plataforma = '4' Then
		lvl_conta_adiant = 256
		lvs_de_historico = 'REF. PED :' + String(lvl_pedido_ecommerce) + ' - VM'				
	Else
		lvl_conta_adiant = 205
		lvs_de_historico = 'REF. PED :' + String(lvl_pedido_ecommerce) + ' - ECOMMERCE'		
	End If
	
	lvdt_Movimentacao = gf_GetServerDate()
	
	INSERT INTO lancamento_caixa (
		cd_caixa,
		nr_controle_caixa,
		nr_lancamento,
		cd_conta_fluxo_caixa,
		dh_lancamento,
		vl_lancamento,
		de_historico,
		nr_recibo_cobranca,
		id_sumarizacao,
		id_estorno,
		dh_exportacao,
		nr_documento,
		cd_filial_transferencia)
	VALUES (:lvs_caixa,
		:lvl_Controle_Incluir,
		:lvl_nr_lancamento,
		:lvl_conta_adiant, 				//cd_conta_fluxo_caixa
		:lvdt_Movimentacao, 			//dh_lancamento 
		:lvdc_total_pedido, 			//vl_lancamento
		:lvs_de_historico,				//de_historico
		null, 								//nr_recibo_cobranca
		null, 								//id_sumarizacao
		'S', 								//id_estorno
		null, 								//dh_exportacao
		 :ls_Pedido_Ecommerce, 	//nr_documento 
		null								//cd_filial_transferencia
	)
	Using Sqlca;	
	
	If Sqlca.SqlCode <> 0 Then
		SqlCa.of_MsgdbError("Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o inclus$$HEX1$$e300$$ENDHEX$$o do estorno do adiantamento.")
		Return False
	End If
End If

//Comprovante j$$HEX1$$e100$$ENDHEX$$ foi cancelado no Retaguarda. 
If lvs_Cancelado = 'S' Then
	Return True
End If

// Cancela o comprovante do cart$$HEX1$$e300$$ENDHEX$$o

Select dh_movimentacao Into :lvdt_Parametro
From parametro
Using SqlCa;

Update cartao_comprovante_venda
Set id_cancelamento	= 'S',
	 dh_exportacao		= :lvdt_Parametro
Where cd_caixa          	= :lvs_Caixa
  and nr_controle_caixa	= :lvl_Controle
  and nr_sequencial		= :lvl_Nr_Sequencial
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Cancelamento do Comprovante do Cart$$HEX1$$e300$$ENDHEX$$o")
Else
	// Estorna o lan$$HEX1$$e700$$ENDHEX$$amento de caixa se houver
	Update lancamento_caixa
	Set id_estorno    = 'X',
		 dh_exportacao = :lvdt_Parametro
	Where cd_caixa			= :lvs_Caixa
	  and nr_controle_caixa	= :lvl_Controle
	  and nr_lancamento		= :lvl_Lancamento_Estornar
	Using SqlCa;

	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgdbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do Lan$$HEX1$$e700$$ENDHEX$$amento Estornado")
		Return False
	Else				
		If Not wf_proximo_nr_lancamento(lvs_Caixa, lvl_Controle_Incluir, Ref lvl_Lancamento_Incluir ) Then
			Return False
		End If
		
		Insert Into lancamento_caixa (cd_caixa,   
												nr_controle_caixa,   
												nr_lancamento,   
												cd_conta_fluxo_caixa,   
												dh_lancamento,   
												vl_lancamento,   
												de_historico,   
												nr_recibo_cobranca,
												id_sumarizacao,
												id_estorno,
												nr_documento,
												cd_caixa_origem,
												nr_controle_caixa_origem,
												nr_lancamento_origem)  
		Select :lvs_Caixa,
				 :lvl_Controle_Incluir,
				 :lvl_Lancamento_Incluir,
				 cd_conta_fluxo_caixa,
				 dh_lancamento,
				 vl_lancamento,
				 de_historico,
				 null,
				 null,
				 'S',
	 			:ls_Pedido_Ecommerce,
				cd_caixa,
	 			Nr_controle_caixa, 
	  			nr_lancamento
		From lancamento_caixa
		Where cd_caixa          	= :lvs_Caixa
		  and nr_controle_caixa 	= :lvl_Controle
		  and nr_lancamento     	= :lvl_Lancamento_Estornar
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgdbError("Inclus$$HEX1$$e300$$ENDHEX$$o do Lan$$HEX1$$e700$$ENDHEX$$amento de Estorno")
			Return False
		End If
	End If
End If

Return True
end function

public function boolean wf_atualiza_pedido_ecommerce_matriz (long al_filial_ecommerce, long al_pedido, string as_matricula, string as_situacao);Long ll_Nf_Servico

SETNULL( ll_Nf_Servico )


Return wf_atualiza_pedido_ecommerce_matriz (al_filial_ecommerce, al_pedido, as_matricula, as_situacao, ll_Nf_Servico)
end function

public function boolean wf_atualiza_pedido_ecommerce_matriz (long al_filial_ecommerce, long al_pedido, string as_matricula, string as_situacao, long al_nf_servico);Boolean	lvb_Sucesso = False

Long		lvl_Row

String	lvs_Tabela
String	lvs_Set
String	lvs_Where

Open(w_Aguarde)
		
w_Aguarde.Title = "Atualizando o pedido ECOMMERCE na matriz."

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()
	
lvs_Tabela	 = "pedido_ecommerce"

lvs_Set		 =  " id_situacao = '" + as_Situacao + "', "
lvs_Set		 += " dh_alteracao_situacao = getdate(), "
lvs_Set		 += " nr_matric_alteracao_situacao = '" + as_Matricula + "'"

lvs_Where	 = "cd_filial_ecommerce = " + String(al_filial_ecommerce) + " and nr_pedido = "  + String(al_Pedido)
		
If Not lvo_Conexao.of_Update_Registro(lvs_Tabela, lvs_Set, lvs_Where, Ref lvl_Row) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na altera$$HEX2$$e700e300$$ENDHEX$$o do pedido eCommerce '" + String(al_Pedido) + "'.", StopSign!)
Else
	If lvo_Conexao.of_Erro_Conexao() Or lvo_Conexao.of_erro_execucao( ) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na conex$$HEX1$$e300$$ENDHEX$$o com a Matriz. Tente novamente mais tarde.", StopSign!)
	Else
		If Not isNull( al_nf_servico ) Then
			If Not lvo_Conexao.of_Update_Registro('pedido_ecommerce_auxiliar', 'nr_nf_servico = '+String( al_nf_servico ), lvs_Where, Ref lvl_Row) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na gravacao da nf de servico do pedido eCommerce '" + String(al_Pedido) + "'.", StopSign!)
			Else
				If lvo_Conexao.of_Erro_Conexao() Or lvo_Conexao.of_erro_execucao( ) Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na conex$$HEX1$$e300$$ENDHEX$$o com a Matriz. Tente novamente mais tarde.", StopSign!)
				Else
					lvb_Sucesso = True
				End If
			End If
		Else
			lvb_Sucesso = True
		End If 
	End If
End If	

Close(w_Aguarde)

Destroy(lvo_Conexao)

Return lvb_Sucesso

end function

public subroutine wf_verifica_pendentes ();Long ll_pedidos

Select count(*)
	Into :ll_pedidos
from pedido_drogaexpress
Where id_situacao = 'P'
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	Sqlca.of_MsgDbError("Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o pedidos pendentes.")
	Return
Else
	Sqlca.of_end_transaction()
	If ll_pedidos > 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Existem pedidos com situa$$HEX2$$e700e300$$ENDHEX$$o FATURANDO.~r" + &
									   "Pode ter ocorrido algum problema na finaliza$$HEX2$$e700e300$$ENDHEX$$o da venda.~r" + &
									   "Consulte os pedidos com a situa$$HEX2$$e700e300$$ENDHEX$$o FATURANDO.",Information!)
	End If
End If 

Return
end subroutine

on w_ge144_consulta_pedido.create
int iCurrent
call super::create
end on

on w_ge144_consulta_pedido.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;Destroy(ivo_Pedido)
Destroy(ivo_Filial)
Destroy(ivo_Cliente)
end event

event ue_postopen;call super::ue_postopen;DateTime lvdh_Parametro

String ls_Rede_Filial

lvdh_Parametro = gvo_Parametro.of_Dh_Movimentacao()

Tab_1.TabPage_1.dw_1.Object.Dt_Inicio	[1] = RelativeDate( Today(), -3)
Tab_1.TabPage_1.dw_1.Object.Dt_Fim	[1] = Today()

ivo_Cliente	= Create uo_ge150_Cliente_Drogaexpress
ivo_Pedido  	= Create uo_ge144_Pedido_DrogaExpress
ivo_Filial  	= Create uo_Filial

ivm_Menu.ivb_Permite_Filtrar 		= False
ivm_Menu.ivb_Permite_Classificar	= False
ivm_Menu.ivb_Permite_Localizar	= False

ivdw_Obs = Tab_1.TabPage_3.dw_6

ls_Rede_Filial = gvo_Parametro.id_rede_filial

If ls_Rede_Filial <> 'FA' Then
	Tab_1.TabPage_1.dw_1.Object.id_Rede_Ecommerce				[ 1 ]	= 'TD'
//	Tab_1.TabPage_1.dw_1.Object.id_Rede_Ecommerce.Protect 			= 1
End If

wf_verifica_pendentes()
end event

type dw_visual from dc_w_2tab_consulta_selecao_lista_2det`dw_visual within w_ge144_consulta_pedido
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_2det`gb_aux_visual within w_ge144_consulta_pedido
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_2det`tab_1 within w_ge144_consulta_pedido
integer x = 5
integer y = 4
integer width = 3648
integer height = 1716
long backcolor = 80269524
tabpage_3 tabpage_3
tabpage_4 tabpage_4
end type

event tab_1::selectionchanging;//OVERRIDE

SetPointer(HourGlass!)

STRING lvs_Tipo_Venda, lvs_dw_Detalhe

LONG   lvl_Linha, lvl_Pedido_Ecommerce

lvl_Linha = Tab_1.TabPage_1.dw_2.GetRow()

If NewIndex = 2 Then
	If lvl_Linha > 0 Then
		
		lvs_Tipo_Venda 			= Tab_1.TabPage_1.dw_2.Object.cd_tipo_venda		 [lvl_Linha]
		lvl_Pedido_Ecommerce 	= Tab_1.TabPage_1.dw_2.Object.nr_pedido_ecommerce[lvl_Linha]
		
		If Isnull(lvl_Pedido_Ecommerce) Then
			lvs_dw_Detalhe = "dw_ge144_detalhe_pedido_" + Lower(lvs_Tipo_Venda)
		Else
			lvs_dw_Detalhe = "dw_ge144_detalhe_pedido_ecommerce"			
		End If
		
		// Verifica se existe a necessidade de troca de dw 
		// conforme o tipo de pedido selecionado
		If Tab_1.TabPage_2.dw_3.DataObject <> lvs_dw_Detalhe Then
			Tab_1.TabPage_2.dw_3.DataObject  = lvs_dw_Detalhe
			Tab_1.TabPage_2.dw_3.SetTransObject(Sqlca)
		End If	
		
		// Executa o evento de recupera$$HEX2$$e700e300$$ENDHEX$$o das linhas
		// das DW's de detalhes
		Tab_1.TabPage_2.dw_3.Event ue_Retrieve()
		Tab_1.TabPage_2.dw_4.Event ue_Retrieve()

		// Permite a troca do folder
		Return 0
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma linha da lista para visualizar os detalhes.", StopSign!, Ok!)
		// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
		Return 1
	End If
	
ElseIf NewIndex = 3 Then
	If lvl_Linha > 0 Then
		ivdw_Obs.Event ue_Retrieve()
		Return 0	
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma linha da lista para visualizar os detalhes.", StopSign!, Ok!)
		// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
		Return 1
	End If

Elseif NewIndex = 4 Then
	If lvl_Linha > 0 Then
		tabpage_4.dw_5.Event ue_Retrieve()
		Return 0	
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma linha da lista para visualizar informa$$HEX2$$e700f500$$ENDHEX$$es de receita.", StopSign!, Ok!)
		// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
		Return 1
	End If
End If		

SetPointer(Arrow!)
end event

on tab_1.create
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_3
this.Control[iCurrent+2]=this.tabpage_4
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_3)
destroy(this.tabpage_4)
end on

event tab_1::selectionchanged;//OverRide

SetPointer(HourGlass!)

Choose Case NewIndex
	Case 1
		This.Width  = Parent.ivl_Largura_1
		This.Height = Parent.ivl_Altura_1
		
		Tab_1.TabPage_1.dw_2.SetFocus()
	Case 2
		This.Width  = Parent.ivl_Largura_1
		This.Height = Parent.ivl_Altura_1
		
		Tab_1.TabPage_2.dw_3.SetFocus()
		
	Case 3
		This.Width  = Parent.ivl_Largura_1
		This.Height = Parent.ivl_Altura_1
		
		ivdw_Obs.SetFocus()

End Choose
	
Parent.Width  = This.Width
Parent.Height = This.Height			

SetPointer(Arrow!)
end event

event tab_1::constructor;call super::constructor;ivl_Largura_1 = 3593
ivl_Altura_1  = 1716

ivl_Largura_2 = ivl_Largura_1
ivl_Altura_2  =  ivl_Altura_1

ivl_Largura_3 = ivl_Altura_1
ivl_Altura_3  = ivl_Altura_1
end event

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_2det`tabpage_1 within tab_1
integer width = 3611
integer height = 1600
cb_cancelar cb_cancelar
cb_imprimir cb_imprimir
cb_situacao cb_situacao
cb_volta_situacao cb_volta_situacao
cb_pausar_alerta cb_pausar_alerta
end type

on tabpage_1.create
this.cb_cancelar=create cb_cancelar
this.cb_imprimir=create cb_imprimir
this.cb_situacao=create cb_situacao
this.cb_volta_situacao=create cb_volta_situacao
this.cb_pausar_alerta=create cb_pausar_alerta
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_cancelar
this.Control[iCurrent+2]=this.cb_imprimir
this.Control[iCurrent+3]=this.cb_situacao
this.Control[iCurrent+4]=this.cb_volta_situacao
this.Control[iCurrent+5]=this.cb_pausar_alerta
end on

on tabpage_1.destroy
call super::destroy
destroy(this.cb_cancelar)
destroy(this.cb_imprimir)
destroy(this.cb_situacao)
destroy(this.cb_volta_situacao)
destroy(this.cb_pausar_alerta)
end on

type gb_2 from dc_w_2tab_consulta_selecao_lista_2det`gb_2 within tabpage_1
integer x = 14
integer y = 540
integer width = 3557
integer height = 1056
string text = "Lista de Pedidos"
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_2det`gb_1 within tabpage_1
integer x = 14
integer y = 8
integer width = 3035
integer height = 504
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_2det`dw_1 within tabpage_1
integer x = 32
integer y = 72
integer width = 3013
integer height = 432
string dataobject = "dw_ge144_selecao_consulta_pedido"
end type

event dw_1::ue_key;call super::ue_key;String lvs_Coluna

lvs_Coluna = This.GetColumnName()

If key = keyEnter! Then
	
	Choose Case lvs_Coluna
			
		Case "nm_cliente"			
			wf_localiza_cliente()		
			
		Case "nm_fantasia"
			wf_Localiza_Filial()
			
	End Choose
	
End If
	
end event

event dw_1::itemchanged;call super::itemchanged;String lvs_Nulo, &
       lvs_Pedido
		 
Long lvl_Nulo

SetNull(lvs_Nulo)
SetNull(lvl_Nulo)

Choose Case  GetColumnName() 
	Case "nm_cliente" 
		If Trim(Data) <> "" Then
			If Data <> ivo_Cliente.Nm_Cliente Then
				Return 1
			End If
		Else
			This.Object.Cd_Cliente[1] = lvs_Nulo
			ivo_Cliente.Nm_Cliente = ""			
		End If		

	Case "nm_fantasia" 
		If Trim(Data) <> "" Then
			If Data <> ivo_Filial.Nm_Fantasia Then
				Return 1
			End If
		Else
			ivo_Filial.of_Inicializa()
			This.Object.Cd_Filial[1] = lvl_Nulo
		End If		
		
	Case "nr_cpf_cnpj"
		If Not IsNull(Data) and Trim(Data) <> "" Then						
			If LenA(Data) <= 11 Then //CPF			
				If Not gf_Nr_CPF_Valido(Data) Then
					This.Object.Nr_CPF_CNPJ[1] = DATA
					Return 1
				End If
			Else  //CNPJ
				If Not gf_CGC_Valido(Data) Then
					This.Object.Nr_CPF_CNPJ[1] = DATA
					Return 1
				End If
			End If			
		End If
		
End Choose

dw_2.Event ue_Reset()
dw_2.Object.t_pedido_ecommerce_erp.Text	=""
dw_2.Object.st_transportadora.Text				=""



end event

event dw_1::constructor;call super::constructor;This.of_SetColSelection(TRUE)
end event

event dw_1::editchanged;call super::editchanged;dw_2.Event ue_Reset()
dw_2.Object.t_pedido_ecommerce_erp.Text	=""
dw_2.Object.st_transportadora.Text				=""
end event

type dw_2 from dc_w_2tab_consulta_selecao_lista_2det`dw_2 within tabpage_1
integer x = 41
integer y = 596
integer width = 3506
integer height = 984
string dataobject = "dw_ge144_lista_pedido"
boolean hscrollbar = true
end type

event dw_2::ue_recuperar;//OverRide
Long lvl_Linha

Tab_1.TabPage_1.dw_1.AcceptText()

lvl_Linha =  This.Retrieve()

If lvl_Linha > 0 Then
	cb_imprimir.Enabled = True
	cb_cancelar.Enabled = True
Else
	cb_imprimir.Enabled = False
	cb_cancelar.Enabled = False
End If

Return lvl_Linha
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;String  lvs_Situacao, &
		 lvs_Tipo_Venda, ls_id_ecommerce

String ls_Rede
String lvs_Transportadora
String ls_Pedido
String ls_Cpf_Cnpj
String ls_id_impresso
String ls_id_tipo_pedido

//Long   lvl_Pedido
Long	 lvl_Filial
Long ll_FIlial_Ecommerce

Date   lvdt_Inicio, &
       lvdt_Fim
	  
Tab_1.TabPage_1.dw_1.AcceptText()

ls_Pedido     			= Tab_1.TabPage_1.dw_1.Object.nr_pedido								[1]
lvs_Tipo_Venda 		= Tab_1.TabPage_1.dw_1.Object.tipo_venda								[1]
lvs_Situacao   			= Tab_1.TabPage_1.dw_1.Object.situacao									[1]
lvdt_Inicio    			= Tab_1.TabPage_1.dw_1.Object.dt_inicio									[1]
lvdt_Fim       			= RelativeDate(Tab_1.TabPage_1.dw_1.Object.dt_fim					[1],  1) 
lvl_Filial					= Tab_1.TabPage_1.dw_1.Object.cd_filial									[1]
ls_Rede					= Tab_1.TabPage_1.dw_1.Object.id_rede_ecommerce					[1]
lvs_Transportadora 	= Tab_1.TabPage_1.dw_1.Object.nm_transportadora					[1]
ls_id_ecommerce 		= Tab_1.TabPage_1.dw_1.Object.id_ecommerce							[1]
ls_Cpf_Cnpj	 			= Tab_1.TabPage_1.dw_1.Object.nr_cpf_cnpj								[1]
ls_id_impresso			= Tab_1.TabPage_1.dw_1.Object.id_impresso								[1]
ls_id_tipo_pedido 		= Tab_1.TabPage_1.dw_1.Object.id_tipo_pedido							[1]

if trim(ls_Cpf_Cnpj) = '' Then setnull(ls_Cpf_Cnpj)

If Not IsNull(ls_Cpf_Cnpj) and Trim(ls_Cpf_Cnpj) <> "" Then
	If LenA(ls_Cpf_Cnpj) <= 11 Then //CPF			
		If Not gf_Nr_CPF_Valido(ls_Cpf_Cnpj) Then
			Tab_1.TabPage_1.dw_1.Object.Nr_CPF_CNPJ[1] = ls_Cpf_Cnpj
			Return -1
		End If
	Else  //CNPJ
		If Not gf_CGC_Valido(ls_Cpf_Cnpj) Then
			Tab_1.TabPage_1.dw_1.Object.Nr_CPF_CNPJ[1] = ls_Cpf_Cnpj
			Return -1
		End If
	End If			
End If

If ls_Rede <> 'TD' Then
	This.of_Appendwhere("p.id_rede_ecommerce = '" + ls_Rede + "'")
End If

If (Not IsNull(lvs_Transportadora)) and (lvs_Transportadora <> "00") then
	if lvs_Transportadora = 'LS TRANSLOG' Then
		This.of_AppendWhere("(upper(p.nm_transportadora) in ('LS TRANSLOG','LS TRANSLOG ND','LS TRANSLOG SD'))")
	Else
		This.of_AppendWhere("(upper(p.nm_transportadora) = '" + lvs_Transportadora + "'" + " Or upper(p.nm_transportadora_ecommerce) like ('%" + lvs_Transportadora +"%'))")
	End if
End If

If Not IsNull(lvdt_Inicio) Then
	This.of_Appendwhere("p.dh_emissao >= '" + String(lvdt_Inicio, "yyyymmdd") + "'")
End If

If Not IsNull(lvdt_Fim) Then
	This.of_Appendwhere("p.dh_emissao < '" + String(lvdt_Fim, "yyyymmdd" ) + "'")
End If

if ls_id_ecommerce <> '0' Then
	
	if ls_id_ecommerce = '1'  Then //Vannon
		This.of_AppendWhere("p.nr_pedido_ecommerce_site is null")
		
	elseif ls_id_ecommerce = '2'  Then //Vtex
		This.of_AppendWhere("p.nr_pedido_ecommerce_site is not null")
		This.of_AppendWhere(" ( (p.id_plataforma_ecommerce <> '3' and p.id_plataforma_ecommerce <> '4') or p.id_plataforma_ecommerce is null ) ")
	
	elseif ls_id_ecommerce = '3' Then //Ifood
		This.of_AppendWhere("p.id_plataforma_ecommerce = '3'" )
	elseif ls_id_ecommerce = '4' Then //VM
		This.of_AppendWhere("p.id_plataforma_ecommerce = '4'" )		
	elseif ls_id_ecommerce = '5' Then //CR
		This.of_AppendWhere("p.id_plataforma_ecommerce = '5'" )				
	end if
	
end if

//If Not IsNull(lvl_Pedido) and lvl_Pedido > 0 Then
//	This.of_AppendWhere("p.nr_pedido_drogaexpress = '" + String(gvo_parametro.of_Filial(),'0000') + String(lvl_Pedido,'0000000') + "'")
//End If

//If Not IsNull(lvl_Pedido) and lvl_Pedido > 0 Then
//	This.of_AppendWhere("p.nr_pedido_ecommerce = " + String( lvl_Pedido ))
//End If

If Not IsNull(ls_Pedido) then
	If Len(Trim(ls_Pedido)) >= 15 or Not IsNumber(ls_Pedido) or pos( ls_pedido,'-',1) > 0 Then
		This.of_AppendWhere("p.nr_pedido_ecommerce_site = '" + ls_Pedido + "'")
	Else
		This.of_AppendWhere("p.nr_pedido_ecommerce = " + ls_Pedido)
	End If
End If
	
If Not IsNull(lvl_Filial) Then
	This.of_AppendWhere("p.cd_filial = " + String(lvl_Filial))
End If

If lvs_Tipo_Venda <> 'TD'Then
	This.of_AppendWhere("p.cd_tipo_venda = '" + lvs_Tipo_Venda + "'")
End If

If lvs_Situacao <> 'T' Then
	This.of_AppendWhere("p.id_situacao = '" + lvs_Situacao + "'")
End If

//CPF / CNPJ
If ls_Cpf_Cnpj <> 'T' Then
	This.of_AppendWhere("p.nr_cpf_cheque = '" + ls_Cpf_Cnpj + "'")
End If

Choose Case ls_id_impresso
	Case 'S'
		This.of_AppendWhere("p.dh_impressao is not null")
	Case 'N'
		This.of_AppendWhere("p.dh_impressao is null")
ENd Choose

if ls_id_tipo_pedido <> 'TOD' and not isnull(ls_id_tipo_pedido) Then
	This.of_AppendWhere("p.id_tipo_pedido = '" + ls_id_tipo_pedido + "'")
ENd if

Return 1
end event

event dw_2::rowfocuschanged;call super::rowfocuschanged;Integer lvi_Linha
		  
String 	lvs_Situacao,&
		lvs_Pedido,&
		lvs_Transportadora

Long lvl_Pedido_Ecommerce

DateTime ldt_Impressao

If Tab_1.TabPage_1.dw_2.RowCount() > 0   Then
	
	lvi_Linha    						= Tab_1.TabPage_1.dw_2.GetRow()
	lvs_Situacao 					= Tab_1.TabPage_1.dw_2.Object.id_situacao							[lvi_Linha]
	lvs_Pedido   					= Tab_1.TabPage_1.dw_2.Object.nr_pedido_drogaexpress			[lvi_Linha]
	lvl_Pedido_Ecommerce 		= Tab_1.TabPage_1.dw_2.Object.nr_pedido_ecommerce			[lvi_Linha]
	lvs_Transportadora			= Tab_1.TabPage_1.dw_2.Object.nm_transportadora				[lvi_Linha]
	ldt_Impressao					= Tab_1.TabPage_1.dw_2.Object.dh_impressao						[lvi_Linha]
	
	Tab_1.TabPage_1.dw_2.object.t_pedido_ecommerce_erp.text =  Tab_1.TabPage_1.dw_2.object.nr_pedido_vtex[lvi_Linha]
	
	Tab_1.TabPage_1.cb_Imprimir.Enabled = True
			
	If lvs_Situacao = "A" or lvs_Situacao = "F" or lvs_Situacao = "D" or lvs_Situacao = 'M' or lvs_Situacao = 'C' Then
		Tab_1.TabPage_1.cb_cancelar.Enabled = True		
	Else
		Tab_1.TabPage_1.cb_cancelar.Enabled = False
	End If
	
	If lvs_Situacao = "P" Then
		Tab_1.TabPage_1.cb_volta_situacao.Enabled = True		
	Else
		Tab_1.TabPage_1.cb_volta_situacao.Enabled = False
	End If	
	
	Tab_1.TabPage_1.cb_situacao.Visible = False
	
	If Not IsNull(lvl_Pedido_Ecommerce) Then
		
		dw_2.Object.st_nm_transportadora.Visible 			= 1
		dw_2.Object.st_Transportadora.Text 		 			= lvs_Transportadora
		
		If lvs_Transportadora = 'RETIRAR NA LOJA' Or lvs_Transportadora = 'ARM$$HEX1$$c100$$ENDHEX$$RIO INTELIGENTE' or lvs_Transportadora = 'MOTOBOY' or lvs_Transportadora = 'BIKER DELIVERY' Then
			If  lvs_Situacao = 'D' Then //D - Dispon$$HEX1$$ed00$$ENDHEX$$vel para Entrega
				Tab_1.TabPage_1.cb_situacao.Visible = True
				cb_situacao.Text = "&Pedido Entregue"
			End If
		End If
		
	Else
		dw_2.Object.st_nm_transportadora.Visible 			= 0
		dw_2.Object.st_Transportadora.Text 					= ""
	End If
Else
	Tab_1.TabPage_1.cb_Imprimir.Enabled = False
	Tab_1.TabPage_1.cb_cancelar.Enabled = False
End If
end event

event dw_2::constructor;//OverRide

String lvs_DataObject

This.of_SetTransObject(SqlCa)

lvs_DataObject = This.DataObject

If Trim(This.DataObject) <> "" Then
	ivs_SQL_Original = This.Object.DataWindow.Table.Select
End If

ivo_Controle_Menu = Create dc_uo_Menu_DW

ivo_Controle_Menu.of_SetDW(This)

SetNull(ivm_Menu)

This.of_GetParentWindow()

call super::constructor;

//This.of_SetRowSelection( "if (id_situacao = ~"X~", rgb(255, 0, 0), If(id_refaturado = ~"S~", rgb(255,165,0), if( not isnull( dh_impressao ), rgb(102, 205, 170), " + This.ivs_Cor_Linha_Padrao + ")))", "", False )
This.of_SetRowSelection( "if (id_situacao = ~"X~", rgb(255, 0, 0), If(id_refaturado = ~"S~", rgb(255,165,0), If( Not IsNull(dh_pausa_alerta), rgb(240,230,140), if( not isnull( dh_impressao ), rgb(102, 205, 170), " + This.ivs_Cor_Linha_Padrao + "))))", "", False )

// Habilitar a ordena$$HEX2$$e700e300$$ENDHEX$$o na coluna
This.ivb_Ordena_Colunas = True
end event

event dw_2::doubleclicked;call super::doubleclicked;string ls_valor
long ll_for

Choose Case dwo.name
	Case 'p_id_selecionado'
		
		if find('(id_plataforma_ecommerce <> "3") and id_selecionado = "N"',1,rowcount()) > 0 then
			ls_valor = 'S'
		Else
			ls_valor = 'N'
		END if
		
		for ll_for = 1 to rowcount()
			if this.object.id_plataforma_ecommerce[ll_for] = '3' then continue	// IFOOD
			//if this.object.id_plataforma_ecommerce[ll_for] = '5' then continue	// CONSULTA REM$$HEX1$$c900$$ENDHEX$$DIO

			this.object.id_selecionado[ll_for] = ls_valor
		Next
		
End Choose
end event

event dw_2::itemchanged;call super::itemchanged;if dwo.name = 'id_selecionado' then
	
	if data = 'S' and this.object.id_plataforma_ecommerce[row] = '3' then
		messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', "Pedidos do IFOOD devem ser impressos no SMR (Site Mercado Receptor de Pedido).")
		Return 1
	End If
//	if data = 'S' and this.object.id_plataforma_ecommerce[row] = '5' then
//		messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', "Pedidos do CONSULTA REM$$HEX1$$c900$$ENDHEX$$DIOS devem ser impressos na plataforma CR.")
//		Return 1
//	End If	
	
ENd if
end event

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_2det`tabpage_2 within tab_1
integer width = 3611
integer height = 1600
end type

type gb_4 from dc_w_2tab_consulta_selecao_lista_2det`gb_4 within tabpage_2
integer x = 14
integer y = 912
integer width = 3008
integer height = 672
string text = "Produtos do Pedido"
end type

type gb_3 from dc_w_2tab_consulta_selecao_lista_2det`gb_3 within tabpage_2
integer x = 14
integer y = 0
integer width = 3003
integer height = 908
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_2det`dw_3 within tabpage_2
integer x = 55
integer y = 48
integer width = 2930
integer height = 836
string dataobject = "dw_ge144_detalhe_pedido_cr"
end type

event dw_3::ue_recuperar;// OverRide
Long   lvl_Linha
String lvs_Nr_Pedido_DrogaExpress
		 
lvl_Linha                  = Tab_1.TabPage_1.dw_2.GetRow()
lvs_Nr_Pedido_DrogaExpress = Tab_1.TabPage_1.dw_2.Object.nr_pedido_drogaexpress[lvl_Linha]

Return This.Retrieve(lvs_Nr_Pedido_DrogaExpress)
end event

event dw_3::ue_postretrieve;call super::ue_postretrieve;If AncestorReturnValue = 1 Then
	
	This.AcceptText()

	Long lvl_Nr_Nf
	Long lvl_Filial
	Long lvl_Filial_Parametro
	Long lvl_Nr_CF
			 
	String lvs_Nr_Pedido_DrogaExpress, &
	       lvs_Situacao, &
			 lvs_De_Especie, &
			 lvs_De_Serie
	String ls_Especie_CF, ls_Serie_CF
	
	lvs_Nr_Pedido_DrogaExpress	= Tab_1.TabPage_2.dw_3.Object.nr_pedido_drogaexpress[1]
	lvs_Situacao               			= Tab_1.TabPage_2.dw_3.Object.Id_Situacao[1]
	lvl_Filial               					= Tab_1.TabPage_2.dw_3.Object.cd_filial[1]
	
	lvl_Filial_Parametro			= gvo_Parametro.Cd_Filial
	
	If (lvs_Situacao = 'F' or lvs_Situacao = 'R' or  lvs_Situacao = 'D' or lvs_Situacao = 'E' Or lvs_Situacao = 'L') And (lvl_Filial = lvl_Filial_Parametro) Then
		
		Select nr_nf,de_especie,de_serie
		Into :lvl_Nr_Nf,
			  :lvs_De_Especie,
			  :lvs_De_Serie
		from nf_venda
		where nr_pedido_drogaexpress = :lvs_Nr_Pedido_DrogaExpress
		  and dh_cancelamento is null
		  and de_especie = 'NFE'
		  LIMIT 1
		Using Sqlca;
		
		IF  SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgdbError("Verifica$$HEX2$$e700e300$$ENDHEX$$o da nota fiscal.")
			
			Tab_1.TabPage_2.dw_3.Object.Nr_Nf		[1] = ""
			Tab_1.TabPage_2.dw_3.Object.De_Especie	[1] = ""
			Tab_1.TabPage_2.dw_3.Object.De_Serie	[1] = ""
		End If
		
		Select nr_nf,de_especie,de_serie
		Into :lvl_Nr_CF,
			  :ls_Especie_CF,
			  :ls_Serie_CF
		from nf_venda
		where nr_pedido_drogaexpress = :lvs_Nr_Pedido_DrogaExpress
		  and dh_cancelamento is null
		  and de_especie = 'CF'
		  LIMIT 1
		Using Sqlca;
		
		If  SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgdbError("Verifica$$HEX2$$e700e300$$ENDHEX$$o da nota fiscal.")
			
			Tab_1.TabPage_2.dw_3.Object.Nr_Nf_cf			[1] = ""
			Tab_1.TabPage_2.dw_3.Object.De_Especie_cf	[1] = ""
			Tab_1.TabPage_2.dw_3.Object.De_Serie_cf	[1] = ""
		End If
			
		Tab_1.TabPage_2.dw_3.Object.Nr_Nf			[1] = String(lvl_Nr_Nf)
		Tab_1.TabPage_2.dw_3.Object.De_Especie		[1] = lvs_De_Especie
		Tab_1.TabPage_2.dw_3.Object.De_Serie		[1] = lvs_De_Serie
		Tab_1.TabPage_2.dw_3.Object.Nr_Nf_cf			[1] = String(lvl_Nr_CF)
		Tab_1.TabPage_2.dw_3.Object.De_Especie_cf	[1] = ls_Especie_CF
		Tab_1.TabPage_2.dw_3.Object.De_Serie_cf	[1] = ls_Serie_CF
	
	Else
		Tab_1.TabPage_2.dw_3.Object.Nr_Nf			[1] = ""
		Tab_1.TabPage_2.dw_3.Object.De_Especie		[1] = ""
		Tab_1.TabPage_2.dw_3.Object.De_Serie		[1] = ""
		Tab_1.TabPage_2.dw_3.Object.Nr_Nf_cf			[1] = ""
		Tab_1.TabPage_2.dw_3.Object.De_Especie_cf	[1] = ""
		Tab_1.TabPage_2.dw_3.Object.De_Serie_cf	[1] = ""
	End If
End If

Return pl_linhas
end event

event dw_3::constructor;call super::constructor;// Habilitar a coluna de sele$$HEX2$$e700e300$$ENDHEX$$o (freform)
This.of_SetColSelection(True)
end event

type dw_4 from dc_w_2tab_consulta_selecao_lista_2det`dw_4 within tabpage_2
integer x = 41
integer y = 960
integer width = 2958
integer height = 592
string dataobject = "dw_ge144_lista_detalhe_pedido"
boolean vscrollbar = true
end type

event dw_4::ue_recuperar;// OverRide

Long lvl_Linha

lvl_Linha = Tab_1.TabPage_1.dw_2.GetRow()

Return This.Retrieve(Tab_1.TabPage_1.dw_2.Object.nr_pedido_drogaexpress[lvl_Linha])
end event

event dw_4::ue_postretrieve;call super::ue_postretrieve;Long ll_Pedido_EC, ll_Requisicao, ll_Produto, ll_Row_dw2
Long ll_row, ll_Filial_EC
Long ll_NF
String ls_especie, ls_serie, ls_pedido_drogaexpress

IF pl_Linhas > 0 Then
	ll_Row_dw2 = tab_1.TabPage_1.dw_2.GetRow()
	
	ll_Pedido_EC	 			= tab_1.TabPage_1.dw_2.Object.nr_pedido_ecommerce	[ ll_Row_dw2 ]
	ll_Filial_EC	 				= tab_1.TabPage_1.dw_2.Object.cd_filial_ecommerce		[ ll_Row_dw2 ]
	ls_pedido_drogaexpress 	= tab_1.TabPage_1.dw_2.Object.nr_pedido_drogaexpress	[ ll_Row_dw2 ] 
	
	For ll_row = 1 To pl_Linhas
		ll_Produto = This.Object.cd_produto[ ll_row ]
		
		SELECT i.nr_nf, i.de_especie, i.de_serie
			INTO :ll_NF, :ls_especie, :ls_serie
		FROM nf_venda n
			INNER JOIN item_nf_venda i
			 ON i.cd_filial  = n.cd_filial
			AND i.nr_nf 	 = n.nr_nf
			AND i.de_especie = n.de_especie
			AND i.de_serie	 = n.de_serie
		WHERE n.nr_pedido_drogaexpress 	= :ls_pedido_drogaexpress
		AND n.cd_filial_ecommerce 				= :ll_Filial_EC
		AND i.cd_produto 							= :ll_Produto
		AND n.dh_cancelamento IS NULL		
		AND coalesce(n.id_cancelamento_impressora, 'N' ) = 'N'
		LIMIT 1
		USING Sqlca;
		
		Choose Case SqlCa.SqlCode 
			Case -1
				SqlCa.of_MsgDbError("ERRO ao localizar a nota fiscal do produto, " + String(ll_Produto))
				Exit
			Case 100
				SetNull(ll_NF)
				SetNull(ls_especie)
				SetNull(ls_serie)
		End Choose
		
		This.Object.nr_nf			[ ll_row ] = ll_NF
		This.Object.de_especie	[ ll_row ] = ls_especie
		This.Object.de_serie		[ ll_row ] = ls_serie
				
	Next
	
End If

Return pl_Linhas
end event

event dw_4::constructor;call super::constructor;//if( Not IsNull(dh_atualizacao_estoque), rgb(144,238,144), rgb(255,255,255))

This.of_SetRowSelection( "if (Not IsNull(nr_nf), rgb(255, 140, 105), " + This.ivs_Cor_Linha_Padrao + ")", "", True )
end event

type cb_cancelar from commandbutton within tabpage_1
integer x = 3205
integer y = 232
integer width = 361
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
string text = "&Cancelar"
end type

event clicked;Boolean lvb_Sucesso = False

Long lvl_Linha, &
	 lvl_Filial,&
	 lvl_Pedido_Ecommerce 

Long ll_Filial_Ecommerce

String lvs_Situacao, &
       lvs_Matricula, &
       lvs_Pedido,&
		 ls_Pedido_Vtex,&
		 ls_Msg,&
		 ls_Usuario, &
		 ls_Plataforma

DateTime lvdh_Sistema

Tab_1.TabPage_1.dw_2.AcceptText()

lvl_Linha    		 			= Tab_1.TabPage_1.dw_2.GetRow()
lvs_Situacao 		 		= Tab_1.TabPage_1.dw_2.Object.id_situacao					[lvl_linha]
lvl_Pedido_Ecommerce	= Tab_1.TabPage_1.dw_2.Object.nr_pedido_ecommerce	[lvl_linha]
ll_Filial_Ecommerce		= Tab_1.TabPage_1.dw_2.Object.cd_filial_ecommerce		[lvl_linha]
ls_Pedido_Vtex				= Tab_1.TabPage_1.dw_2.Object.nr_pedido_vtex				[lvl_linha]
ls_Plataforma					= Tab_1.TabPage_1.dw_2.Object.id_plataforma_ecommerce	[lvl_linha]

If Trim(ls_Pedido_Vtex) = '' Then SetNull(ls_Pedido_Vtex)

If lvl_Linha <= 0 Then Return

// IFOOD
If ls_Plataforma = '3' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O pedido do IFOOD dever$$HEX1$$e100$$ENDHEX$$ ser cancelado pelo portal do parceiro: https://portal.ifood.com.br/", Exclamation!)
	Return 
End If

// IFOOD
If ls_Plataforma = '5' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O pedido do Consulta Rem$$HEX1$$e900$$ENDHEX$$dios dever$$HEX1$$e100$$ENDHEX$$ ser cancelado pelo portal do parceiro......", Exclamation!)
	Return 
End If

If lvs_Situacao = "A" or lvs_Situacao = "F" or lvs_Situacao = "D" or lvs_Situacao = 'M'  or lvs_Situacao = 'C' Then
	
	If lvs_Situacao = "A" Then
		If Not IsNull(ls_Pedido_Vtex) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Pedidos com a situa$$HEX2$$e700e300$$ENDHEX$$o [Aberto] dever$$HEX1$$e300$$ENDHEX$$o ser cancelados pelo atendimento do e-commerce na matriz.")
			Return
		End If
	End If
	
//	If IsNull(gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("CANCELAMENTO_PEDIDO")) Then
//		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Usu$$HEX1$$e100$$ENDHEX$$rio n$$HEX1$$e300$$ENDHEX$$o tem acesso a este procedimento.", StopSign!)
//		Return
//	End If
	
	If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("W_GE144_CANCELAMENTO_PEDIDO", Ref lvs_Matricula) Then
		Return
	End If
	
	SELECT nm_usuario 
	INTO :ls_Usuario 
	FROM usuario 
	WHERE nr_matricula = :lvs_Matricula 
	Using SqlCa;
	
	If SqlCa.SqlCode =-1 Then
		SqlCa.of_MsgDbError( "Verifica$$HEX2$$e700e300$$ENDHEX$$o do nome do usu$$HEX1$$e100$$ENDHEX$$rio" )
		Return
	End If

	lvs_Pedido = Tab_1.TabPage_1.dw_2.Object.Nr_Pedido_DrogaExpress[lvl_linha]
	
	// Se for pedido do eCommerce
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja cancelar o pedido '" +String(lvl_Pedido_Ecommerce) + "' ?",Question!, YesNo!, 2) = 2 Then	
		Return 
	End If
		
	lvdh_Sistema   = Datetime(Today(),Now())
	lvl_Filial   	 	= gvo_Parametro.of_Filial()
	
	lvb_Sucesso = False
	
	Update pedido_drogaexpress
	Set id_situacao               = 'X',
		 nr_matricula_cancelamento = :lvs_Matricula,
		 nr_cartao_credito			= null,
		 cd_seguranca_cartao	= null,
		 dh_validade_cartao		= null
	Where cd_filial					= :lvl_Filial
	  and nr_pedido_drogaexpress = :lvs_Pedido 			  
	Using SqlCa;
				
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_RollBack()
		Sqlca.Of_MsgDbError("Cancelamento de Pedido")
	Else
		If IsNull(lvl_Pedido_Ecommerce) Then
			lvb_Sucesso = True
		Else
			lvb_Sucesso = wf_Atualiza_Pedido_Ecommerce_Matriz(ll_Filial_Ecommerce, lvl_Pedido_Ecommerce, lvs_Matricula, 'X')
			If (lvb_Sucesso) Then
				If IsNull(ls_Pedido_Vtex) Then
					lvb_Sucesso = wf_Cancela_Comprovante_Cartao(lvl_Filial, lvs_Pedido, lvs_Situacao)
				Else
					If ls_Plataforma = '4' Then
						lvb_Sucesso = wf_Cancela_Comprovante_Cartao(lvl_Filial, lvs_Pedido, lvs_Situacao)
					End If
				End If
			End If
		End If
		
		If lvb_Sucesso Then
			SqlCa.of_Commit();
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Pedido '" + String(lvl_Pedido_Ecommerce) + "' cancelado com sucesso.", Information!)
			
			ls_Msg = "<strong>Pedido:</strong> " + String( lvl_Pedido_Ecommerce ) + "<br />"
			
			If Not IsNull(ls_Pedido_Vtex) Then
				ls_Msg += "<strong>Pedido SITE:</strong> " + ls_Pedido_Vtex + "<br />"				
			End If
			
			ls_Msg += "<strong>Filial:</strong> " + String( gvo_Parametro.cd_filial ) + " - " + gvo_Parametro.nm_fantasia_filial + "<br />"
			ls_Msg += "<strong>Executado por:</strong> " + lvs_Matricula + ' - ' + ls_Usuario + "<br /><br />"
			
			gf_ge202_envia_email_log( 109, '[' + gvo_aplicacao.ivo_seguranca.cd_sistema + '] - Cancelamento de Pedido e-Commerce', ls_Msg, True, True )	
			
		Else
			SqlCa.of_RollBack();
			Sqlca.Of_MsgDbError("Cancelamento de Pedido")
		End If
			
		Tab_1.TabPage_1.dw_2.Event ue_Retrieve()
	End If
	
Else
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Somente pedidos abertos podem ser cancelados.",Information!)
End If
end event

type cb_imprimir from commandbutton within tabpage_1
integer x = 3200
integer y = 24
integer width = 366
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
string text = "&Imprimir"
end type

event clicked;String ls_Pedido
String ls_Situacao
String ls_Mensagem
String ls_Plataforma
String ls_id_selecionado

DateTime ldt_Impresso

Long ll_Linha, ll_total
Long ll_Pedido_eCommerce
Long ll_for, ll_resposta
boolean lb_avisa_reeimpressao=false

Try

	Tab_1.TabPage_1.dw_2.setfilter('id_selecionado = "S"')
	Tab_1.TabPage_1.dw_2.filter()
	
	ll_total = Tab_1.TabPage_1.dw_2.rowcount()
	
	If ll_total = 0 then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um pedido para imprimi-lo.", Exclamation!)
		Return 
	ENd if
	
	if ll_total > 1 then
		if messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Foram selecionados ' + string(ll_total) + ' pedidos para impress$$HEX1$$e300$$ENDHEX$$o. Deseja imprimir?', question!, yesno!, 2) = 2 then return -1
	ENd if
	
	For ll_linha = 1 to ll_total
	
		ls_Pedido						= Tab_1.TabPage_1.dw_2.Object.Nr_Pedido_Drogaexpress		[ll_Linha]
		ll_Pedido_eCommerce		= Tab_1.TabPage_1.dw_2.Object.Nr_Pedido_eCommerce		[ll_Linha]
		ls_Plataforma					= Tab_1.TabPage_1.dw_2.Object.id_plataforma_ecommerce	[ll_Linha]
		ls_id_selecionado				= Tab_1.TabPage_1.dw_2.Object.id_selecionado					[ll_Linha]
		
		if ls_id_selecionado = 'N' Then Continue
		
		// IFOOD 
		If ls_Plataforma = '3' Then
			Continue
		End If
		
		If Not IsNull(ll_Pedido_eCommerce) Then
				
				If Not wf_Verica_impressao(ls_Pedido, Ref ldt_Impresso, Ref ls_Situacao ) Then Return
				 
				If Not IsNull( ldt_Impresso ) Then
					//Se o pedido j$$HEX1$$e100$$ENDHEX$$ foi impresso:
					
					//Verificar se o usu$$HEX1$$e100$$ENDHEX$$rio deseja reimprimir:
					if lb_avisa_reeimpressao = false Then
						lb_avisa_reeimpressao = True
						
						ll_resposta = MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "H$$HEX1$$e100$$ENDHEX$$ pedidos selecionados que j$$HEX1$$e100$$ENDHEX$$ foram impressos anteriormente.~r" + &
												"Deseja imprimi-los novamente?", Question!, YesNoCancel!, 2)
												
					End if
						
					if ll_resposta = 1 Then //Sim
						ivo_Pedido.of_imprime_ecommerce(ls_Pedido)
						
						if Not wf_atualiza_impressao( ls_Pedido ) then return -1
						
						Continue
						
					Elseif ll_resposta = 3 then //Cancelar
						Exit
					else //Nao
						Continue
					ENd if
						
				Else		
					//Se o pedido nunca foi impresso:
					
					//Imprimir o pedido
					ivo_Pedido.of_imprime_ecommerce( ls_Pedido )
				
					//Atualizar a data de Impressao
					if Not wf_atualiza_impressao( ls_Pedido ) then return -1
						
				End If
			
		Else
			ivo_Pedido.of_imprime(ls_Pedido)
		End If
	
	Next

Finally

	Tab_1.TabPage_1.dw_2.setfilter('')

	dw_2.Event ue_Retrieve()
				
	dw_2.SetRow( ll_Linha )
	
ENd try
end event

type cb_situacao from commandbutton within tabpage_1
string tag = "O pedido foi remetido para o correio."
boolean visible = false
integer x = 3058
integer y = 128
integer width = 507
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Remetido Correio"
end type

event clicked;String 	lvs_Texto,&
		lvs_Situacao,&
		lvs_Matricula,&
		lvs_Mensagem,&
		lvs_Pedido
		
Long lvl_Pedido_Ecommerce, ll_Filial_Ecommerce

dw_2.AcceptText()

lvl_Pedido_Ecommerce 	= dw_2.Object.nr_pedido_ecommerce		[dw_2.GetRow()]
lvs_Pedido			 		= dw_2.Object.nr_pedido_drogaexpress		[dw_2.GetRow()]
ll_Filial_Ecommerce		= dw_2.Object.cd_filial_ecommerce			[dw_2.GetRow()]

lvs_Texto = cb_situacao.Text

If lvs_Texto = "&Remetido Correio" Then
	// Remetido
	lvs_Situacao = 'M'
	lvs_Mensagem = "REMETIDO"
Else
	// Entregue
	lvs_Situacao = 'E'
	lvs_Mensagem = "ENTREGUE"
End If

If MessageBox(	"Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a altera$$HEX2$$e700e300$$ENDHEX$$o do pedido eCommerce para '" +&
	lvs_Mensagem + "' ?", Question!, YesNo!, 2) = 2 Then
	Return -1
End If

Update pedido_drogaexpress
Set  id_situacao = :lvs_Situacao
Where nr_pedido_drogaexpress = :lvs_Pedido 			  
Using SqlCa;
			
If SqlCa.SqlCode = -1 Then
	SqlCa.of_RollBack();
	Sqlca.Of_MsgDbError("Altera$$HEX2$$e700e300$$ENDHEX$$o da situa$$HEX2$$e700e300$$ENDHEX$$o do pedido drogaexpress")	
Else
	lvs_Matricula = gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
	
	If wf_Atualiza_Pedido_Ecommerce_Matriz(ll_Filial_Ecommerce, lvl_Pedido_Ecommerce, lvs_Matricula, lvs_Situacao) Then
		
		SqlCa.of_Commit();
		
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O pedido foi alterado com sucesso.")
		
		dw_2.Event ue_Retrieve()
	Else
		SqlCa.of_RollBack();
	End If
End If
end event

type cb_volta_situacao from commandbutton within tabpage_1
integer x = 3081
integer y = 336
integer width = 489
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
string text = "&Voltar Situa$$HEX2$$e700e300$$ENDHEX$$o"
end type

event clicked;Boolean lvb_Sucesso = False

Long lvl_Linha, &
	 lvl_Filial,&
	 lvl_Pedido_Ecommerce 

Long ll_Filial_Ecommerce, &
	   ll_cont

String lvs_Situacao, &
       lvs_Matricula, &
       lvs_Pedido,&
		 ls_Pedido_Vtex,&
		 ls_Msg,&
		 ls_Usuario, &
		 ls_Plataforma

DateTime lvdh_Sistema

Tab_1.TabPage_1.dw_2.AcceptText()

lvl_Linha    		 			= Tab_1.TabPage_1.dw_2.GetRow()
lvs_Situacao 		 		= Tab_1.TabPage_1.dw_2.Object.id_situacao					[lvl_linha]
lvl_Pedido_Ecommerce	= Tab_1.TabPage_1.dw_2.Object.nr_pedido_ecommerce	[lvl_linha]
ll_Filial_Ecommerce		= Tab_1.TabPage_1.dw_2.Object.cd_filial_ecommerce		[lvl_linha]
lvs_Pedido					= Tab_1.TabPage_1.dw_2.Object.nr_pedido_drogaexpress	[lvl_linha]

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Esta a$$HEX2$$e700e300$$ENDHEX$$o s$$HEX1$$f300$$ENDHEX$$ deve ser usada caso tenha~r" + & 
								 "iniciado o faturamento e por algum motivo~r" + &
								 "foi interrompido indevidamente.~r" +&
								 "~r" +&
								"Deseja retornar a situa$$HEX2$$e700e300$$ENDHEX$$o do pedido "+ String(lvl_Pedido_Ecommerce) + " para ABERTO?",Question!,YesNo!,1) = 2 Then Return

If lvl_Linha <= 0 Then Return
	
Select count(*) Into :ll_cont
From pedido_drogaexpress
where nr_pedido_drogaexpress = :lvs_pedido
  and id_situacao = 'P'
Using Sqlca;

If Sqlca.SqlCode = -1 Then
	SqlCa.of_MsgDbError( 'Verifca Pedidos.' )
	Return
Else
	If ll_cont <= 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Pedido informado n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ com situa$$HEX2$$e700e300$$ENDHEX$$o Faturando!",Exclamation!)
		Return
	End If		
End If

lvl_Filial   	 	= gvo_Parametro.of_Filial()
	
Update pedido_drogaexpress
Set id_situacao               = 'A'
Where cd_filial					= :lvl_Filial
  and nr_pedido_drogaexpress = :lvs_Pedido 			  
Using SqlCa;
			
If SqlCa.SqlCode = -1 Then
	SqlCa.of_RollBack()
	Sqlca.Of_MsgDbError("Volta situa$$HEX2$$e700e300$$ENDHEX$$o Pedido")
Else
	SqlCa.of_Commit();
	Sqlca.of_end_transaction()
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Pedido '" + String(lvl_Pedido_Ecommerce) + "' retornado para situa$$HEX2$$e700e300$$ENDHEX$$o ABERTO com sucesso.", Information!)
		
	Tab_1.TabPage_1.dw_2.Event ue_Retrieve()
End If
end event

type cb_pausar_alerta from commandbutton within tabpage_1
integer x = 3081
integer y = 444
integer width = 489
integer height = 100
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Alterar Alerta"
end type

event clicked;Boolean lb_Pausar_Alerta

Long ll_Row, ll_Pedido_Ecommerce

String ls_Matricula, ls_pedido_drogaexpress, ls_Mensagem, ls_Situacao

DateTime ldt_Pausa_Alerta

Tab_1.TabPage_1.dw_2.AcceptText()

ll_Row = Tab_1.TabPage_1.dw_2.GetRow()

If ll_Row = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Nenhum pedido foi selecionado.", Exclamation!)
	Return -1
End If

ll_Pedido_Ecommerce		= Tab_1.TabPage_1.dw_2.Object.nr_pedido_ecommerce 	[ ll_Row ]
ls_pedido_drogaexpress	= Tab_1.TabPage_1.dw_2.Object.nr_pedido_drogaexpress	[ ll_Row ]
ldt_Pausa_Alerta			= Tab_1.TabPage_1.dw_2.Object.dh_pausa_alerta			[ ll_Row ]
ls_Situacao					= Tab_1.TabPage_1.dw_2.Object.id_situacao					[ ll_Row ]

If ls_Situacao <> 'A' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Apenas pedido com a situa$$HEX2$$e700e300$$ENDHEX$$o 'ABERTO' pode ser selecionado.", Exclamation!)
	Return -1
End If

If IsNull(ldt_Pausa_Alerta) Then
	lb_Pausar_Alerta = True
	ls_Mensagem = "Deseja pausar o alerta de faturamento pendente para o pedido: " + String(ll_Pedido_Ecommerce ) + " ?"
Else
	lb_Pausar_Alerta = False
	ls_Mensagem = "Deseja iniciar o alerta de faturamento pendente para o pedido: " + String(ll_Pedido_Ecommerce ) + " ?"
End If

If Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Mensagem, Question!, YesNo!) = 2 Then
	Return -1
End If

If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("W_GE144_PAUSAR_ALERTA_PEDIDO_PENDENTE", Ref ls_Matricula) Then
	Return -1
End If

If lb_Pausar_Alerta Then
	ldt_Pausa_Alerta = gf_GetServerDate()
Else
	SetNull(ldt_Pausa_Alerta)
	SetNull(ls_Matricula)
End If

Update pedido_drogaexpress
	set dh_pausa_alerta 					= :ldt_Pausa_Alerta,
		 nr_matricula_pausa_alerta 		= :ls_Matricula
	Where nr_pedido_drogaexpress 	= :ls_pedido_drogaexpress
Using SqlCa;	

If SqlCa.SqlCode = -1 Then
	SqlCa.of_Rollback()
	SqlCa.of_msgdberror("Erro ao atualizar a pausa de alerta de pedido ecommerce.")
	Return -1	
Else
	SqlCa.of_Commit()
End If

Tab_1.TabPage_1.dw_2.Event ue_Retrieve()

SqlCa.of_End_Transaction( ) // Finaliza a transa$$HEX2$$e700e300$$ENDHEX$$o


end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3611
integer height = 1600
long backcolor = 80269524
string text = "Observa$$HEX2$$e700f500$$ENDHEX$$es"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
gb_5 gb_5
dw_6 dw_6
end type

on tabpage_3.create
this.gb_5=create gb_5
this.dw_6=create dw_6
this.Control[]={this.gb_5,&
this.dw_6}
end on

on tabpage_3.destroy
destroy(this.gb_5)
destroy(this.dw_6)
end on

type gb_5 from groupbox within tabpage_3
integer x = 9
integer width = 1733
integer height = 592
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

type dw_6 from dc_uo_dw_base within tabpage_3
integer x = 23
integer y = 40
integer width = 1705
integer height = 536
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge144_obs"
end type

event ue_recuperar;// OverRide
Long   lvl_Linha
String lvs_Nr_Pedido_DrogaExpress
		 
lvl_Linha                  = Tab_1.TabPage_1.dw_2.GetRow()
lvs_Nr_Pedido_DrogaExpress = Tab_1.TabPage_1.dw_2.Object.nr_pedido_drogaexpress[lvl_Linha]

Return This.Retrieve(lvs_Nr_Pedido_DrogaExpress)
end event

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3611
integer height = 1600
long backcolor = 80269524
string text = "Receita"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_5 dw_5
end type

on tabpage_4.create
this.dw_5=create dw_5
this.Control[]={this.dw_5}
end on

on tabpage_4.destroy
destroy(this.dw_5)
end on

type dw_5 from dc_uo_dw_base within tabpage_4
integer width = 3543
integer height = 1608
integer taborder = 20
string dataobject = "dw_ge144_detalhe_pedido_receita"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event ue_recuperar;// OverRide
Long   lvl_Linha
String lvs_Nr_Pedido_DrogaExpress
		 
lvl_Linha                  = Tab_1.TabPage_1.dw_2.GetRow()
lvs_Nr_Pedido_DrogaExpress = Tab_1.TabPage_1.dw_2.Object.nr_pedido_drogaexpress[lvl_Linha]

Return This.Retrieve(lvs_Nr_Pedido_DrogaExpress)
end event

event constructor;call super::constructor;This.of_SetRowSelection()
end event

