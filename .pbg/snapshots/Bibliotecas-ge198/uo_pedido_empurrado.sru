HA$PBExportHeader$uo_pedido_empurrado.sru
forward
global type uo_pedido_empurrado from nonvisualobject
end type
end forward

global type uo_pedido_empurrado from nonvisualobject
end type
global uo_pedido_empurrado uo_pedido_empurrado

forward prototypes
public function boolean of_proximo_pedido (long al_filial, ref long al_pedido)
public function boolean of_pedido_nao_processado (long al_filial, ref long al_pedido)
public function boolean of_inclui_pedido (long al_filial, ref long al_pedido)
public function boolean of_produto_colocado (long al_filial, long al_produto, string as_tipo_pedido)
public function boolean of_exclui_produto_pedido (long al_filial, long al_pedido, long al_produto, long al_qt_atual, boolean ab_grava_historico)
public function boolean of_cancela_produto_pedido (long al_filial, long al_pedido, long al_produto)
public function boolean of_descancela_produto_pedido (long al_filial, long al_pedido, long al_produto)
public function boolean of_localiza_motivo (long al_filial, long al_pedido, long al_produto, ref string as_de_motivo, ref string as_id_tipo)
public function boolean of_produto_colocado (long al_filial, long al_produto, string as_tipo_pedido, long al_nr_pedido_existente)
public function boolean of_atualiza_produto_pedido (long al_filial, long al_pedido, long al_produto, long al_qt_nova, long al_qt_atual, boolean ab_grava_historico, long al_cd_motivo, long al_cd_motivo_atual, long al_qt_aprovada)
public function boolean of_inclui_produto_pedido (long al_filial, long al_pedido, long al_produto, long al_qt_nova, boolean ab_grava_historico, long al_cd_motivo, long al_qt_aprovada)
end prototypes

public function boolean of_proximo_pedido (long al_filial, ref long al_pedido);Select max(nr_pedido_empurrado) Into :al_Pedido
From pedido_empurrado
Where cd_filial = :al_filial
Using Sqlca;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Pr$$HEX1$$f300$$ENDHEX$$ximo Pedido")
	Return False
End If

If IsNull(al_Pedido) Then al_Pedido = 0
al_Pedido ++

Return True
end function

public function boolean of_pedido_nao_processado (long al_filial, ref long al_pedido);Boolean lvb_Sucesso = True

Select nr_pedido_empurrado Into :al_Pedido
From pedido_empurrado
Where cd_filial     = :al_Filial
  and id_processado = 'N'
  and id_situacao = 'C'
  and (id_tipo_pedido is null or id_tipo_pedido = 'E')
Using SqlCa;

Choose Case SqlCa.Sqlcode
	Case 100
		SetNull(al_Pedido)
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Pedido")
		SetNull(al_Pedido)
		lvb_Sucesso = False
End Choose

Return lvb_Sucesso
end function

public function boolean of_inclui_pedido (long al_filial, ref long al_pedido);If Not This.of_Proximo_Pedido(al_Filial, ref al_Pedido) Then Return False

Insert Into pedido_empurrado (cd_filial,
										nr_pedido_empurrado,
										dh_emissao,
										id_processado,
										id_tipo_pedido,
										id_situacao,
										id_reserva_saldo_cd,
										dh_inclusao,
										nr_matricula_inclusao)
Select :al_Filial,
		 :al_Pedido,
		 dh_movimentacao,
		 'N',
		 'E',
		 'C',
		 'N',
		 getdate(),
		 :gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
From parametro
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Inclus$$HEX1$$e300$$ENDHEX$$o do Pedido Empurrado")
	Return False
End If

Return True
end function

public function boolean of_produto_colocado (long al_filial, long al_produto, string as_tipo_pedido);Long	ll_null


SetNull(ll_null)

return of_produto_colocado(al_filial, al_produto, as_tipo_pedido, ll_null)
end function

public function boolean of_exclui_produto_pedido (long al_filial, long al_pedido, long al_produto, long al_qt_atual, boolean ab_grava_historico);String ls_Erro
String ls_Chave

String ls_Msg
String ls_Nulo

Delete From pedido_empurrado_produto
Where cd_filial = :al_Filial
	And nr_pedido_empurrado = :al_Pedido
	And cd_produto = :al_Produto
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SqlErrText
	SqlCa.of_Rollback();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao excluir o produto '" + String(al_Produto) + "' do pedido '" +  String(al_Pedido) + "' da filial '" + String(al_Filial) + "'. " + ls_Erro, StopSign!)
	Return False
End If

If ab_grava_historico Then
	ls_Chave = String(al_Filial) + "@#!" + String(al_Pedido) + "@#!" + String(al_Produto)
	SetNull(ls_Nulo)
	
	gf_Grava_Historico_Alteracao_Tabela('PEDIDO_EMPURRADO_PRODUTO', ls_Chave, 'QT_EMPURRADA', String(al_Qt_Atual), ls_Nulo, gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'E', Ref ls_Msg, True)
End If

Return True
end function

public function boolean of_cancela_produto_pedido (long al_filial, long al_pedido, long al_produto);String ls_Chave
String ls_Erro
String ls_Msg

Update pedido_empurrado_produto
	Set id_situacao = 'X'
Where cd_filial					= :al_Filial
  and nr_pedido_empurrado	= :al_Pedido
  and cd_produto				= :al_Produto
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SqlErrText
	SqlCa.of_Rollback();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao cancelar o produto '" + String(al_Produto) + "' do pedido empurrado '" + String(al_Pedido) + "' da filial '" + String(al_Filial) + "'.", StopSign!)
	Return False
End If

//ls_Chave = String(al_Filial) + "@#!" + String(al_Pedido) + "@#!" + String(al_Produto)

//gf_Grava_Historico_Alteracao_Tabela('PEDIDO_EMPURRADO_PRODUTO', ls_Chave, "ID_SITUACAO", "C", "X", gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, "A", Ref ls_Msg, True)
end function

public function boolean of_descancela_produto_pedido (long al_filial, long al_pedido, long al_produto);String ls_Chave
String ls_Erro
String ls_Msg

Update pedido_empurrado_produto
	Set id_situacao = 'C'
Where cd_filial					= :al_Filial
  and nr_pedido_empurrado	= :al_Pedido
  and cd_produto				= :al_Produto
  and id_situacao				= 'X'
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SqlErrText
	SqlCa.of_Rollback();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao descancelar o produto '" + String(al_Produto) + "' do pedido empurrado '" + String(al_Pedido) + "' da filial '" + String(al_Filial) + "'.", StopSign!)
	Return False
End If

//ls_Chave = String(al_Filial) + "@#!" + String(al_Pedido) + "@#!" + String(al_Produto)

//gf_Grava_Historico_Alteracao_Tabela('PEDIDO_EMPURRADO_PRODUTO', ls_Chave, "ID_SITUACAO", "X", "C", gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, "A", Ref ls_Msg, True)
end function

public function boolean of_localiza_motivo (long al_filial, long al_pedido, long al_produto, ref string as_de_motivo, ref string as_id_tipo);Long ll_cd_motivo

Select  coalesce(a.de_motivo_empurrado,''), c.id_tipo_pedido
into :as_de_motivo, :as_id_tipo
FROM pedido_empurrado c 
inner Join pedido_empurrado_produto b
	on b.nr_pedido_empurrado = c.nr_pedido_empurrado
	and b.cd_filial = c.cd_filial
left join pedido_empurrado_motivo a
 on a.cd_motivo_empurrado = b.cd_motivo_empurrado
where  b.cd_filial = :al_filial
	and b.nr_pedido_empurrado = :al_pedido
	and b.cd_produto = :al_produto
Using sqlCA;

Choose Case SqlCa.SqlCode
	Case 100
		as_de_motivo = ''
		
	Case -1	
		SqlCa.of_MsgdbError("Erro ao localizar o motivo do pedido empurrado Nr$$HEX1$$ba00$$ENDHEX$$ " + String(al_pedido)+".")
		Return False
End Choose 

Return True
end function

public function boolean of_produto_colocado (long al_filial, long al_produto, string as_tipo_pedido, long al_nr_pedido_existente);Boolean lvb_Existe = True

String lvs_Mensagem

Long lvl_Pedido, &
     lvl_Qtde_Empurrada, &
	  lvl_Qtde_Faturada

DateTime lvdh_Emissao

Select b.nr_pedido_empurrado,
       a.dh_emissao,
		 b.qt_empurrada,
		 b.qt_faturada
Into :lvl_Pedido,
     :lvdh_Emissao,
	  :lvl_Qtde_Empurrada,
	  :lvl_Qtde_Faturada
From pedido_empurrado_produto b,
     pedido_empurrado a
Where b.cd_filial   = :al_Filial
  and b.cd_produto  = :al_Produto
  and b.id_situacao = 'C'
  and a.cd_filial           = b.cd_filial
  and a.nr_pedido_empurrado = b.nr_pedido_empurrado
  and a.id_processado = 'S'
  and (a.id_tipo_pedido is null or a.id_tipo_pedido = 'E')
  and (:al_nr_pedido_existente is null 
  or a.nr_pedido_empurrado <> :al_nr_pedido_existente)
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If as_Tipo_Pedido = "F" Then
			lvs_Mensagem = "O produto '" + String(al_Produto) + "' ainda possui unidades a receber referentes a um pedido anterior.~r~r" + &
								"N$$HEX1$$fa00$$ENDHEX$$mero do Pedido : " + String(lvl_Pedido) + "~r" + &
								"Data : " + String(lvdh_Emissao, "dd/mm/yyyy") + "~r~r" + &
								"Qtde. Colocada : " + String(lvl_Qtde_Empurrada) + "~r" + &
								"Qtde. Faturada : " + String(lvl_Qtde_Faturada) + "~r" + &
								"Qtde. Receber : " + String(lvl_Qtde_Empurrada - lvl_Qtde_Faturada) + "~r~r" + &
								"Voc$$HEX1$$ea00$$ENDHEX$$ deve retirar o produto deste pedido, ou ent$$HEX1$$e300$$ENDHEX$$o, cancelar a pend$$HEX1$$ea00$$ENDHEX$$ncia do pedido acima citado."							
		Else
			lvs_Mensagem = "A filial '" + String(al_Filial) + "' ainda possui unidades a receber referentes a um pedido anterior.~r~r" + &
								"N$$HEX1$$fa00$$ENDHEX$$mero do Pedido : " + String(lvl_Pedido) + "~r" + &
								"Data : " + String(lvdh_Emissao, "dd/mm/yyyy") + "~r~r" + &
								"Qtde. Colocada : " + String(lvl_Qtde_Empurrada) + "~r" + &
								"Qtde. Faturada : " + String(lvl_Qtde_Faturada) + "~r" + &
								"Qtde. Receber : " + String(lvl_Qtde_Empurrada - lvl_Qtde_Faturada) + "~r~r" + &
								"Voc$$HEX1$$ea00$$ENDHEX$$ deve desmarcar a filial deste pedido, ou ent$$HEX1$$e300$$ENDHEX$$o, cancelar a pend$$HEX1$$ea00$$ENDHEX$$ncia do pedido acima citado."							
		End If
								
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_Mensagem, StopSign!)
	Case 100
		lvb_Existe = False
	Case -1
		messagebox('Alerta!',"Verificar Produtos j$$HEX1$$e100$$ENDHEX$$ Colocados!~r~n~r~nPressione OK para abrir tela com produtos j$$HEX1$$e100$$ENDHEX$$ colocados!",Exclamation!)
		
		//Exibe tela com produtos repetidos 
		str_ge415_produto_filial st
		
		st.cd_produto	= al_produto
		st.cd_filial		= al_filial
		
		OpenWithParm(w_ge415_visualiza_repetidos, st)
		//SqlCa.of_MsgdbError("Verifica$$HEX2$$e700e300$$ENDHEX$$o de Produtos j$$HEX1$$e100$$ENDHEX$$ Colocados")
End Choose

Return lvb_Existe
end function

public function boolean of_atualiza_produto_pedido (long al_filial, long al_pedido, long al_produto, long al_qt_nova, long al_qt_atual, boolean ab_grava_historico, long al_cd_motivo, long al_cd_motivo_atual, long al_qt_aprovada);String ls_Erro
String ls_Chave

String ls_Msg

Update pedido_empurrado_produto
	Set qt_empurrada 			= :al_Qt_Nova,
		 cd_motivo_empurrado 	= :al_cd_motivo,
		 qt_aprovada				= :al_qt_aprovada
Where cd_filial = :al_Filial
	And nr_pedido_empurrado 	= :al_Pedido
	And cd_produto 				= :al_Produto
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SqlErrText
	SqlCa.of_Rollback();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao atualizar a quantidade pedida do produto '" + String(al_Produto) + "' do pedido '" + String(al_Pedido) +  "' da filial '" + String(al_Filial) + "'. " + ls_Erro, StopSign!)
	Return False
End If

If ab_grava_historico Then
	ls_Chave = String(al_Filial) + "@#!" + String(al_Pedido) + "@#!" + String(al_Produto)
	
//	gf_Grava_Historico_Alteracao_Tabela('PEDIDO_EMPURRADO_PRODUTO', ls_Chave, 'QT_EMPURRADA', String(al_Qt_Atual), String(al_Qt_Nova), gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'A', Ref ls_Msg, True)
	gf_Grava_Historico_Alteracao_Tabela('PEDIDO_EMPURRADO_PRODUTO', ls_Chave, 'CD_MOTIVO_EMPURRADO', String(al_Cd_Motivo), String(al_Cd_Motivo_Atual), gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'A', Ref ls_Msg, True)
End If

Return True
end function

public function boolean of_inclui_produto_pedido (long al_filial, long al_pedido, long al_produto, long al_qt_nova, boolean ab_grava_historico, long al_cd_motivo, long al_qt_aprovada);String ls_Erro
String ls_Chave

String ls_Msg
String ls_Nulo


Insert Into pedido_empurrado_produto(cd_filial, nr_pedido_empurrado, cd_produto, qt_empurrada, qt_faturada, id_situacao, nr_matricula_inclusao, cd_motivo_empurrado, qt_aprovada )
		Values(:al_Filial, :al_Pedido, :al_Produto, : al_qt_nova, 0, 'C', :gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, :al_Cd_Motivo, :al_qt_aprovada )
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SqlErrText
	SqlCa.of_Rollback();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao incluir o produto '" + String(al_Produto) + "' no pedido '" +  String(al_Pedido) + "' da filial '" + String(al_Filial) + "'. " + ls_Erro, StopSign!)
	Return False
End If

//If ab_grava_historico Then
//	ls_Chave = String(al_Filial) + "@#!" + String(al_Pedido) + "@#!" + String(al_Produto)
//	SetNull(ls_Nulo)
//	
//	gf_Grava_Historico_Alteracao_Tabela('PEDIDO_EMPURRADO_PRODUTO', ls_Chave, 'QT_EMPURRADA', ls_Nulo, String(al_Qt_Nova), gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'I', Ref ls_Msg, True)
//End If
//
Return True
end function

on uo_pedido_empurrado.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_pedido_empurrado.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

