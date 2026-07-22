HA$PBExportHeader$w_ge252_altera_validade.srw
forward
global type w_ge252_altera_validade from dc_w_base
end type
type dw_2 from dc_uo_dw_base within w_ge252_altera_validade
end type
type dw_1 from dc_uo_dw_base within w_ge252_altera_validade
end type
type cb_2 from commandbutton within w_ge252_altera_validade
end type
type cb_1 from commandbutton within w_ge252_altera_validade
end type
type gb_1 from groupbox within w_ge252_altera_validade
end type
end forward

global type w_ge252_altera_validade from dc_w_base
integer width = 1856
integer height = 536
string title = "GE252 - Alterar Validade"
boolean controlmenu = false
boolean minbox = false
boolean resizable = false
windowtype windowtype = response!
dw_2 dw_2
dw_1 dw_1
cb_2 cb_2
cb_1 cb_1
gb_1 gb_1
end type
global w_ge252_altera_validade w_ge252_altera_validade

type variables
String 	is_Endereco,&
			is_Lote,&
			is_Agrupamento
			
Long 	il_Produto,&
		il_Agrupamento, &
		il_Qt_Caixa_Pad, &
		il_Sequencial,&
		il_Saldo_Endereco

DateTime idh_Validade
end variables

forward prototypes
public function boolean wf_qt_saldo_total (ref long al_qt_total_saldo)
public function boolean wf_atualiza_nf_compra (long al_produto, string as_lote, datetime adh_validade_atual, datetime adh_validade_nova)
end prototypes

public function boolean wf_qt_saldo_total (ref long al_qt_total_saldo);String ls_Erro

al_qt_total_saldo = 0

Select Coalesce(Sum(qt_saldo), 0)
	Into :al_qt_total_saldo
From wms_localizacao
Where cd_endereco 		= :is_Endereco
	and cd_produto			= :il_Produto
	and nr_lote				= :is_Lote
	and qt_caixa_padrao	= :il_Qt_Caixa_Pad
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SQLErrText
	SqlCa.of_RollBack()
	MessageBox("Erro", "Erro ao consultar a wms_localizacao: "+ ls_Erro)
	Return False
End If

Return True
end function

public function boolean wf_atualiza_nf_compra (long al_produto, string as_lote, datetime adh_validade_atual, datetime adh_validade_nova);String	ls_Erro

//UPDATE item_nf_compra_lote 
//	SET dh_validade = :adh_validade_nova
// WHERE cd_produto  = :al_produto
// 	AND nr_lote     = :as_lote
// USING SQLCA;
//
//If SQLCA.SQLCode < 0 then
//	ls_Erro = SQLCA.SQLErrText
//	SQLCA.of_RollBack ()
//	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao atualizar a validade nas NFs de compra: ' + ls_Erro, Exclamation!)
//	Return False
//End if

Return True
end function

on w_ge252_altera_validade.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.dw_1=create dw_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.gb_1
end on

on w_ge252_altera_validade.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.gb_1)
end on

event open;call super::open;Long		ll_Sequencial
String 	ls_Endereco_Parametro, ls_Chave

st_parametros_altera_validade lst_Parametro


lst_Parametro = Message.PowerObjectParm	

is_Agrupamento		= lst_Parametro.id_agrupamento 
is_Lote 				= lst_Parametro.nr_lote	
il_Produto			= lst_Parametro.cd_produto
idh_Validade		= lst_Parametro.dh_validade
il_Qt_Caixa_Pad	= 1	

If is_Agrupamento = "S" Then
	//Localiza o endere$$HEX1$$e700$$ENDHEX$$o do agrupamento
	select p.vl_parametro 
	  into :ls_Endereco_Parametro
	  from wms_parametro p 
	 where p.cd_parametro = 'CD_ENDERECO_SEGREGADO_AGRUPAMENTO_DEV'
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 100
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado o endere$$HEX1$$e700$$ENDHEX$$o de agrupamentos.")
			Return Close(This)
			
		Case -1
			SqlCa.of_MsgDbError("Erro ao localizar o valor do par$$HEX1$$e200$$ENDHEX$$metro CD_ENDERECO_SEGREGADO_AGRUPAMENTO_DEV.")
			Return Close(This)
	End Choose
	
	is_Endereco 	= ls_Endereco_Parametro
	il_Agrupamento	= lst_Parametro.nr_agrupamento
Else
	is_Endereco 		= lst_Parametro.cd_endereco
	il_Sequencial		= lst_Parametro.Nr_Sequencial
	il_Qt_Caixa_Pad	= lst_Parametro.Qt_Caixa_Padrao
End If

// Localiza Sequencia e Saldo 
Select nr_sequencial,  
		 qt_saldo
  Into :ll_Sequencial, 
  		 :il_Saldo_Endereco
  From wms_localizacao
 Where cd_endereco 		= :is_Endereco
	And cd_produto 		= :il_Produto
	And nr_lote 			= :is_Lote
	And qt_caixa_padrao 	= 1
	And dh_validade 		= :idh_Validade
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o",  "Sequencial n$$HEX1$$e300$$ENDHEX$$o localizado.~r~r"+&
										"Endere$$HEX1$$e700$$ENDHEX$$o: "+is_Endereco+"~r"+&
										"Produto: "+String(il_Produto)+"~r"+&
										"Lote: "+is_Lote+"~r"+&
										"Cx. Padrao: "+String(1)+"~r"+&
										"Validade: "+String(idh_Validade, "dd-mm-yyyy"))
										
		Return Close(This)											
		
	Case -1
		ls_Chave = "End:'" + is_Endereco + "' Produto: '" +  String(il_Produto) + "' Lote: '" + is_Lote + "' Validade: '" + String(idh_Validade, "dd/mm/yyyy") + "'" 		
		MessageBox("Erro", "Erro ao localizar o sequencial " + ls_Chave + " '" + SqlCa.SQLErrText + "'.", StopSign!)
		Return Close(This)
End Choose

if is_agrupamento = 'S' then
	il_Sequencial = ll_Sequencial
end if
	
lst_Parametro.qt_saldo_endereco 	= il_Saldo_Endereco

dw_1.Object.cd_produto[1] 	= il_Produto
dw_1.Object.de_produto[1] 	= lst_Parametro.de_produto
dw_1.Object.nr_lote[1] 		= is_Lote
end event

type dw_2 from dc_uo_dw_base within w_ge252_altera_validade
boolean visible = false
integer x = 192
integer y = 268
integer taborder = 30
string dataobject = "ds_ge252_localiza_prd_lotes_validade"
end type

type dw_1 from dc_uo_dw_base within w_ge252_altera_validade
integer x = 37
integer y = 36
integer width = 1769
integer height = 244
string dataobject = "dw_ge252_altera_validade"
end type

type cb_2 from commandbutton within w_ge252_altera_validade
integer x = 942
integer y = 316
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Confirmar"
end type

event clicked;Boolean	lb_Sucesso = False
DateTime ldh_Validade_Nova
Long ll_Qt_Saldo_Antes
Long ll_Qt_Saldo_Depois
Long ll_Seq_Update
Long ll_Linha
Long ll_Agrup
String ls_Erro
String ls_Retorno

dw_1.AcceptText()

ldh_Validade_Nova =  DateTime(String(dw_1.Object.dh_validade[1], "01/mm/20yy"))

If IsNull(ldh_Validade_Nova) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a Validade.", Information!)
	dw_1.Event ue_Pos(1, "dh_validade")
	Return 1
End If

If dw_2.Retrieve(il_Produto, idh_Validade, is_Lote) < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no retrieve da dw_2.", StopSign!)
	Return -1
End If

Try
	//Se houver mais de dois agrupamentos (agrupamento selecionado + outros agrupamentos com mesmo produto, lote e validade, abre a tela w_ge252_localiza_produto_validade
	If dw_2.RowCount() > 1 Then
		OpenWithParm(w_ge252_localiza_produto_validade, dw_2)
		
		ls_Retorno = Message.StringParm
		
		//Usu$$HEX1$$e100$$ENDHEX$$rio clicou no bot$$HEX1$$e300$$ENDHEX$$o cb_cancelar da tela w_ge252_localiza_produto_validade
		If ls_Retorno = "N" Then
			Return -1
		End If
	End If
	
	If is_Agrupamento = "S" Then
		
		For ll_Linha = 1 To dw_2.RowCount()
			
			//Atualiza os agrupamentos que tem o mesmo produto, lote e validade
			ll_Agrup = dw_2.Object.Nr_Agrupamento[ll_Linha]
		
			Update agrupamento_dev_compra_prd
			Set dh_validade = :ldh_Validade_Nova
			Where nr_agrupamento 	= :ll_Agrup
				and cd_produto 		= :il_Produto
				and nr_lote 				= :is_Lote
				and dh_validade 		= :idh_Validade
			Using SqlCA;
			
			If SqlCa.SqlCode = -1 Then
				ls_Erro = SqlCa.SQLErrText
				SqlCa.of_RollBack()
				MessageBox("Erro", "Erro ao atualizar a validade do agrupamento: "+ ls_Erro)		
				Return 1
			End If
		Next
	End If
	
	If Not wf_Qt_Saldo_Total(Ref ll_Qt_Saldo_Antes) Then Return -1
	
	/// Localiza o Sequencial do Outro Endereco/Lote/Produto
	Select nr_sequencial
		Into :ll_Seq_Update
	From wms_localizacao
	Where cd_endereco 		= :is_Endereco
		and cd_produto			= :il_Produto
		and nr_lote				= :is_Lote
		and nr_sequencial		<> :il_Sequencial
		and dh_validade		= :ldh_Validade_Nova
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			// Atualiza o Saldo :  Coloca todo o saldo em uma Linha unica: Produto/Endereco/Lote
			Update wms_localizacao
			Set qt_saldo = qt_saldo + :il_Saldo_Endereco
			Where cd_endereco 		= :is_Endereco
				and nr_sequencial		= :ll_Seq_Update
				and cd_produto			= :il_Produto
				and nr_lote				= :is_Lote
				and dh_validade		= :ldh_Validade_Nova
				and qt_caixa_padrao	= :il_Qt_Caixa_Pad
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				ls_Erro = SqlCa.SQLErrText
				SqlCa.of_RollBack()
				MessageBox("Erro", "Erro ao atualizar o saldo do endere$$HEX1$$e700$$ENDHEX$$o: "+ ls_Erro)		
				Return 1
			End If
			
			// Retorna Erro Caso N$$HEX1$$e300$$ENDHEX$$o tenha Atualzado
			If Sqlca.SQLNRows <> 1 Then
				SqlCa.of_RollBack()
				MessageBox("Erro", "ATUALIZA$$HEX2$$c700c300$$ENDHEX$$O de registro diferente do esperado. Mensagem 1")
				Return 1
			End If
			
			// Na wms_localizacao Precisamos eliminar o Registro. J$$HEX1$$e100$$ENDHEX$$ foi atualizado Anteriormente		
			Delete From wms_localizacao
			Where cd_endereco = :is_Endereco
				And nr_sequencial = :il_Sequencial
				And cd_produto = :il_Produto
				And nr_lote = :is_Lote
				And dh_validade = :idh_Validade
				and qt_caixa_padrao	= :il_Qt_Caixa_Pad
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				ls_Erro = SqlCa.SQLErrText
				SqlCa.of_RollBack()
				MessageBox("Erro", "Erro ao excluir o registro da wms_localizacao: "+ ls_Erro)		
				Return 1
			End If
			
			// Retorna Erro Caso N$$HEX1$$e300$$ENDHEX$$o tenha Atualzado
			If Sqlca.SQLNRows <> 1 Then
				SqlCa.of_RollBack()
				MessageBox("Erro", "EXCLUS$$HEX1$$c300$$ENDHEX$$O de registro diferente do esperado.")
				Return 1
			End If
			
			// Localiza o Saldo para Comparar
			If Not wf_Qt_Saldo_Total(Ref ll_Qt_Saldo_Depois) Then Return -1
	
			// Valida$$HEX2$$e700e300$$ENDHEX$$o: N$$HEX1$$e300$$ENDHEX$$o pode ser diferente
			If ll_Qt_Saldo_Antes <> ll_Qt_Saldo_Depois Then
				SqlCa.of_Rollback();
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Saldo anterior [" +  String(ll_Qt_Saldo_Antes) + "] $$HEX1$$e900$$ENDHEX$$ diferente do saldo atual [" + String(ll_Qt_Saldo_Depois) + "]")
				Return -1
			End If
			
		Case 100
			
			Update wms_localizacao
			Set dh_validade = :ldh_Validade_Nova
			Where cd_endereco 	= :is_Endereco
				 and nr_sequencial  =: il_Sequencial
				and cd_produto		= :il_Produto
				and nr_lote			= :is_Lote
				and dh_validade	= :idh_Validade
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				ls_Erro = SqlCa.SQLErrText
				SqlCa.of_RollBack()
				MessageBox("Erro", "Erro ao atualizar a validade do endere$$HEX1$$e700$$ENDHEX$$o: "+ ls_Erro)		
				Return 1
			End If
			
			// Retorna Erro Caso N$$HEX1$$e300$$ENDHEX$$o tenha Atualzado
			If Sqlca.SQLNRows <> 1 Then
				SqlCa.of_RollBack()
				MessageBox("Erro", "ATUALIZA$$HEX2$$c700c300$$ENDHEX$$O de registro diferente do esperado. Mensagem 2")
				Return 1
			End If
			
		Case -1 		
			ls_Erro = SqlCa.SQLErrText
			SqlCa.of_RollBack()
			MessageBox("Erro", "Erro ao consultar a wms_localizacao com sequencial diferente do que est$$HEX1$$e100$$ENDHEX$$ sendo alterado: "+ ls_Erro)		
			Return 1
			
	End Choose
	
	//Retirado devido $$HEX1$$e000$$ENDHEX$$ demora excessiva, causando travamento para outros usu$$HEX1$$e100$$ENDHEX$$rios
//	If not wf_atualiza_nf_compra (il_Produto, is_Lote, idh_Validade, ldh_Validade_Nova) then
//		Return 1
//	End if
	
	lb_Sucesso = True
	
Finally
	
	If lb_Sucesso then
		SqlCa.of_Commit()
	End if
	
End try

CloseWithReturn(Parent, "S")
end event

type cb_1 from commandbutton within w_ge252_altera_validade
integer x = 1477
integer y = 316
integer width = 338
integer height = 112
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Sair"
end type

event clicked;CloseWithReturn(Parent, "N")
end event

type gb_1 from groupbox within w_ge252_altera_validade
integer x = 23
integer width = 1801
integer height = 296
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
end type

