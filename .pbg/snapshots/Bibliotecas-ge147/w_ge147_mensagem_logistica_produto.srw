HA$PBExportHeader$w_ge147_mensagem_logistica_produto.srw
forward
global type w_ge147_mensagem_logistica_produto from dc_w_base
end type
type cb_4 from commandbutton within w_ge147_mensagem_logistica_produto
end type
type cb_3 from commandbutton within w_ge147_mensagem_logistica_produto
end type
type cb_2 from commandbutton within w_ge147_mensagem_logistica_produto
end type
type cb_1 from commandbutton within w_ge147_mensagem_logistica_produto
end type
type dw_2 from datawindow within w_ge147_mensagem_logistica_produto
end type
type dw_1 from dc_uo_dw_base within w_ge147_mensagem_logistica_produto
end type
type gb_1 from groupbox within w_ge147_mensagem_logistica_produto
end type
end forward

global type w_ge147_mensagem_logistica_produto from dc_w_base
integer width = 1879
integer height = 1068
string title = "GE147 - Mensagem Log$$HEX1$$ed00$$ENDHEX$$stica Produto"
boolean minbox = false
boolean resizable = false
windowtype windowtype = response!
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_2 dw_2
dw_1 dw_1
gb_1 gb_1
end type
global w_ge147_mensagem_logistica_produto w_ge147_mensagem_logistica_produto

type variables
Boolean ib_Almoxarifado = False

Long	il_Pedido, &
		il_Produto, &
		il_Qt_Pedida, &
		il_Mensagem, &
		il_Sequencial, &
		il_Filial
		
String	is_Produto, &
		is_Matricula

uo_filial						io_Filial				//GE009
uo_ge149_comprador 	io_Comprador
uo_centro_custo			io_Centro_Custo	//GE024
end variables

forward prototypes
public subroutine wf_controla_campos (long al_tipo_mensagem)
public function boolean wf_nivel_alcada ()
public subroutine wf_retira_mensagem ()
public function boolean wf_verifica_mensagem_cadastrada (integer pi_mensagem, ref string ps_msg_erro)
public function boolean wf_verifica_produto_almoxarifado ()
public function boolean wf_grava_mensagem (long pl_mensagem, long pl_filial_envio, string ps_matricula_avisar, long pl_centro_custo, long pl_qtde_devolver, datetime pdh_limite_validade, ref string ps_msg_erro)
public function boolean wf_prepara_gravacao_mensagem (long pl_mensagem, long pl_filial_envio, string ps_matricula_avisar, long pl_centro_custo, long pl_qtde_devolver, datetime pdh_limite_validade)
public function boolean wf_verifica_nf_compra_pendente_produto (long al_produto, long al_pedido)
end prototypes

public subroutine wf_controla_campos (long al_tipo_mensagem);// 1 -> NAO CONFIRMADO COM O PEDIDO
// 2 -> ACEITE COM VALIDADE CURTA
// 3 -> AVISAR QUANDO CHEGAR
// 4 -> FATURAR PARA A FILIAL

dw_1.Object.nm_fantasia_t.Visible 							= False
dw_1.Object.nm_fantasia.Visible 								= False
dw_1.Object.cd_filial_envio.Visible								= False
dw_1.Object.nm_usuario_avisar_t.Visible 					= False
dw_1.Object.nm_usuario_avisar.Visible 						= False
dw_1.Object.nr_matricula_avisar.Visible 					= False
dw_1.Object.de_centro_custo_t.Visible 						= False
dw_1.Object.de_centro_custo.Visible 							= False
dw_1.Object.cd_centro_custo.Visible							= False
dw_1.Object.dh_limite_validade_t.Visible					= False
dw_1.Object.dh_limite_validade.Visible						= False
dw_1.Object.qt_devolver_t.Visible 							= False
dw_1.Object.qt_devolver.Visible 								= False
dw_1.Object.qt_devolver_t.Text								= "Qtde. Devolver:"

Choose Case al_Tipo_Mensagem
	Case 1
		dw_1.Object.nm_usuario_avisar_t.Visible 			= True
		dw_1.Object.nm_usuario_avisar.Visible 				= True
		dw_1.Object.nr_matricula_avisar.Visible 			= True
		dw_1.Object.qt_devolver_t.Visible 					= True
		dw_1.Object.qt_devolver.Visible 						= True
		
		dw_1.Object.nm_usuario_avisar_t.y 					= 244
		dw_1.Object.nm_usuario_avisar.y 					= 244
		dw_1.Object.nr_matricula_avisar.y 					= 244
		dw_1.Object.qt_devolver_t.y 							= 324
		dw_1.Object.qt_devolver.y 								= 324
		
	Case 2
		dw_1.Object.dh_limite_validade_t.Visible 			= True
		dw_1.Object.dh_limite_validade.Visible 				= True	
		
		dw_1.Object.dh_limite_validade_t.y					= 244
		dw_1.Object.dh_limite_validade.y						= 244	
		
	Case 3
		dw_1.Object.nm_usuario_avisar_t.Visible 			= True
		dw_1.Object.nm_usuario_avisar.Visible 				= True
		dw_1.Object.nr_matricula_avisar.Visible 			= True
		dw_1.Object.nm_fantasia_t.Visible 					= True
		dw_1.Object.nm_fantasia.Visible 						= True
		dw_1.Object.cd_filial_envio.Visible						= True		
		
		dw_1.Object.nm_usuario_avisar_t.y 					= 324
		dw_1.Object.nm_usuario_avisar.y 					= 324
		dw_1.Object.nr_matricula_avisar.y 					= 324
		dw_1.Object.nm_fantasia_t.y 							= 244
		dw_1.Object.nm_fantasia.y 								= 244
		dw_1.Object.cd_filial_envio.y							= 244
		
	Case 4
		dw_1.Object.nm_fantasia_t.Visible 					= True
		dw_1.Object.nm_fantasia.Visible 						= True
		dw_1.Object.cd_filial_envio.Visible						= True
		dw_1.Object.qt_devolver_t.Visible 					= True
		dw_1.Object.qt_devolver.Visible 						= True		
		
		dw_1.Object.nm_fantasia_t.y 							= 244
		dw_1.Object.nm_fantasia.y 								= 244
		dw_1.Object.cd_filial_envio.y							= 244
		dw_1.Object.qt_devolver_t.Text						= "Quantidade:"
		
		If ib_Almoxarifado Then
			dw_1.Object.de_centro_custo_t.Visible 			= True
			dw_1.Object.de_centro_custo.Visible 				= True
			dw_1.Object.cd_centro_custo.Visible				= True
			
			dw_1.Object.de_centro_custo_t.y 					= 324
			dw_1.Object.de_centro_custo.y 					= 324
			dw_1.Object.cd_centro_custo.y						= 324
			
			dw_1.Object.qt_devolver_t.y 						= 404
			dw_1.Object.qt_devolver.y 							= 404
		Else			
			dw_1.Object.qt_devolver_t.y 						= 324
			dw_1.Object.qt_devolver.y 							= 324
		End If
		
End Choose
end subroutine

public function boolean wf_nivel_alcada ();String ls_Achou

Select nr_matricula
Into :ls_Achou
From nivel_liberacao_pedido_usuario
Where nr_nivel >= 2
	and nr_matricula =:is_Matricula
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Return True
	Case 100
		Return False
	Case -1 
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do nivel de libera$$HEX2$$e700e300$$ENDHEX$$o do pedido.")
		Return False
End Choose

end function

public subroutine wf_retira_mensagem ();DataWindowChild lvdwc

Integer	li_Find

If dw_1.GetChild("cd_mensagem", lvdwc) = 1 Then
	li_Find = lvdwc.Find("cd_mensagem = 1", 1, lvdwc.RowCount())
	
	lvdwc.DeleteRow(li_Find)
	
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild do andar.")
End If
end subroutine

public function boolean wf_verifica_mensagem_cadastrada (integer pi_mensagem, ref string ps_msg_erro);Long ll_Mensagem_Existe

String ls_ValorPara

dw_1.AcceptText()

//Se houve altera$$HEX2$$e700e300$$ENDHEX$$o no c$$HEX1$$f300$$ENDHEX$$digo da mensagem ou se for uma inclus$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ feita a valida$$HEX2$$e700e300$$ENDHEX$$o abaixo para saber se a mensagem a ser salva j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ cadastrada

If gf_Houve_Alteracao_Dw(dw_1, 'CD_MENSAGEM', 1, Ref ls_ValorPara) Or il_Mensagem = 0 Then
	Select top 1 cd_mensagem
		Into :ll_Mensagem_Existe
	From pedido_central_prd_msg_logist
	Where nr_pedido		= :il_Pedido
		 And cd_produto		= :il_Produto
		 And cd_mensagem	= :pi_Mensagem
	Using SqlCa;
			
	Choose Case SqlCa.SqlCode
		Case 0
			If ll_Mensagem_Existe = pi_Mensagem Then
				If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Mensagem '" + String(pi_Mensagem) + "' j$$HEX1$$e100$$ENDHEX$$ cadastrada para o pedido '" + String(il_Pedido) + "' produto '" + String(il_Produto) + "'." + &
												"Deseja continuar?", Question!, YesNo!, 2) = 2 Then
					ps_Msg_Erro = ""
					Return False
				End If
			End If
		
		Case 100
			Return True
			
		Case -1	
			ps_msg_erro = "Erro ao localizar e mensagem. " + SqlCa.SqlErrText
			Return False
	End Choose
End If
	
Return True
end function

public function boolean wf_verifica_produto_almoxarifado ();Long ll_Achou

Select Count(*)
	Into: ll_Achou
From produto_geral
Where cd_produto = :il_Produto
	And Substring(cd_subcategoria, 1, 1) = '5'
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na consulta do produto almoxarifado. Fun$$HEX2$$e700e300$$ENDHEX$$o wf_verifica_produto_almoxarifado." + SqlCa.SqlErrText, StopSign!)
	Return False
End If

If ll_Achou > 0 Then
	ib_Almoxarifado = True
End If

Return True
end function

public function boolean wf_grava_mensagem (long pl_mensagem, long pl_filial_envio, string ps_matricula_avisar, long pl_centro_custo, long pl_qtde_devolver, datetime pdh_limite_validade, ref string ps_msg_erro);Long ll_Prox_Seq

String ls_Mensagem

If il_Mensagem = 0 Then
	
	If Not gf_ge147_Prox_Seq_Msg_Logistica_Prd(il_Pedido, True, Ref ll_Prox_Seq, Ref ls_Mensagem) Then Return False
	
	Insert Into pedido_central_prd_msg_logist(
		nr_pedido,
		cd_produto,
		cd_mensagem,
		cd_filial_envio,
		nr_matricula_avisar,
		qt_devolver,
		dh_inclusao,
		nr_matricula_inclusao,
		dh_alteracao,
		nr_matricula_alteracao,
		dh_exclusao,
		nr_matricula_exclusao,
		cd_centro_custo,
		dh_limite_validade,
		nr_sequencial)
	Values(	
		:il_Pedido,
		:il_Produto,
		:pl_Mensagem,
		:pl_Filial_Envio,
		:ps_Matricula_Avisar,
		:pl_Qtde_Devolver,
		GetDate(),
		:is_Matricula,
		null,
		null,
		null,
		null,
		:pl_Centro_Custo,
		:pdh_Limite_Validade,
		:ll_Prox_Seq)
	Using SqlCa;
			
	If SqlCa.SqlCode = -1 Then
		ps_msg_erro = "Erro ao salvar a mensagem: " + SqlCa.SqlErrText
		Return False
	End If
End If
	
If il_Mensagem > 0 Then
	
	Update pedido_central_prd_msg_logist
	Set 	cd_mensagem					= :pl_Mensagem,
			cd_filial_envio					= :pl_Filial_Envio,
			nr_matricula_avisar			= :ps_Matricula_Avisar,
			qt_devolver						= :pl_Qtde_Devolver,
			dh_alteracao					= Getdate(),
			nr_matricula_alteracao		= :is_Matricula,
			dh_exclusao						= null,
			nr_matricula_exclusao		= null,
			cd_centro_custo				= :pl_Centro_Custo,
			dh_limite_validade				= :pdh_Limite_Validade
	Where nr_pedido 			= :il_Pedido
		And cd_produto 		= :il_Produto
		And cd_mensagem	= :il_Mensagem
		And nr_sequencial		= :il_Sequencial
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		ps_msg_erro = "Erro ao atualizar a mensagem: " + SqlCa.SqlErrText
		Return False
	End If	
End If

If pdh_Limite_Validade < gf_Getserverdate() Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de validade informada $$HEX1$$e900$$ENDHEX$$ menor que a data atual.~rInforme outra data.", Exclamation!)
	ps_msg_erro = "Erro ao atualizar a mensagem: " + SqlCa.SqlErrText
	Return False
End If

Return True
end function

public function boolean wf_prepara_gravacao_mensagem (long pl_mensagem, long pl_filial_envio, string ps_matricula_avisar, long pl_centro_custo, long pl_qtde_devolver, datetime pdh_limite_validade);Boolean lb_Sucesso = False

Long ll_Produto
Long ll_Linha
Long ll_Linhas
Long ll_Achou
Long ll_Find

String ls_Msg_Todos_Prod
String ls_Erro

dw_1.AcceptText()

Try

	If il_Mensagem = 0 Then	
		ls_Msg_Todos_Prod = dw_1.Object.Id_Todos_Produtos[1]
		
		If ls_Msg_Todos_Prod = 'N' Then
			
			If Not wf_Verifica_Mensagem_Cadastrada(pl_Mensagem, Ref ls_Erro) Then
				Return False
			End If
			
			If Not wf_Grava_Mensagem(pl_Mensagem, pl_Filial_Envio, ps_Matricula_Avisar, pl_Centro_Custo, pl_Qtde_Devolver, pdh_Limite_Validade, Ref ls_Erro) Then
				Return False
			End If
			
			lb_Sucesso = True
		End If
		
		If ls_Msg_Todos_Prod = 'S' Then
			
			dc_uo_ds_base lds_1
			lds_1 = Create dc_uo_ds_base
			
			If Not lds_1.of_ChangeDataObject("ds_ge147_lista_produto_pedido") Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar o data store 'ds_ge147_lista_produto_pedido'.")
				Return False
			End If
			
			ll_Linhas = lds_1.Retrieve(il_Pedido)
			
			If ll_Linhas > 0 Then
				For ll_Linha = 1 To ll_Linhas
					ll_Produto = lds_1.Object.Cd_Produto[ll_Linha]
					
					//Importacao via excel(csv)
					If dw_2.rowcount( ) > 0 and pl_Mensagem  = 2 Then
						ll_Find = dw_2.find("produto = '"+String(ll_Produto)+"'",1,dw_2.rowcount( ))
						If  ll_Find <= 0 Then
							ls_Erro = "Produto '"+String(ll_Produto)+"' n$$HEX1$$e300$$ENDHEX$$o localizado no arquivo."
							Return False							
						Else							
							If (Not IsDate(dw_2.getitemstring(ll_Find,"validade"))) And (Not IsDate("01/"+dw_2.getitemstring(ll_Find,"validade"))) Then
								ls_Erro = "Produto '"+String(ll_Produto)+"' com data de validade inv$$HEX1$$e100$$ENDHEX$$lida ou n$$HEX1$$e300$$ENDHEX$$o informada no arquivo."
								Return False
							End if
							pdh_Limite_Validade = DateTime("01/"+dw_2.getitemstring(ll_Find,"validade"))
							
						End If
					End If
					
					il_Produto = ll_Produto
					
					Select top 1 cd_mensagem
					Into :ll_Achou
					From pedido_central_prd_msg_logist
					Where nr_pedido			= :il_Pedido
						 And cd_produto		= :il_Produto
						 And cd_mensagem	= :pl_Mensagem
					 Using SqlCa;
					 
					 Choose Case SqlCa.SqlCode
						Case 0
							//
						Case 100
							If Not wf_Grava_Mensagem(pl_Mensagem, pl_Filial_Envio, ps_Matricula_Avisar, pl_Centro_Custo, pl_Qtde_Devolver, pdh_Limite_Validade, Ref ls_Erro) Then
								Return False
							End If
							
						Case -1
							ls_Erro = "Erro ao localizar a mensagem do produto '" + String(ll_Produto) + "'." + Sqlca.SqlErrText
							Return False
					 End Choose	
					 
					 If ll_Linha = ll_Linhas Then
					 	lb_Sucesso = True
					End If
				Next
			End If
		End If
	End If
		
	If il_Mensagem > 0 Then
		If Not wf_Verifica_Mensagem_Cadastrada(pl_Mensagem, Ref ls_Erro) Then
			Return False
		End If
		
		If Not wf_Grava_Mensagem(pl_Mensagem, pl_Filial_Envio, ps_Matricula_Avisar, pl_Centro_Custo, pl_Qtde_Devolver, pdh_Limite_Validade, Ref ls_Erro) Then
			Return False
		End If
		
		lb_Sucesso = True
	End If
	
Finally
	
	If lb_Sucesso Then
		SqlCa.of_Commit();
	Else
		SqlCa.of_RollBack();
			
		If ls_Erro <> "" Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Erro, StopSign!)
		End If
				
	End If
	
	If IsValid(lds_1) Then Destroy(lds_1)
End Try

Return True
end function

public function boolean wf_verifica_nf_compra_pendente_produto (long al_produto, long al_pedido);Long ll_Achou

select count(*)
Into :ll_Achou
from(
    Select n.cd_filial
    From nf_compra_pendente as n
    	Inner Join nf_compra_pendente_produto as p
    		On p.cd_filial = n.cd_filial
    		And p.cd_fornecedor = n.cd_fornecedor
    		And p.nr_nf = n.nr_nf
    		And p.de_especie = n.de_especie
    		And p.de_serie = n.de_serie
    Where n.cd_filial = 534
    	And p.cd_produto = :al_Produto
    	And n.nr_pedido = :al_Pedido
    
    union
    
    Select n.cd_filial
    From nf_compra as n
    	Inner Join item_nf_compra as p
    		On p.cd_filial = n.cd_filial
    		And p.cd_fornecedor = n.cd_fornecedor
    		And p.nr_nf = n.nr_nf
    		And p.de_especie = n.de_especie
    		And p.de_serie = n.de_serie
    Where n.cd_filial = 534
    	And p.cd_produto = :al_Produto
    	And n.nr_pedido_central = :al_Pedido
) as tudo	
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError('Erro ao localizar a nf_compra_pendente_produto. Fun$$HEX2$$e700e300$$ENDHEX$$o wf_verifica_nf_compra_pendente_produto')
	Return False
End If

If ll_Achou > 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O XML da nota fiscal eletr$$HEX1$$f400$$ENDHEX$$nica deste pedido com este produto j$$HEX1$$e100$$ENDHEX$$ foi importado, portanto n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel gravar uma mensagem.", Exclamation!)
	Return False
Else
	Return True
End If
end function

on w_ge147_mensagem_logistica_produto.create
int iCurrent
call super::create
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_2=create dw_2
this.dw_1=create dw_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_4
this.Control[iCurrent+2]=this.cb_3
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.dw_2
this.Control[iCurrent+6]=this.dw_1
this.Control[iCurrent+7]=this.gb_1
end on

on w_ge147_mensagem_logistica_produto.destroy
call super::destroy
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event open;call super::open;//String ls_Parametro
//
//ls_Parametro = Message.StringParm
//		
//il_Pedido			= Long(Mid(ls_Parametro, 1, 10))
//il_Produto		= Long(Mid(ls_Parametro, 11, 10))
//il_Qt_Pedida		= Long(Mid(ls_Parametro, 21, 10))
//is_Matricula		= Mid(ls_Parametro, 31, 10)
//il_Mensagem	= Long(Mid(ls_Parametro, 41, 2))
//is_Produto		= Mid(ls_Parametro, 43, 4)
//il_Sequencial	= Long(MidA(ls_Parametro, 47))

st_parametros_msg_logistica_prd str

str = Message.PowerObjectParm

il_Pedido 		= str.Nr_Pedido
il_Produto 		= str.Cd_Produto
il_Qt_Pedida 	= str.Qt_Pedida
is_Matricula 	= str.Nr_Matricula
il_Mensagem 	= str.Cd_Mensagem
is_Produto 		= str.De_Produto
il_Sequencial	= str.Nr_Sequencial
il_Filial			= str.Cd_Filial

If Not wf_Verifica_Produto_Almoxarifado() Then Return

io_Filial				= Create uo_filial
io_Comprador		= Create uo_ge149_comprador
io_Centro_Custo	= Create uo_centro_custo
end event

event ue_postopen;call super::ue_postopen;Long ll_Qtd_Msg

//INCLUS$$HEX1$$c300$$ENDHEX$$O DE MENSAGEM
If il_Mensagem = 0 Then
	
	dw_1.Event ue_AddRow()
	
	dw_1.Object.nr_pedido	[1]	= il_Pedido
	dw_1.Object.cd_produto	[1]	= il_Produto
	dw_1.Object.de_produto	[1]	= is_Produto
	
	dw_1.Object.Id_Todos_Produtos.Visible = True
	dw_1.Object.Id_Todos_Produtos[1] = 'N'
	
	Cb_3.Visible = False
	Cb_4.Visible = False
	
	// Se n$$HEX1$$e300$$ENDHEX$$o tiver al$$HEX1$$e700$$ENDHEX$$ada para alterar retira o  "1 - NAO CONFORMIDADE COM O PEDIDO"
//	If Not wf_Nivel_Alcada() Then
//		wf_Retira_Mensagem()
//	End If
	
ElseIf il_Mensagem > 0 Then
	//ALTERA$$HEX2$$c700c300$$ENDHEX$$O/EXCLUS$$HEX1$$c300$$ENDHEX$$O MENSAGEM
	
	If Not IsNull(il_Filial) And il_Filial > 0 Then
		dw_1.of_AppendWhere("a.cd_filial_envio = " + String(il_Filial))
	End If

	dw_1.Retrieve(il_Pedido, il_Produto, il_Mensagem)
	
//	If il_Mensagem = 1 Then// NAO CONFORMIDADE COM O PEDIDO
////		If Not wf_Nivel_Alcada() Then
////			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Voc$$HEX1$$ea00$$ENDHEX$$ n$$HEX1$$e300$$ENDHEX$$o esta autorizado a fazer altera$$HEX2$$e700e300$$ENDHEX$$o na mensagem desse produto.~r~r" +&
////											"N$$HEX1$$ed00$$ENDHEX$$veis liberados: Gerente, Superintendente ou Diretoria.", Exclamation!)
////			Close(This)
////			Return
////		End If
//	Else
//		// Se n$$HEX1$$e300$$ENDHEX$$o tiver al$$HEX1$$e700$$ENDHEX$$ada para alterar retira o  "1 - NAO CONFORMIDADE COM O PEDIDO"
//		If Not wf_Nivel_Alcada() Then
//			wf_Retira_Mensagem()
//		End If
//	End If
	
	wf_Controla_Campos(il_Mensagem)
End If
end event

event close;call super::close;Destroy(io_Filial)
Destroy(io_Comprador)
Destroy(io_Centro_Custo)
end event

type cb_4 from commandbutton within w_ge147_mensagem_logistica_produto
boolean visible = false
integer x = 347
integer y = 868
integer width = 480
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Importar Excel"
end type

event clicked;String ls_FileName="", ls_FullFileName=""
Integer li_Ret
String ls_msg
Long ll_For, ll_Linhas, ll_Produto, ll_Find
uo_ge147_csv_import luo_ge147_csv_import
dc_uo_ds_base lds_produtos_pedido

lds_produtos_pedido = Create dc_uo_ds_base

dw_2.reset()
dw_2.visible = False

ls_msg = "Importa$$HEX2$$e700e300$$ENDHEX$$o de arquivo *.csv contendo o codigo do produto e a data de validade.~r~n"+&
			"O arquivo n$$HEX1$$e300$$ENDHEX$$o deve conter cabe$$HEX1$$e700$$ENDHEX$$alhos, e os campos devem ser seprados por (,) ou (;).~r~n~r~n"+&
			"Cada linha do arquivo deve ser composta conforme exemplos abaixo.~r~n"+&
			"Exemplo 1: 739197,11/2021~r~n"+&
			"Exemplo 2: 739197,01/11/2021~r~n"+&
			'Exemplo 3: "739197";"11/2021"~r~n'+&
			'Exemplo 4: "739197";"01/11/2021"'

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o",ls_Msg)

If GetFileOpenName ("Open", ls_FullFileName, ls_FileName, &
   "csv", "Excel (Separado por (;) ou Virgula),*.csv", &
   "C:\") < 1 Then 
	Destroy lds_produtos_pedido
	Return
End if

li_Ret = luo_ge147_csv_import.of_importfile( ls_FullFileName, dw_2)

If li_Ret > 0 and dw_2.rowcount() > 0 Then
	
	If Not lds_produtos_pedido.of_ChangeDataObject("ds_ge147_lista_produto_pedido") Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar o data store 'ds_ge147_lista_produto_pedido'.")
		Destroy lds_produtos_pedido
		Return
	End If
	
	ll_Linhas = lds_produtos_pedido.Retrieve(il_Pedido)
	
	//Procura criticas
	If dw_2.rowcount( ) <> ll_Linhas Then
		ls_Msg = "Total de linhas do arquivo $$HEX1$$e900$$ENDHEX$$ diferente do total de itens do pedido. Total de linhas no arquivo: "+String(dw_2.rowcount( ))+". Total de itens no pedido: "+String(ll_Linhas)
		dw_2.setitem(1,"critica",ls_Msg)
	Else
		For ll_For = 1 to dw_2.rowcount( )
			ll_Produto = Long(dw_2.getitemString(ll_For,"produto"))
			ll_Find = lds_produtos_pedido.find("Cd_Produto = "+String(ll_Produto),1,lds_produtos_pedido.rowcount( ))
			If  ll_Find <= 0 Then
				ls_Msg = "Produto n$$HEX1$$e300$$ENDHEX$$o localizado no pedido."
				dw_2.setitem(ll_For,"critica",ls_Msg)
				Continue
				
			Else							
				If (Not IsDate(dw_2.getitemstring(ll_Find,"validade"))) And (Not IsDate("01/"+dw_2.getitemstring(ll_Find,"validade"))) Then
					ls_Msg = "Produto com data de validade inv$$HEX1$$e100$$ENDHEX$$lida ou n$$HEX1$$e300$$ENDHEX$$o informada."
					dw_2.setitem(ll_For,"critica",ls_Msg)
					Continue
				End if				
			End If
		Next
		
	End If
				
	Destroy lds_produtos_pedido
	
	If dw_2.find("critica <>''",1,dw_2.rowcount()) > 0 Then
		//Com criticas
		dw_2.visible = True
		ls_Msg = "Importa$$HEX2$$e700e300$$ENDHEX$$o cont$$HEX1$$e900$$ENDHEX$$m cr$$HEX1$$ed00$$ENDHEX$$tica(s).~r~nCorrija o arquivo (.csv) e importe novamente."
		messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o",ls_Msg,exclamation!)
	Else
		//Sem criticas
		cb_2.triggerevent("clicked")
	End if
Else
	ls_Msg = "Arquivo fora do padr$$HEX1$$e300$$ENDHEX$$o esperado.~r~nCorrija o arquivo (.csv) e importe novamente."
	messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o",ls_Msg,stopsign!)
	Return
End If

end event

type cb_3 from commandbutton within w_ge147_mensagem_logistica_produto
integer x = 37
integer y = 868
integer width = 293
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Excluir"
end type

event clicked;Long ll_Matricula
Long ll_Mensagem
Long ll_Achou

String ls_Erro

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja realmente excluir a mensagem?", Question!, YesNo!, 2) = 2 Then
	Return 1
End If

dw_1.AcceptText()

ll_Mensagem	= dw_1.Object.Cd_Mensagem[1]
ll_Matricula		= Long(is_Matricula)
is_Matricula		= String(ll_Matricula)

Select cd_mensagem
Into :ll_Achou
From pedido_central_prd_msg_logist
Where nr_pedido		= :il_Pedido
    And cd_produto		= :il_Produto
    And cd_mensagem	= :ll_Mensagem
    And nr_sequencial	= :il_Sequencial
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		//
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "C$$HEX1$$f300$$ENDHEX$$digo '" + String(ll_Mensagem) + "' de mensagem n$$HEX1$$e300$$ENDHEX$$o cadastrado" + &
					" ~rpara o produto '" + String(il_Produto) + "' pedido '" + String(il_Pedido) + "'.")
		Return 1
		
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar a mensagem: " + SqlCa.SqlErrText, StopSign!)
		Return 1
		
End Choose

Update pedido_central_prd_msg_logist
Set 	dh_exclusao = Getdate(),
		nr_matricula_exclusao = :is_Matricula
Where nr_pedido 			= :il_Pedido
	and cd_produto 		= :il_Produto
	and cd_mensagem	= :ll_Mensagem
	and nr_sequencial		= :il_Sequencial
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SqlErrText
	SqlCa.of_Rollback()
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao excluir a mensagem: " + ls_Erro, StopSign!)
	Return 1
End If

SqlCa.of_Commit()

Close(Parent)
end event

type cb_2 from commandbutton within w_ge147_mensagem_logistica_produto
integer x = 1184
integer y = 868
integer width = 320
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Salvar"
end type

event clicked;String 	ls_Erro,&
			ls_Matricula_Avisar
			
Long	ll_Filial_Envio,&
		ll_Qtde_Devolver,&
		ll_Mensagem,&
		ll_Pedido_Select,&
		ll_Qtde, &
		ll_Matricula, &
		ll_Centro_Custo
		
DateTime	ldh_Limite_Validade

dw_1.AcceptText()

dw_2.visible = False

If Not wf_verifica_nf_compra_pendente_produto (il_Produto, il_Pedido) Then
	Return 1
End If

ll_Mensagem				= dw_1.object.cd_mensagem			[1]
ll_Filial_Envio				= dw_1.object.cd_filial_envio			[1]
ls_Matricula_Avisar		= dw_1.object.nr_matricula_avisar	[1]
ll_Qtde_Devolver			= dw_1.object.qt_devolver				[1]
ll_Centro_Custo			= dw_1.Object.Cd_Centro_Custo		[1]
ldh_Limite_Validade		= dw_1.Object.dh_limite_validade		[1]

ll_Matricula	= Long(is_Matricula)
is_Matricula	= String(ll_Matricula)

If IsNull(ll_Mensagem) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a mensagem.")
	dw_1.SetFocus()
	Return 1
End If

// 1 -> NAO CONFIRMADO COM O PEDIDO
// 2 -> ACEITE COM VALIDADE CURTA
// 3 -> AVISAR QUANDO CHEGAR
// 4 -> FATURAR PARA A FILIAL

Choose Case ll_Mensagem
	Case 1
		If IsNull(ls_Matricula_Avisar) or (ls_Matricula_Avisar = "") Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o campo Comprador.")
			dw_1.Event ue_Pos(1, "nr_matricula_avisar")		
			Return 1	
		End If
		
		If IsNull(ll_Qtde_Devolver) or (ll_Qtde_Devolver < 1) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o campo Qtde. Devolver.")
			dw_1.Event ue_Pos(1, "qt_devolver")		
			Return 1	
		End If
		
		If ll_Qtde_Devolver > il_Qt_Pedida Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A quantidade m$$HEX1$$e100$$ENDHEX$$xima $$HEX1$$e900$$ENDHEX$$ "+String(il_Qt_Pedida)+".")
			dw_1.Event ue_Pos(1, "qt_devolver")		
			Return 1	
		End If
		
	Case 2
		//ver importacao via excel
		If IsNull(ldh_Limite_Validade)  and dw_2.rowcount( ) = 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o campo Limite Validade")
			dw_1.Event ue_Pos(1, "dh_limite_validade")		
			Return 1	
		End If
		
	Case 3
		If (IsNull(ls_Matricula_Avisar) or Trim(ls_Matricula_Avisar) = "") And (IsNull(ll_Filial_Envio) or (ll_Filial_Envio = 0)) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o campo Comprador ou Filial.")
			dw_1.Event ue_Pos(1, "nm_usuario_avisar")		
			Return 1	
		End If
		
	Case 4
		If (IsNull(ll_Filial_Envio) or (ll_Filial_Envio = 0)) And (IsNull(ll_Centro_Custo) or (ll_Centro_Custo = 0)) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o campo Filial ou Departamento.")
			dw_1.Event ue_Pos(1, "nm_fantasia")
			Return 1	
		End If
		
		If (Not IsNull(ll_Filial_Envio) or (ll_Filial_Envio > 0)) And (Not IsNull(ll_Centro_Custo) or (ll_Centro_Custo > 0)) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Somente Filial ou Departamento podem ser selecionados.")
			dw_1.Event ue_Pos(1, "nm_fantasia")
			Return 1	
		End If
		
		If IsNull(ll_Qtde_Devolver) or (ll_Qtde_Devolver < 1) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o campo Qtde. Devolver.")
			dw_1.Event ue_Pos(1, "qt_devolver")		
			Return 1	
		End If
		
		If ll_Qtde_Devolver > il_Qt_Pedida Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A quantidade m$$HEX1$$e100$$ENDHEX$$xima $$HEX1$$e900$$ENDHEX$$ "+String(il_Qt_Pedida)+".")
			dw_1.Event ue_Pos(1, "qt_devolver")		
			Return 1	
		End If
		
End Choose

If wf_Prepara_Gravacao_Mensagem(ll_Mensagem, ll_Filial_Envio, ls_Matricula_Avisar, ll_Centro_Custo, ll_Qtde_Devolver, ldh_Limite_Validade) Then
	If dw_2.rowcount() > 0 Then MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Importa$$HEX2$$e700e300$$ENDHEX$$o e grava$$HEX2$$e700e300$$ENDHEX$$o da(s) mensagem(ns) realizada com sucesso.")
	Close(Parent)
End If
end event

type cb_1 from commandbutton within w_ge147_mensagem_logistica_produto
integer x = 1527
integer y = 868
integer width = 302
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Sair"
end type

event clicked;Close(Parent)
end event

type dw_2 from datawindow within w_ge147_mensagem_logistica_produto
event ue_closedw pbm_dwclosedropdown
boolean visible = false
integer y = 16
integer width = 1851
integer height = 840
integer taborder = 10
boolean titlebar = true
string title = "Cr$$HEX1$$ed00$$ENDHEX$$ticas de importa$$HEX2$$e700e300$$ENDHEX$$o"
string dataobject = "dw_ge147_produtos_arquivo"
boolean controlmenu = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylelowered!
end type

event ue_closedw;cb_2.visible = True
end event

type dw_1 from dc_uo_dw_base within w_ge147_mensagem_logistica_produto
integer x = 50
integer y = 92
integer width = 1746
integer height = 744
integer taborder = 20
string dataobject = "dw_ge147_mensagem_logistica_produto"
end type

event itemchanged;call super::itemchanged;String ls_Nulo
Long 	ll_Nulo
DateTime	ldh_Nulo

Choose Case dwo.Name 
	Case "nm_fantasia" 
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> io_Filial.nm_fantasia Then
				Return 1
			End If
		Else
			io_Filial.of_Inicializa()
			
			This.Object.cd_filial_envio	[1] = io_Filial.cd_filial
			This.Object.nm_fantasia		[1] = io_Filial.nm_fantasia
		End If
		
	Case "nm_usuario_avisar"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> io_Comprador.nm_usuario Then
				Return 1
			End If
		Else
			io_Comprador.of_Inicializa()
			
			This.Object.nr_matricula_avisar	[1] = io_Comprador.nr_matricula
			This.Object.nm_usuario_avisar  	[1] = io_Comprador.nm_usuario
		End If
		
	Case "de_centro_custo"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> io_Centro_Custo.De_Centro_Custo Then
				Return 1
			End If
		Else
			io_Centro_Custo.of_Inicializa()
			
			This.Object.Cd_Centro_Custo	[1] = io_Centro_Custo.Cd_Centro_Custo
			This.Object.De_Centro_Custo  	[1] = io_Centro_Custo.De_Centro_Custo
		End If
		
	Case "cd_mensagem"
		
		cb_4.Visible = (data="2" and this.getitemstring(row,"id_todos_produtos") = "S" )
		
		SetNull(ls_Nulo)
		SetNull(ll_Nulo)
		SetNull(ldh_Nulo)

		This.Object.nm_fantasia						[1]	= ls_Nulo
		This.Object.cd_filial_envio					[1]	= ll_Nulo
		This.Object.nm_usuario_avisar				[1]	= ls_Nulo
		This.Object.nr_matricula_avisar			[1]	= ls_Nulo
		This.Object.qt_devolver						[1]	= ll_Nulo
		This.Object.dh_limite_validade				[1]	= ldh_Nulo
				
		wf_Controla_Campos(Long(Data))
		
	Case "dh_limite_validade"
		This.Object.dh_limite_validade	[1] = DateTime(String(This.Object.dh_limite_validade	[1], "01/mm/yyyy"))
	
Case "id_todos_produtos"
		cb_4.Visible = (data="S" and this.getitemnumber(row,"cd_mensagem") = 2 )

End Choose

//Cb_2.Enabled = True
end event

event ue_key;call super::ue_key;If Key = KeyEnter! Then

	Choose Case This.GetColumnName()
		Case "nm_fantasia"
			io_Filial.of_Localiza_Filial(This.GetText())
			
			If Not io_Filial.Localizada Then
				io_Filial.of_Inicializa()
			End If
				
			This.Object.cd_filial_envio	[1] = io_Filial.cd_filial
			This.Object.nm_fantasia		[1] = io_Filial.nm_fantasia
			
		Case "nm_usuario_avisar"
			
			io_Comprador.of_Localiza_Comprador(This.GetText())
			
			If Not io_Comprador.Localizado Then
				io_Comprador.of_Inicializa()
			End If
				
			This.Object.nr_matricula_avisar	[1] = io_Comprador.nr_matricula
			This.Object.nm_usuario_avisar		[1] = io_Comprador.nm_usuario
			
		Case "de_centro_custo"
		
			io_Centro_Custo.of_Localiza_Centro_Custo(This.GetText())
			
			If Not io_Centro_Custo.Localizada Then
				io_Centro_Custo.of_Inicializa()
			End If
			
			This.Object.Cd_Centro_Custo	[1] = io_Centro_Custo.cd_centro_custo
			This.Object.De_Centro_Custo	[1] = io_Centro_Custo.de_centro_custo
	End Choose
End If
end event

event editchanged;call super::editchanged;Choose Case dwo.Name 
	Case "nm_fantasia" 
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> io_Filial.nm_fantasia Then
				Return 1
			End If
		Else
			io_Filial.of_Inicializa()
			
			This.Object.cd_filial_envio	[1] = io_Filial.cd_filial
			This.Object.nm_fantasia		[1] = io_Filial.nm_fantasia
		End If
		
	Case "nm_usuario_avisar"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> io_Comprador.nm_usuario Then
				Return 1
			End If
		Else
			io_Comprador.of_Inicializa()
			
			This.Object.nr_matricula_avisar	[1] = io_Comprador.nr_matricula
			This.Object.nm_usuario_avisar  	[1] = io_Comprador.nm_usuario
		End If
		
	Case "de_centro_custo"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> io_Centro_Custo.De_Centro_Custo Then
				Return 1
			End If
		Else
			io_Centro_Custo.of_Inicializa()
			
			This.Object.Cd_Centro_Custo	[1] = io_Centro_Custo.Cd_Centro_Custo
			This.Object.De_Centro_Custo  	[1] = io_Centro_Custo.De_Centro_Custo
		End If
		
End Choose

//Cb_2.Enabled = True
end event

type gb_1 from groupbox within w_ge147_mensagem_logistica_produto
integer x = 23
integer y = 32
integer width = 1806
integer height = 824
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

