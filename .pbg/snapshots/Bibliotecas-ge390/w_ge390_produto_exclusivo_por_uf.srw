HA$PBExportHeader$w_ge390_produto_exclusivo_por_uf.srw
forward
global type w_ge390_produto_exclusivo_por_uf from dc_w_cadastro_selecao_lista
end type
type cb_planilha from commandbutton within w_ge390_produto_exclusivo_por_uf
end type
type dw_3 from dc_uo_dw_base within w_ge390_produto_exclusivo_por_uf
end type
type cb_1 from commandbutton within w_ge390_produto_exclusivo_por_uf
end type
type cb_2 from commandbutton within w_ge390_produto_exclusivo_por_uf
end type
end forward

global type w_ge390_produto_exclusivo_por_uf from dc_w_cadastro_selecao_lista
integer width = 5280
integer height = 1956
string title = "GE390 - Cadastro de Produtos Exclusivos por UF"
cb_planilha cb_planilha
dw_3 dw_3
cb_1 cb_1
cb_2 cb_2
end type
global w_ge390_produto_exclusivo_por_uf w_ge390_produto_exclusivo_por_uf

type variables
uo_produto				io_Produto
uo_ge149_comprador	io_Comprador

Boolean ivb_Check
end variables

forward prototypes
public function long wf_le_dados_planilha (string as_arquivo)
public function boolean wf_verifica_inclusao_exclusao ()
public function boolean wf_permite_exclusao (ref boolean ab_permite)
public function boolean wf_verifica_movto_ec (long al_produto, ref datetime adh_entrada_cd)
public function boolean wf_saldo_ec (long al_produto, ref long al_qt_saldo_ec)
end prototypes

public function long wf_le_dados_planilha (string as_arquivo);Any la_Dado

Boolean lb_Altera

Integer li_Index

Long ll_Linha
Long ll_Linhas
Long ll_Sucesso = 1
Long ll_Produto

Try

	dc_uo_excel lo_Excel
	lo_Excel = Create dc_uo_excel
	
	uo_ge390_regras_inclusao lo_Regras
	lo_Regras = Create uo_ge390_regras_inclusao
	
	Open(w_Aguarde)
	w_Aguarde.Title = "Atualizando dados..."
	
	// Refer$$HEX1$$ea00$$ENDHEX$$ncia o arquivo 
	If ( lo_Excel.uo_Referencia_Objeto_Excel(as_Arquivo) ) Then
		// Coluna de Refer$$HEX1$$ea00$$ENDHEX$$ncia
		ll_Linhas = lo_Excel.uo_Verifica_Tamanho_Arquivo("A") 
		
		If ll_Linhas > 0 Then
			w_Aguarde.uo_Progress.of_SetMax(ll_Linhas)
			
			For ll_Linha = 1 To ll_Linhas
				
				lb_Altera = True			
				
				//Produto
				la_Dado = lo_Excel.uo_Lendo_Dados(ll_Linha, "A")
				
				If Not lo_Regras.of_Valida_Produto(Long(la_Dado)) Then
					//Se for nulo atribui branco para mostrar a mensagem
					If IsNull(la_Dado) Then
						la_Dado = ""
					End If
					
					li_Index += 1
					gvs_Log[li_Index] = "Produto '" + String(la_Dado) + "' inv$$HEX1$$e100$$ENDHEX$$lido ou n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ ativo. Linha '" + String(ll_Linha) + "'.~r~n"
					ll_Sucesso = 0
					lb_Altera = False
				End If
				
				ll_Produto = Long(la_Dado)
				
				If lb_Altera Then
					//Fun$$HEX2$$e700e300$$ENDHEX$$o para incluir os produtos
				End If
				
				w_Aguarde.uo_Progress.of_SetProgress(ll_Linha)
			Next
		Else
			ll_Sucesso = -1
		End If
	End If
	
	Return ll_Sucesso

Finally
	If IsValid(lo_Excel) Then Destroy(lo_Excel)
	If IsValid(lo_Regras) Then Destroy(lo_Regras)
	Close(w_Aguarde)
End Try
end function

public function boolean wf_verifica_inclusao_exclusao ();Long ll_Linha
Long ll_Find
Long ll_Produto

String ls_Erro
String ls_UF
String ls_id_pedido_exclusivo_falta

dwItemStatus lds_Status

dw_2.AcceptText()
dw_3.AcceptText()

Try
	
	uo_ge390_regras_inclusao lo_Regras
	lo_Regras = Create uo_ge390_regras_inclusao

	ll_Find = dw_2.Find("isnull(cd_produto) AND isnull(cd_unidade_federacao)", 1, dw_2.RowCount())
	
	If ll_Find > 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o produto e sua respectiva UF.")
		dw_2.Event ue_Pos(ll_Find, "de_produto")
		Return False
	End If
	
	//Verifica Exclus$$HEX1$$e300$$ENDHEX$$o
	For ll_Linha = 1 To dw_3.RowCount()
		ll_Produto	= dw_3.Object.Cd_Produto					[ll_Linha]
		ls_UF			= dw_3.Object.Cd_unidade_federacao	[ll_Linha]
			
		ll_Find = dw_2.Find("cd_produto = " + String(ll_Produto) + " AND cd_unidade_federacao = '" + ls_UF + "'", 1, dw_2.RowCount())
		
		If ll_Find = 0 Then
			
			Update produto_uf
				Set id_pedido_exclusivo_falta = 'N'
			Where cd_produto = :ll_Produto
				And cd_unidade_federacao = :ls_UF
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				ls_Erro = SqlCa.SqlErrText
				SqlCa.of_Rollback();
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao atualizar o 'id_pedido_exclusivo_falta' da tabela produto_uf. " + ls_Erro, StopSign!)
				Return False
			End If
			
			If Not gf_grava_historico_alteracao_tabela('PRODUTO_UF', String(ll_Produto), 'ID_PEDIDO_EXCLUSIVO_FALTA', 'S', 'N', gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'E', Ref ls_Erro, True) Then Return False
		End If
	Next
	
	ll_Linha = 0
	
	//Verifica Inclus$$HEX1$$e300$$ENDHEX$$o
	For ll_Linha = 1 To dw_2.RowCount()
		
		lds_Status = dw_2.GetItemStatus(ll_Linha, 0, Primary!)
		
		If lds_Status = DataModified! OR lds_Status = NewModified! THEN		
			ll_Produto	= dw_2.Object.Cd_Produto				[ll_Linha]
			ls_UF			= dw_2.Object.cd_unidade_federacao[ll_Linha]
						
			ll_Find = dw_3.Find("cd_produto = " + String(ll_Produto) + " AND cd_unidade_federacao = '" + ls_UF + "'", 1, dw_2.RowCount())
			
			If Not lo_Regras.of_verifica_uf_habilitada(ls_UF,ls_id_pedido_exclusivo_falta,ls_Erro) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao consultar a UF valida na tabela unidade_federacao:  " + ls_Erro, StopSign!)
				Return False
			End if
			
			If ls_id_pedido_exclusivo_falta = 'N' Then 
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O estado '"+ls_UF+"' n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ habilitado para pedidos exclusivos. Habilite a UF antes de adicionar os produto: "+String(ll_Produto)+"" , StopSign!)
				Continue
			End if 
		
			If ll_Find = 0 Then		
				If Not lo_Regras.of_Grava_Produto(ll_Produto,ls_UF, False) Then Return False
			End If
		End if
	Next
	
Finally
	Destroy(lo_Regras)
End Try

Return True
end function

public function boolean wf_permite_exclusao (ref boolean ab_permite);DateTime ldh_Atual

Long ll_Achou

String ls_inicio_pedido,ls_fim_pedido

Time lt_Agora

ab_Permite = True

ldh_Atual		= gf_GetServerDate()

lt_Agora = Time(ldh_Atual)

Select Count(*)
	Into :ll_Achou
From pedido_filial
Where dh_emissao >= :ldh_Atual
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar se j$$HEX1$$e100$$ENDHEX$$ foi gerado pedido na data atual. " + SqlCa.SqlErrText)
	Return False
End If

Select vl_parametro
	into: ls_inicio_pedido
From parametro_geral
where cd_parametro = 'HR_GERACAO_PEDIDO_DISTRIBUIDORA_INICIO'
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar horario do pedido distribuidora. " + SqlCa.SqlErrText)
	Return False
End If

Select vl_parametro
	into: ls_fim_pedido
From parametro_geral
where cd_parametro = 'HR_GERACAO_PEDIDO_DISTRIBUIDORA_FIM'
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar horario do pedido distribuidora. " + SqlCa.SqlErrText)
	Return False
End If

If ll_Achou > 0 Then
	If (lt_Agora >= Time(ls_inicio_pedido) And lt_Agora <= Time(ls_fim_pedido)) Then
		ab_Permite = False
	End If
End If


Return True
end function

public function boolean wf_verifica_movto_ec (long al_produto, ref datetime adh_entrada_cd);Select max(re.dh_resumo)
	Into :adh_Entrada_CD
	From resumo_movto_estq_prd re
Where re.cd_filial = 534
	And re.cd_produto = :al_Produto
	And re.qt_compra > 0
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar a $$HEX1$$fa00$$ENDHEX$$ltima movimenta$$HEX2$$e700e300$$ENDHEX$$o do produto no Estoque Central." + SqlCa.SqlErrText, StopSign!)
	Return False
End If

Return True
end function

public function boolean wf_saldo_ec (long al_produto, ref long al_qt_saldo_ec);Select qt_saldo_final
	Into: al_Qt_Saldo_Ec
From vw_saldo_atual_produto
Where cd_filial = 534
	And cd_produto = :al_Produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		//		
	Case 100
		al_Qt_Saldo_Ec = 0
		
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao consultar o saldo do Estoque Central.")
		Return False
End Choose
end function

on w_ge390_produto_exclusivo_por_uf.create
int iCurrent
call super::create
this.cb_planilha=create cb_planilha
this.dw_3=create dw_3
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_planilha
this.Control[iCurrent+2]=this.dw_3
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.cb_2
end on

on w_ge390_produto_exclusivo_por_uf.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_planilha)
destroy(this.dw_3)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event close;call super::close;Destroy(io_Produto)
Destroy(io_Comprador)
end event

event ue_preopen;call super::ue_preopen;io_produto		= Create uo_produto
io_Comprador	= Create uo_ge149_comprador
end event

event ue_save;//OverRide

If wf_Verifica_Inclusao_Exclusao() Then
	SqlCa.of_Commit();
	This.ivm_Menu.mf_Confirmar(False)
	This.ivm_Menu.mf_Cancelar(False)
	This.ivb_Valida_Salva = False
	dw_2.Event ue_Retrieve()
	dw_1.Enabled = True
End If

Return 1
end event

event ue_postopen;call super::ue_postopen;String lvs_Id_Inclusao
String lvs_Id_Alteracao
String lvs_Id_Exclusao

dw_2.Event ue_Retrieve()

Select id_inclusao, 
			 id_alteracao,
			 id_exclusao
	Into :lvs_Id_Inclusao,
		  :lvs_Id_Alteracao,
		  :lvs_Id_Exclusao
	From procedimento_perfil_usuario
	Where cd_sistema			= :gvo_Aplicacao.ivo_Seguranca.cd_sistema
	  and cd_procedimento	= 'W_GE390_PRODUTO_EXCLUSIVO_POR_UF'
	  and cd_perfil_usuario	= :gvo_Aplicacao.ivo_Seguranca.Cd_Perfil_Usuario
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If lvs_Id_Inclusao = "S" And lvs_Id_Alteracao = "S" And lvs_Id_Exclusao = "S" Then
			cb_planilha.Enabled = True
		End If
		
	Case 100
		
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao consultar o procedimento da tela. " + SqlCa.SqlErrText, StopSign!)
		Return
End Choose
end event

event closequery;call super::closequery;If ivb_Valida_Salva Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existem altera$$HEX2$$e700e300$$ENDHEX$$o pendentes.~rDeseja fechar a tela sem salvar?", Question!, YesNo!, 2) = 2 Then Return -1
End If
end event

event ue_cancel;call super::ue_cancel;dw_1.Enabled = True

dw_1.SetFocus()
end event

type dw_visual from dc_w_cadastro_selecao_lista`dw_visual within w_ge390_produto_exclusivo_por_uf
integer x = 37
integer y = 740
end type

type gb_aux_visual from dc_w_cadastro_selecao_lista`gb_aux_visual within w_ge390_produto_exclusivo_por_uf
integer x = 0
integer y = 668
end type

type dw_1 from dc_w_cadastro_selecao_lista`dw_1 within w_ge390_produto_exclusivo_por_uf
integer width = 1952
integer height = 256
string dataobject = "dw_ge390_selecao"
end type

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "de_produto"
			
			If ivb_Valida_Salva Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existem altera$$HEX2$$e700e300$$ENDHEX$$o pendentes.~rSalve ou cancele antes de continuar.", Exclamation!)
				Return 1
			End If
			
			io_Produto.of_Localiza_Produto(This.GetText())
						
			If io_Produto.Localizado Then				
				This.Object.Cd_Produto[1] = io_Produto.Cd_Produto
				This.Object.De_Produto[1] = io_Produto.ivs_Descricao_Apresentacao_Estoque
				
				//dw_2.Event ue_Retrieve()
			Else
				io_Produto.of_Inicializa()
			End If
			
		Case "nm_usuario"
		
			If ivb_Valida_Salva Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existem altera$$HEX2$$e700e300$$ENDHEX$$o pendentes.~rSalve ou cancele antes de continuar.", Exclamation!)
				Return 1
			End If
			
			io_Comprador.of_Localiza_Comprador(This.GetText())
						
			If io_Comprador.Localizado Then				
				This.Object.Nr_Matricula	[1] = io_Comprador.Nr_Matricula
				This.Object.Nm_Usuario	[1] = io_Comprador.Nm_Usuario
				
				//dw_2.Event ue_Retrieve()
			Else
				io_Comprador.of_Inicializa()
			End If
	End Choose
End If
end event

event dw_1::editchanged;call super::editchanged;dw_2.Event ue_Reset()
dw_3.Event ue_Reset()

Choose Case dwo.Name
	Case "de_produto"
		If Not IsNull(Data) and Data <> "" Then
			If Data <> io_Produto.ivs_Descricao_Apresentacao_Estoque Then
				Return 1
			End If
			
		Else
			io_Produto.of_Inicializa()
			
			This.Object.Cd_Produto[1] = io_Produto.Cd_Produto
			This.Object.De_Produto[1] = io_Produto.ivs_Descricao_Apresentacao_Estoque
		End If
		
	Case "nm_usuario"		
		If Not IsNull(Data) and Data <> "" Then
			If Data <> io_Comprador.Nm_Usuario Then
				Return 1
			End If
			
		Else
			io_Comprador.of_Inicializa()
			
			This.Object.Nr_Matricula	[1] = io_Comprador.Nr_Matricula
			This.Object.Nm_Usuario	[1] = io_Comprador.Nm_Usuario
		End If
End Choose
end event

event dw_1::itemchanged;call super::itemchanged;dw_2.Event ue_Reset()
dw_3.Event ue_Reset()

Choose Case dwo.Name
	Case "de_produto"
		If Not IsNull(Data) and Data <> "" Then
			If Data <> io_Produto.ivs_Descricao_Apresentacao_Estoque Then
				Return 1
			End If
			
		Else
			io_Produto.of_Inicializa()
			
			This.Object.Cd_Produto[1] = io_Produto.Cd_Produto
			This.Object.De_Produto[1] = io_Produto.ivs_Descricao_Apresentacao_Estoque
		End If
		
	Case "nm_usuario"		
		If Not IsNull(Data) and Data <> "" Then
			If Data <> io_Comprador.Nm_Usuario Then
				Return 1
			End If
			
		Else
			io_Comprador.of_Inicializa()
			
			This.Object.Nr_Matricula	[1] = io_Comprador.Nr_Matricula
			This.Object.Nm_Usuario	[1] = io_Comprador.Nm_Usuario
		End If
End Choose
end event

type gb_2 from dc_w_cadastro_selecao_lista`gb_2 within w_ge390_produto_exclusivo_por_uf
integer y = 384
integer width = 5193
integer height = 1380
end type

type gb_1 from dc_w_cadastro_selecao_lista`gb_1 within w_ge390_produto_exclusivo_por_uf
integer width = 2021
integer height = 352
end type

type dw_2 from dc_w_cadastro_selecao_lista`dw_2 within w_ge390_produto_exclusivo_por_uf
integer y = 460
integer width = 5120
integer height = 1276
string dataobject = "dw_ge390_lista"
end type

event dw_2::ue_key;call super::ue_key;DateTime ldh_Entrada_CD

Long ll_Find
Long ll_Qt_Saldo_EC

If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "de_produto"
			io_Produto.of_Localiza_Produto(This.GetText())
			
			If io_Produto.Localizado Then
				
				Try
				
					uo_ge390_regras_inclusao lo_Regras
					lo_Regras = Create uo_ge390_regras_inclusao
				
//					ll_Find = dw_2.Find("cd_produto = " + String(io_Produto.Cd_Produto), 1, dw_2.RowCount())
//					
//					If ll_Find < 0 Then
//						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no find da dw_2.", StopSign!)
//						Return 1
//					End If
//					
//					If ll_Find > 0 Then
//						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto j$$HEX1$$e100$$ENDHEX$$ consta na lista.")
//						Return 1
//					End If
					
					If Not lo_Regras.of_Valida_Produto(io_Produto.Cd_Produto) Then	Return 1
												
					This.Object.Cd_Produto				[dw_2.GetRow()] = io_Produto.Cd_Produto
					This.Object.De_Produto				[dw_2.GetRow()] = io_Produto.ivs_Descricao_Apresentacao_Estoque
					This.Object.De_Grupo					[dw_2.GetRow()] = lo_Regras.De_Grupo
					This.Object.Vl_Fator_Conversao	[dw_2.GetRow()] = io_Produto.Vl_Fator_Conversao
					This.Object.Cd_Grupo_Psico			[dw_2.GetRow()] = io_Produto.Cd_Grupo_Psico
					
					io_Comprador.of_Localiza_Comprador(io_Produto.Nr_Matricula_Comprador)
					
					If io_Comprador.Localizado Then
						This.Object.Nm_Usuario[dw_2.GetRow()] = io_Comprador.Nm_Usuario
					End If
					
					If Not wf_Verifica_Movto_Ec(io_Produto.Cd_Produto, Ref ldh_Entrada_CD) Then Return 1
					
					This.Object.Dh_Ultima_Compra[dw_2.GetRow()] = ldh_Entrada_CD
					
					If Not wf_Saldo_Ec(io_Produto.Cd_Produto, Ref ll_Qt_Saldo_EC) Then Return 1
					
					This.Object.Qt_Saldo_Final[dw_2.GetRow()] = ll_Qt_Saldo_EC					
				
				Finally
					Destroy(lo_Regras)
				End Try
	
			Else
				io_Produto.of_Inicializa()
			End If
	End Choose
End If
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long ll_Produto

String ls_Comprador

String ls_Uf

dw_1.AcceptText()

//Limpa a dw_3
dw_3.Event ue_Reset()

ll_Produto		= dw_1.Object.Cd_Produto	[1]
ls_Comprador	= dw_1.Object.Nr_Matricula	[1]
ls_Uf				= dw_1.Object.cd_uf			[1]

If Not IsNull(ll_Produto) And ll_Produto > 0 Then
	This.of_AppendWhere_SubQuery("pu.cd_produto = " + String(ll_Produto), 2)
End If

If Not IsNull(ls_Comprador) And Trim(ls_Comprador) <> "" Then
	This.of_AppendWhere_SubQuery("c.nr_matricula_comprador = '" + ls_Comprador + "'", 2)
End If

If Not IsNull(ls_Uf) And Trim(ls_Uf) <> "" Then
	This.of_AppendWhere_SubQuery("pu.cd_unidade_federacao = '" + ls_Uf + "'", 2)
End If

Return 1
end event

event dw_2::constructor;call super::constructor;This.ivb_Ordena_Colunas = True

ivi_Tipo_Cancelar = RETRIEVE
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;dw_3.Reset()

If pl_Linhas > 0 Then
	If dw_2.RowsCopy(1, dw_2.RowCount(), Primary!, dw_3, 1, Primary!) = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no RowsCopy da dw_3.", StopSign!)
		Return -1
	End If
	
	This.ivo_Controle_Menu.of_SalvarComo(True)
Else
	This.ivo_Controle_Menu.of_SalvarComo(False)
End If

Return pl_Linhas
end event

event dw_2::ue_deleterow;//OverRide
Boolean lvb_Retorno = False
Boolean lb_Permite

Long ll_Find
Long ll_Produto

String ls_Selecionado

This.AcceptText()

ll_Find = This.Find("id_selecionado = 'S'", 1, This.RowCount())

If ll_Find = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum produto foi selecionado para ser exclu$$HEX1$$ed00$$ENDHEX$$do.")
	Return False
End If

If Not wf_Permite_Exclusao(Ref lb_Permite) Then Return False

If Not lb_Permite Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Pedido do dia corrente j$$HEX1$$e100$$ENDHEX$$ foi gerado. N$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ permitida a exclus$$HEX1$$e300$$ENDHEX$$o.", Exclamation!)
	Return False
End If

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a exclus$$HEX1$$e300$$ENDHEX$$o do(s) registro(s) selecionado(s) ?", Question!, YesNo!, 2) = 2 Then Return False

Do While ll_Find > 0
		
	ls_Selecionado = This.Object.Id_Selecionado[ll_Find]
	ll_Produto		= This.Object.Cd_Produto[ll_Find]	
	
	If ls_Selecionado = "S" Then

		If This.DeleteRow(ll_Find) = 1 Then
			If Not IsNull(ivm_Menu) Then			
				ivm_Menu.mf_Confirmar(True)
				ivm_Menu.mf_Cancelar(True)
				
				If This.RowCount() = 0 Then	
					ivm_Menu.mf_Imprimir(False)
					ivm_Menu.mf_Excluir(False)
				ElseIf This.RowCount() = 1 Then
					ivm_Menu.mf_Classificar(False)
					ivm_Menu.mf_Filtrar(False)
					ivm_Menu.mf_Localizar(False)
				End If	
			End If
			
			// Se for uma DW atualiz$$HEX1$$e100$$ENDHEX$$vel, habilita a valida$$HEX2$$e700e300$$ENDHEX$$o do closequery da janela
			If ivb_UpdateAble Then
				ivw_ParentWindow.ivb_Valida_Salva = True
			End If
			
			lvb_Retorno = True
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao excluir o registro.", StopSign!)
			Return False
		End If
	End If
	
	ll_Find = This.Find("id_selecionado = 'S'", 1, This.RowCount())
Loop

Return lvb_Retorno
end event

event dw_2::doubleclicked;call super::doubleclicked;If dwo.Name = 'st_selecionado' Then
	
	If dw_2.RowCount() > 0 Then		
		Parent.ivm_Menu.mf_Confirmar(True)
		Parent.ivm_Menu.mf_Cancelar(True)
	End If
	
	Long lvl_Row
	
	String lvs_Marcacao
	
	If ivb_Check Then
		lvs_Marcacao = 'N'
		ivb_Check = False
	Else
		lvs_Marcacao = 'S'
		ivb_Check = True
	End If
	
	For lvl_Row = 1 To This.RowCount()				
		This.Object.Id_Selecionado[lvl_Row] = lvs_Marcacao		
	Next
End If
end event

event dw_2::editchanged;call super::editchanged;dw_1.Enabled = False
end event

event dw_2::itemchanged;call super::itemchanged;dw_1.Enabled = False
end event

event dw_2::ue_preinsertrow;call super::ue_preinsertrow;dw_2.AcceptText()

If AncestorReturnValue = 1 Then
	If dw_2.RowCount() > 0 Then
		If IsNull(String(dw_2.Object.Cd_Produto[dw_2.RowCount()])) Or String(dw_2.Object.Cd_Produto[dw_2.RowCount()]) = "" Then
			Return -1
		End If
	End If
End If

Return AncestorReturnValue
end event

event dw_2::ue_preupdate;call super::ue_preupdate;Long	lvl_Produto
Long	ll_Linhas
Long	ll_Linha

String	lvs_UF
Boolean lb_existe
String	ls_msg

dwItemStatus lds_Status

Try
	
	uo_ge390_regras_inclusao lo_Regras
	lo_Regras = Create uo_ge390_regras_inclusao
	dw_2.AcceptText()
	
	ll_Linhas = dw_2.RowCount()

	For ll_Linha = 1 to ll_Linhas
	
		lds_Status = dw_2.GetItemStatus(ll_Linha, 0, Primary!)
	
		If lds_Status = DataModified! OR lds_Status = NewModified! THEN
			
			lvs_UF								= dw_2.Object.cd_unidade_federacao		[ll_Linha]
			lvl_Produto							= dw_2.Object.Cd_Produto              			[ll_Linha]
				
			If IsNull(lvl_Produto) or lvl_Produto = 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o produto.")
				Return -1
			End If
			
			If IsNull(lvs_UF) or Trim(lvs_UF) = "" Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a UF ")
				Return -1
			End If
		
			/*//Chama a fun$$HEX2$$e700e300$$ENDHEX$$o que verifica se j$$HEX1$$e100$$ENDHEX$$ existe
			If not wf_verifica_registro_existente(lvs_Produto_Distribuidora,lvs_Distribuidora,lb_existe,ls_msg) Then
				MessageBox("Erro", "Ocorreu um erro ao salvar o produto, fecha a tela e tente novamente")
			End if
	
			If lb_existe = True and lds_Status = NewModified! Then
				MessageBox("Erro", "Produto '"+ string(lvl_Produto) +"'para o estado "+ lvs_UF +"  j$$HEX1$$e100$$ENDHEX$$ cadastrado, n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ possivel salvar novamente.")
				Return -1
			End if */
			
			If Not lo_Regras.of_Valida_Inclusao(lvl_Produto,lvs_UF, True) Then	Return 1
			
			If Not lo_Regras.of_Verifica_Produto_Ja_Incluido(lvl_Produto,lvs_UF) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto " + String(lvl_Produto) + " para o estado "+ lvs_UF +" j$$HEX1$$e100$$ENDHEX$$ $$HEX1$$e900$$ENDHEX$$ exclusivo.", Exclamation!)
				Return 1
			End If
	
	
		End if
	
	Next

Finally
	Destroy(lo_Regras)
End Try

Return 1


	
//					ll_Find = dw_2.Find("cd_produto = " + String(io_Produto.Cd_Produto), 1, dw_2.RowCount())
//					
//					If ll_Find < 0 Then
//						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no find da dw_2.", StopSign!)
//						Return 1
//					End If
//					
//					If ll_Find > 0 Then
//						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto j$$HEX1$$e100$$ENDHEX$$ consta na lista.")
//						Return 1
//					End If
//					
//					If Not lo_Regras.of_Valida_Produto(io_Produto.Cd_Produto) Then	Return 1
//									
//					If Not lo_Regras.of_Valida_Inclusao(io_Produto.Cd_Produto, True) Then	Return 1
//												
//					This.Object.Cd_Produto				[dw_2.GetRow()] = io_Produto.Cd_Produto
//					This.Object.De_Produto				[dw_2.GetRow()] = io_Produto.ivs_Descricao_Apresentacao_Estoque
//					This.Object.De_Grupo					[dw_2.GetRow()] = lo_Regras.De_Grupo
//					This.Object.Vl_Fator_Conversao	[dw_2.GetRow()] = io_Produto.Vl_Fator_Conversao
//					This.Object.Cd_Grupo_Psico			[dw_2.GetRow()] = io_Produto.Cd_Grupo_Psico
//					
//					io_Comprador.of_Localiza_Comprador(io_Produto.Nr_Matricula_Comprador)
//					
//					If io_Comprador.Localizado Then
//						This.Object.Nm_Usuario[dw_2.GetRow()] = io_Comprador.Nm_Usuario
//					End If
//					
//					If Not wf_Verifica_Movto_Ec(io_Produto.Cd_Produto, Ref ldh_Entrada_CD) Then Return 1
//					
//					This.Object.Dh_Ultima_Compra[dw_2.GetRow()] = ldh_Entrada_CD
//					
//					If Not wf_Saldo_Ec(io_Produto.Cd_Produto, Ref ll_Qt_Saldo_EC) Then Return 1
//					
//					This.Object.Qt_Saldo_Final[dw_2.GetRow()] = ll_Qt_Saldo_EC					
				


end event

type cb_planilha from commandbutton within w_ge390_produto_exclusivo_por_uf
integer x = 2098
integer y = 120
integer width = 635
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
string text = "Atualizar via Planilha"
end type

event clicked;String ls_Retorno

If ivb_Valida_Salva Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existem altera$$HEX2$$e700f500$$ENDHEX$$es pendentes.~rSalve ou cancele as altera$$HEX2$$e700f500$$ENDHEX$$es.", Exclamation!)
	Return -1
End If

OpenWithParm(w_ge390_importa_planilha, "")

ls_Retorno = Message.StringParm

If Not IsNull(ls_Retorno) Then
	dw_2.Event ue_Retrieve()
End If
end event

type dw_3 from dc_uo_dw_base within w_ge390_produto_exclusivo_por_uf
boolean visible = false
integer x = 2761
integer y = 900
integer width = 791
integer height = 420
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge390_lista_original"
end type

type cb_1 from commandbutton within w_ge390_produto_exclusivo_por_uf
integer x = 2098
integer y = 256
integer width = 635
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Hist$$HEX1$$f300$$ENDHEX$$rico de Altera$$HEX2$$e700e300$$ENDHEX$$o"
end type

event clicked;OpenWithParm(w_ge390_historico_alteracao_produto, "")
end event

type cb_2 from commandbutton within w_ge390_produto_exclusivo_por_uf
integer x = 2857
integer y = 108
integer width = 571
integer height = 112
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "HAB./DES. UF"
end type

event clicked;String ls_Retorno

OpenWithParm(w_ge390_habilita_uf, "")

end event

