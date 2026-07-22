HA$PBExportHeader$w_ge168_manutencao_novo_estoque_base.srw
forward
global type w_ge168_manutencao_novo_estoque_base from dc_w_selecao_lista_relatorio
end type
type gb_3 from groupbox within w_ge168_manutencao_novo_estoque_base
end type
type dw_4 from dc_uo_dw_base within w_ge168_manutencao_novo_estoque_base
end type
type cb_1 from commandbutton within w_ge168_manutencao_novo_estoque_base
end type
type cb_2 from commandbutton within w_ge168_manutencao_novo_estoque_base
end type
type dw_5 from dc_uo_dw_base within w_ge168_manutencao_novo_estoque_base
end type
type cb_3 from commandbutton within w_ge168_manutencao_novo_estoque_base
end type
type dw_6 from dc_uo_dw_base within w_ge168_manutencao_novo_estoque_base
end type
end forward

global type w_ge168_manutencao_novo_estoque_base from dc_w_selecao_lista_relatorio
integer width = 3945
integer height = 2088
string title = "GE168 - Manuten$$HEX2$$e700e300$$ENDHEX$$o do Estoque Base das Filiais"
long backcolor = 80269524
gb_3 gb_3
dw_4 dw_4
cb_1 cb_1
cb_2 cb_2
dw_5 dw_5
cb_3 cb_3
dw_6 dw_6
end type
global w_ge168_manutencao_novo_estoque_base w_ge168_manutencao_novo_estoque_base

type variables
uo_produto ivo_produto 

uo_filial ivo_filial

string ivs_filiais,&
		ivs_nulo,&
		is_Filias_Nao_Atualizadas


end variables

forward prototypes
public function boolean wf_localiza_usuario (string as_matricula, ref string as_nome)
public subroutine wf_atualiza_qtde_perfil (long al_perfil, long al_qtde, long al_qt_dias_bloqueio, datetime al_dh_bloqueio)
public function boolean wf_verifica_filial ()
public function boolean wf_verifica_fator_conversao_divisivel (long al_produto)
public subroutine wf_set_somente_consulta ()
public subroutine wf_atualiza_produto ()
public function boolean wf_lista_historico_min (long al_filial, long al_produto)
end prototypes

public function boolean wf_localiza_usuario (string as_matricula, ref string as_nome);Boolean lvb_Sucesso = True

Select nm_usuario Into :as_Nome
From usuario
Where nr_matricula = :as_Matricula
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
	Case 100
		as_Nome = "DESCONHECIDO"
		
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Usu$$HEX1$$e100$$ENDHEX$$rio")
		lvb_Sucesso = False
End Choose

Return lvb_Sucesso
end function

public subroutine wf_atualiza_qtde_perfil (long al_perfil, long al_qtde, long al_qt_dias_bloqueio, datetime al_dh_bloqueio);Long	lvl_Total, &
		lvl_Linha, &
		lvl_Perfil,&
		ll_Filial
		
String	ls_Parametro
	  
lvl_Total = dw_2.RowCount()

If lvl_Total > 0 Then
	For lvl_Linha = 1 To lvl_Total
		lvl_Perfil = dw_2.Object.cd_porte[lvl_Linha]
		
		If lvl_Perfil = al_Perfil Then			
			ll_Filial	= dw_2.Object.cd_filial[lvl_Linha]
			
			//Verifica se vai ser atulizado no SAP
			If Not gf_filial_administrada_sap(ll_Filial, Ref ls_Parametro) Then
				Return
			End If
			
			If ls_Parametro <> "S" Then
				dw_2.Object.Qt_Estoque_Base_Novo   		[lvl_Linha] = al_Qtde
				dw_2.Object.Qt_Dias_Bloqueio	      			[lvl_Linha] = al_Qt_Dias_Bloqueio
				dw_2.Object.Dh_Termino_Bloqueio_Novo	[lvl_Linha] = al_Dh_Bloqueio
			Else
				If is_Filias_Nao_Atualizadas = "" Then
					is_Filias_Nao_Atualizadas	= String(ll_Filial)
				Else
					is_Filias_Nao_Atualizadas += ", "+String(ll_Filial)
				End If
			End If
		End If		
	Next	
End If
end subroutine

public function boolean wf_verifica_filial ();String ls_Vl_Parametro

Select vl_parametro
Into :ls_Vl_Parametro
From parametro_loja
Where cd_parametro = 'ID_UTILIZA_NOVO_CALCULO_ESTOQUE_BASE'
	And cd_filial = :ivo_Filial.Cd_Filial
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If ls_Vl_Parametro = "N" Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Filial " + ivo_Filial.Nm_Fantasia + " (" + String(ivo_Filial.Cd_Filial) + ")" + " n$$HEX1$$e300$$ENDHEX$$o faz parte do novo c$$HEX1$$e100$$ENDHEX$$lculo do estoque base.", Exclamation!)
			Return False
		Else
			Return True
		End If
				
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da filial no novo estoque base.")
		Return False
		
End Choose
end function

public function boolean wf_verifica_fator_conversao_divisivel (long al_produto);If dw_5.Retrieve(al_Produto) = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no retrieve da dw_5. Fun$$HEX2$$e700e300$$ENDHEX$$o wf_verifica_fator_conversao_divisivel.", StopSign!)
	Return False
End If

If dw_5.Retrieve(al_Produto) > 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existem filiais com estoque base n$$HEX1$$e300$$ENDHEX$$o divis$$HEX1$$ed00$$ENDHEX$$vel pelo fator de convers$$HEX1$$e300$$ENDHEX$$o.", Exclamation!)
	OpenWithParm(w_ge168_lista_fat_conv_nao_divisivel, dw_5)
End If

Return True
end function

public subroutine wf_set_somente_consulta ();dw_2.of_set_somente_leitura(This.ivm_Menu.ivb_permite_alterar)
end subroutine

public subroutine wf_atualiza_produto ();String ls_Grupo, ls_Tipo, ls_Sit, ls_Grupo_Psico, ls_id_liberado_filiais

Select v.de_grupo, c.id_tipo_reposicao_estoque, g.id_situacao, g.cd_grupo_psico, g.id_liberado_filial
Into :ls_Grupo, :ls_Tipo, :ls_Sit, :ls_Grupo_Psico, :ls_id_liberado_filiais
From produto_geral g
inner join vw_classificacao_produto v
	on v.cd_subcategoria = g.cd_subcategoria
inner join produto_central c
	on c.cd_produto = g.cd_produto
Where g.cd_produto = :ivo_Produto.Cd_Produto
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDBError("Erro ao localizar o produto")
	Return
End If

If ls_Tipo = 'E' Then
	dw_1.Object.de_reposicao[1] = 'ESTAVEL'
Else
	dw_1.Object.de_reposicao[1] = 'SAZONAL'
End If


If ls_Sit = 'A' Then
	dw_1.Object.de_situacao[1] = 'ATIVO'
ElseIf ls_Sit = 'P' then
	dw_1.Object.de_situacao[1] = 'PENDENTE'
Else
	dw_1.Object.de_situacao[1] = 'INATIVO'
End If

dw_1.Object.de_grupo[1] 	= ls_Grupo
dw_1.Object.de_psico[1] 	= ls_Grupo_Psico



end subroutine

public function boolean wf_lista_historico_min (long al_filial, long al_produto);Long ll_Find
Long ll_Promocao
Long ll_Estoque_Minimo_Ant
Long ll_Null

dw_6.AcceptText()

ll_Find = dw_6.Find("cd_filial = " + String(al_Filial) + " and cd_produto = " + String(al_Produto), 1, dw_6.RowCount())

If ll_Find < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no primeiro Find da fun$$HEX2$$e700e300$$ENDHEX$$o wf_lista_historico_min.", StopSign!)
	Return False
End If

Do While ll_Find > 0
	ll_Promocao					= dw_6.Object.Cd_Promocao_Sos		[ll_Find]
	ll_Estoque_Minimo_Ant	= dw_6.Object.Qt_Estoque_Minimo	[ll_Find]
	
	If Not gf_ge134_Grava_Historico_Exclusao_Promo(ll_Promocao, al_Filial, al_Produto, ll_Estoque_Minimo_Ant, 'D', ll_Null) Then Return False	
	
	If ll_Find = dw_6.RowCount() Then Exit //Se estiver na $$HEX1$$fa00$$ENDHEX$$ltima linha sai do While para n$$HEX1$$e300$$ENDHEX$$o dar erro no Find + 1 da linha abaixo
	
	ll_Find = dw_6.Find("cd_filial = " + String(al_Filial) + " and cd_produto = " + String(al_Produto), ll_Find + 1, dw_6.RowCount())
Loop

Return True
end function

on w_ge168_manutencao_novo_estoque_base.create
int iCurrent
call super::create
this.gb_3=create gb_3
this.dw_4=create dw_4
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_5=create dw_5
this.cb_3=create cb_3
this.dw_6=create dw_6
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_3
this.Control[iCurrent+2]=this.dw_4
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.dw_5
this.Control[iCurrent+6]=this.cb_3
this.Control[iCurrent+7]=this.dw_6
end on

on w_ge168_manutencao_novo_estoque_base.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_3)
destroy(this.dw_4)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_5)
destroy(this.cb_3)
destroy(this.dw_6)
end on

event open;call super::open;ivo_Produto = Create uo_Produto
ivo_Filial  = Create uo_Filial

This.ivm_Menu.ivb_Permite_Imprimir = True
This.ivm_Menu.mf_Recuperar(True)

Setnull(ivs_nulo)
end event

event close;call super::close;Destroy(ivo_Produto)
Destroy(ivo_Filial)
end event

event ue_cancel;call super::ue_cancel;dw_1.Reset()
dw_2.Reset()
dw_4.Reset()

dw_1.Event ue_AddRow()

ivm_Menu.mf_Confirmar(False)
ivm_Menu.mf_Cancelar(False)
end event

event ue_save;// Override

Boolean lvb_Sucesso = True, &
        lvb_Alteracao = False

Long lvl_Linha, &
     lvl_Produto, &
	  lvl_Filial, &
     lvl_Estoque_Atual, &
	  lvl_Estoque_Novo, &
	  lvl_Find, &
	  lvl_Fator

DateTime lvdh_Bloqueio_Atual, &
         lvdh_Bloqueio_Novo
			
String ls_Motivo_Alteracao

dw_1.AcceptText()
dw_2.AcceptText()

lvl_Fator					= dw_1.Object.Vl_Fator_Conversao	[1]
ls_Motivo_Alteracao	= dw_1.Object.De_Motivo_Alteracao	[1]

If Trim(ls_Motivo_Alteracao) = "" Or IsNull(ls_Motivo_Alteracao) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o motivo da altera$$HEX2$$e700e300$$ENDHEX$$o.")
	dw_1.Event ue_Pos(1, "de_motivo_alteracao")
	Return -1
End If

//Carrega promo$$HEX2$$e700f500$$ENDHEX$$es ativas para gravar no historico de altera$$HEX2$$e700e300$$ENDHEX$$o
dw_6.Event ue_Reset()
dw_6.Event ue_Retrieve()

For lvl_Linha = 1 To dw_2.RowCount()
	lvl_Filial          = dw_2.Object.Cd_Filial               [lvl_Linha]
	lvl_Produto         = dw_2.Object.Cd_Produto              [lvl_Linha]
	lvl_Estoque_Atual   = dw_2.Object.Qt_Estoque_Base         [lvl_Linha]
	lvl_Estoque_Novo    = dw_2.Object.Qt_Estoque_Base_Novo    [lvl_Linha]
	lvdh_Bloqueio_Atual = dw_2.Object.Dh_Termino_Bloqueio     [lvl_Linha]
	lvdh_Bloqueio_Novo  = dw_2.Object.Dh_Termino_Bloqueio_Novo[lvl_Linha]
	
	If Not gf_parametro_filial_vacina(lvl_Filial, lvl_Produto) Then 
		dw_2.Event ue_Pos(lvl_Linha, "qt_estoque_base_novo")
		lvb_Sucesso = False
		Exit
	End If
	
	// Verifica se houve altera$$HEX2$$e700e300$$ENDHEX$$o do estoque base ou da data de t$$HEX1$$e900$$ENDHEX$$rmino do bloqueio
	If (lvl_Estoque_Novo <> lvl_Estoque_Atual) or &
	   (Not IsNull(lvdh_Bloqueio_Atual) and Not IsNull(lvdh_Bloqueio_Novo) and lvdh_Bloqueio_Atual <> lvdh_Bloqueio_Novo) or &
		(Not IsNull(lvdh_Bloqueio_Atual) and IsNull(lvdh_Bloqueio_Novo)) or &
		(Not IsNull(lvdh_Bloqueio_Novo)  and IsNull(lvdh_Bloqueio_Atual)) Then
		
		If Mod(lvl_Estoque_Novo, lvl_Fator) <> 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O estoque base deve ser m$$HEX1$$fa00$$ENDHEX$$ltiplo do fator de convers$$HEX1$$e300$$ENDHEX$$o utilizado no estoque central.", StopSign!)
			dw_2.Event ue_Pos(lvl_Linha, "qt_estoque_base_novo")
			lvb_Sucesso = False
			Exit
		End If
		
		lvb_Alteracao = True
		
		// Est$$HEX1$$e100$$ENDHEX$$ fazendo update na coluna qt_estoque_base_inicial para for$$HEX1$$e700$$ENDHEX$$ar a atualiza$$HEX2$$e700e300$$ENDHEX$$o
		// do log de exporta$$HEX2$$e700e300$$ENDHEX$$o
		
		Update resumo_reposicao_estoque
		Set qt_estoque_base_inicial = qt_estoque_base_inicial,
		    qt_estoque_base         = :lvl_Estoque_Novo,			 
			 dh_alteracao            = getdate(),
			 nr_matricula_alteracao  = :gvo_Aplicacao.ivo_Seguranca.Nr_Matricula,
			 id_alteracao            = 'M',
			 dh_termino_bloqueio     = :lvdh_Bloqueio_Novo,
			 de_motivo_alteracao = :ls_Motivo_Alteracao
		Where cd_filial  = :lvl_Filial
		  and cd_produto = :lvl_Produto
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgdbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do Estoque Base")
			lvb_Sucesso = False
			Exit
		End If
		
		If lvl_Estoque_Novo = 0 Then //Se zerar o estoque base o sistema exclui o m$$HEX1$$ed00$$ENDHEX$$nimo das promo$$HEX2$$e700f500$$ENDHEX$$es e grava hist$$HEX1$$f300$$ENDHEX$$rico
			If Not wf_Lista_Historico_Min(lvl_Filial, lvl_Produto) Then Return -1
		End If
	End If
Next

If Not lvb_Alteracao Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma altera$$HEX2$$e700e300$$ENDHEX$$o foi efetuada.", Information!)
	Return -1
Else
	If Not wf_Verifica_Fator_Conversao_Divisivel(lvl_Produto) Then
		SqlCa.of_RollBack()
		Return -1
	End If
End If

If lvb_Sucesso Then
	SqlCa.of_Commit()
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Estoques base atualizados com sucesso.", Information!)
	
	dw_2.Event ue_Retrieve()
Else
	SqlCa.of_RollBack()
End If

ivm_Menu.mf_Confirmar(False)
ivm_Menu.mf_Cancelar(False)
dw_1.Object.De_Motivo_Alteracao[1] = ""

Return 1
end event

event ue_preprint;call super::ue_preprint;String lvs_Rede

dw_1.AcceptText()

dw_3.Object.st_produto.Text = dw_1.Object.de_produto  [1]
//lvs_Rede 	  					  = dw_1.Object.id_rede_filial[1]

//Choose Case lvs_Rede
//	Case "TD"
//		dw_3.Object.st_rede.Text = "TODAS"
//	Case "AL"
//		dw_3.Object.st_rede.Text = "ALOMED"
//	Case "DC"
//		dw_3.Object.st_rede.Text = "DROGARIA CATARINENSE"
//	Case "CP"
//		dw_3.Object.st_rede.Text = "DROGARIA CATARINENSE PLUS"
//	Case "MP"
//		dw_3.Object.st_rede.Text = "MANIPULA$$HEX2$$c700c300$$ENDHEX$$O"
//	Case "PP"
//		dw_3.Object.st_rede.Text = "PRE$$HEX1$$c700$$ENDHEX$$O POPULAR"
//	Case "PF"
//		dw_3.Object.st_rede.Text = "PROFORMULA"
//End Choose

Return 1
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge168_manutencao_novo_estoque_base
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge168_manutencao_novo_estoque_base
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge168_manutencao_novo_estoque_base
integer x = 14
integer y = 864
integer width = 3854
integer height = 1020
string text = "Lista de Filiais"
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge168_manutencao_novo_estoque_base
integer x = 14
integer y = 0
integer width = 3854
integer height = 416
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge168_manutencao_novo_estoque_base
integer x = 41
integer y = 56
integer width = 3799
integer height = 344
string dataobject = "dw_ge168_selecao"
end type

event dw_1::itemchanged;//OverRide

Boolean lb_Ancestral = True
String ls_adm_sap
Long lvl_Lojas

Choose Case dwo.Name
	Case "de_produto"
		If Trim(Data) <> "" and Not IsNull(Data) Then
			If Data <> ivo_Produto.ivs_Descricao_Apresentacao_Venda Then
				Return 1
			End If
		Else
			ivo_Produto.of_Inicializa()
			
			This.Object.Cd_Produto      		 [1] = ivo_Produto.Cd_Produto
			This.Object.De_Produto        	 [1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
			This.Object.vl_fator_conversao  [1] = ivo_Produto.vl_fator_conversao
			
			This.Object.de_grupo				  [1] = ""
			This.Object.de_reposicao		  [1] = ""
			This.Object.de_situacao			  [1] = ""
			This.Object.de_psico				  [1] = ""
			
		End If	
			
	Case "nm_filial"
		If Trim(Data) <> "" and Not IsNull(Data) Then
			If Data <> ivo_Filial.Nm_Fantasia Then				
				Return 1
			End If
		Else
			ivo_Filial.of_Inicializa()
			
			This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
			This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
			
		End If
				
	Case "id_filiais"
		
		If Data = 'C' Then
		
			ivs_filiais = ivs_nulo 
			
			uo_ge216_filiais uo_filiais
			
			uo_Filiais = Create uo_ge216_filiais
			
			OpenWithParm(w_ge216_selecao_filiais, uo_Filiais)
			
			lvl_Lojas = Message.DoubleParm
			
			If lvl_Lojas > 0 Then
				ivs_filiais = uo_Filiais.ivs_filiais
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma filial foi selecionada.")
			End If
			
			Destroy(uo_Filiais)
		End If
				
				
		Case "de_motivo_alteracao"
			lb_Ancestral = False
				
End Choose

If lb_Ancestral Then
	dw_2.Event ue_Reset()
	dw_1.Object.De_Motivo_Alteracao[1] = ""
End If

If Not This.of_Coluna_Sem_Validacao_Salva(dwo.Name) Then
	If ivb_UpdateAble Then
		ivw_ParentWindow.ivb_Valida_Salva = True
	End If
End If

This.ivm_Menu.mf_Recuperar(True)
end event

event dw_1::ue_key;call super::ue_key;string ls_adm_sap

If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "de_produto"
			ivo_Produto.of_Localiza_Produto(This.GetText())
			
			If ivo_Produto.Localizado Then
				This.Object.Cd_Produto        [1] = ivo_Produto.Cd_Produto
				This.Object.De_Produto        [1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
				This.Object.Vl_Fator_Conversao[1] = ivo_Produto.Vl_Fator_Conversao
			End If
			
			wf_atualiza_produto()
			
//			If Not wf_Localiza_Grupo(Ref ls_Grupo) Then Return -1
//				
//				dw_1.Object.De_Grupo[1] = ls_Grupo
//				
//				If (Not IsNull(ivo_Produto.Cd_Grupo_Psico)) And (ivo_Produto.Cd_Grupo_Psico <> "") Then
//					This.Object.Id_Controlado[1] = "SIM"
//				Else
//					This.Object.Id_Controlado[1] = "N$$HEX1$$c300$$ENDHEX$$O"
//				End If			
					 
		Case "nm_filial"
			ivo_Filial.of_Localiza_Filial(This.GetText())
			
			If ivo_Filial.Localizada Then
				This.Object.Cd_Filial[1]	= ivo_Filial.Cd_Filial
				This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
				
				if Not gf_filial_administrada_sap(ivo_Filial.Cd_Filial, ref ls_adm_sap) Then
					return 1
				end if
								
				if ls_adm_sap = 'S' Then
					messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','A filial selecionada $$HEX1$$e900$$ENDHEX$$ administrada atrav$$HEX1$$e900$$ENDHEX$$s do SAP.~r$$HEX1$$c900$$ENDHEX$$ permitida apenas altera$$HEX2$$e700e300$$ENDHEX$$o de produto ALMOXARIFADO.', Exclamation!)
					return 1
				end if
				
//				If wf_Verifica_Filial() Then
//					This.ivm_Menu.mf_Recuperar(True)
//				End If

				This.ivm_Menu.mf_Recuperar(True)
			End If
	
			//dw_1.Object.id_rede_filial[1] = "TD"
			
	End Choose
	
		This.ivm_Menu.mf_Recuperar(True)
		
End If
end event

event dw_1::losefocus;If IsValid(ivo_Produto) Then
	This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
End If

If IsValid(ivo_Filial) Then
	This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
End If
end event

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)


end event

event dw_1::editchanged;//OverRide

If dwo.Name <> "de_motivo_alteracao" Then
	dw_2.Event ue_Reset()
	dw_1.Object.De_Motivo_Alteracao[1] = ""
End If

If Not This.of_Coluna_Sem_Validacao_Salva(dwo.Name) Then
	If ivb_UpdateAble Then
		ivw_ParentWindow.ivb_Valida_Salva = True
	End If
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge168_manutencao_novo_estoque_base
integer x = 46
integer y = 912
integer width = 3799
integer height = 952
string dataobject = "dw_ge168_lista"
end type

event dw_2::editchanged;call super::editchanged;Long lvl_Filial,&
	   lvl_Produto,&
	   lvl_Qtd
		
Long	ll_Filial,&
		ll_Qtde_Novo,&
		ll_Qtde_Dias

String	ls_Parametro

ll_Filial			= This.Object.cd_filial						[row]
ll_Qtde_Novo	= This.Object.qt_estoque_base_novo	[row]
ll_Qtde_Dias		= This.Object.qt_dias_bloqueio			[row]

//Verifica se vai ser atulizado no SAP
If Not gf_filial_mrp_sap(ll_Filial, Ref ls_Parametro) Then
	Return 1
End If

If ls_Parametro = "S" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Para altera$$HEX2$$e700f500$$ENDHEX$$es da filial "+String(ll_Filial)+" deve ser utilizado o SAP.")
	This.Object.qt_estoque_base_novo	[row] = ll_Qtde_Novo
	This.Object.qt_dias_bloqueio			[row] = ll_Qtde_Dias
	Return 1
End If	

ivm_Menu.mf_Confirmar(True)
ivm_Menu.mf_Cancelar(True)

Choose Case dwo.Name
	Case	"qt_estoque_base_novo"
			// Adicionado para Bloqueio de Movimento de Vacinas
			lvl_Filial = This.Object.cd_filial [Row]
			lvl_Produto = This.Object.cd_produto[Row]			
			lvl_Qtd = Long(Data)
			
			If lvl_Qtd>0 Then 				
				If Not gf_parametro_filial_vacina(lvl_Filial, lvl_Produto) Then 
					lvl_Qtd = 0 
					This.Object.qt_estoque_base_novo[Row] = lvl_Qtd					
					Return 1			
				End If 
			End If 		
End Choose
end event

event dw_2::constructor;call super::constructor;This.of_SetRowSelection("", "if(not isnull(dh_termino_bloqueio), rgb(255,0,0), rgb(0,0,0))")
end event

event dw_2::rowfocuschanged;call super::rowfocuschanged;String lvs_Matricula, &
		 lvs_Nome, &
       	 lvs_Descricao = ""
		 
DateTime lvdh_Alteracao, &
         lvdh_Termino_Bloqueio, &
			lvdh_Movimentacao


Long lvl_Dias_Bloqueio,&
	   lvl_Filial,&
	   lvl_Cd_Produto

If CurrentRow > 0 Then
	lvdh_Alteracao      	  = This.Object.Dh_Alteracao          [CurrentRow]
	lvs_Matricula         	  = This.Object.Nr_Matricula_Alteracao[CurrentRow]
	lvs_Nome              	  = This.Object.Nm_Alteracao          [CurrentRow]	
	lvdh_Termino_Bloqueio = This.Object.Dh_Termino_Bloqueio   [CurrentRow]	
	lvdh_Movimentacao      = This.Object.Dh_Movimentacao       [CurrentRow]	
	lvl_Filial					  = This.Object.Cd_Filial     [CurrentRow]	
	lvl_Cd_Produto			  = This.Object.Cd_Produto      [CurrentRow]		
	
	
	If Not IsNull(lvdh_Alteracao) Then
		lvs_Descricao = "ALTERADO EM '" + String(lvdh_Alteracao, "dd/mm/yyyy hh:mm") + "' POR '" + lvs_Nome + "'"
		
		If Not IsNull(lvdh_Termino_Bloqueio) Then
			lvl_Dias_Bloqueio = DaysAfter(Date(lvdh_Movimentacao), Date(lvdh_Termino_Bloqueio))
			
			If lvl_Dias_Bloqueio >= 0 Then
				If lvl_Dias_Bloqueio = 1 Then
					lvs_Descricao += " - BLOQUEADO POR 1 DIA"
				Else
					lvs_Descricao += " - BLOQUEADO POR " + String(lvl_Dias_Bloqueio) + " DIAS"
				End If
				
				lvs_Descricao += " AT$$HEX1$$c900$$ENDHEX$$ '" + String(lvdh_Termino_Bloqueio, "dd/mm/yyyy") + "'"
			End If
		End If
	End If
End If

This.Object.De_Alteracao.Text = lvs_Descricao
end event

event dw_2::ue_recuperar;// Override

Long lvl_Produto, &
     	lvl_Filial

String	lvs_Sql,&
			lvs_Somente_Beauty,&
			lvs_Filial,&
			ls_Manipulacao

dw_1.AcceptText()

lvl_Produto 					= dw_1.Object.Cd_Produto				[1]
lvl_Filial  						= dw_1.Object.Cd_Filial 					[1]
ls_Manipulacao				= dw_1.Object.id_manipulacao			[1]
lvs_Somente_Beauty	 	= dw_1.Object.id_somente_beauty	[1]
lvs_Filial						= dw_1.Object.id_filiais					[1]

If Not IsNull(lvl_Filial) and lvs_Filial = 'C' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a filial ou um conjunto de filiais.", StopSign!)
	dw_1.Event ue_Pos(1, "nm_filial")
	Return -1
End If

If IsNull(lvl_Produto) or lvl_Produto = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o produto.", StopSign!)
	dw_1.Event ue_Pos(1, "de_produto")
	Return -1
End If

If lvs_Filial = 'C' Then
	If Not IsNull(ivs_Filiais) Then
		This.of_appendwhere_subquery("r.cd_filial in (" + ivs_Filiais + ")", 2)
		This.of_appendwhere_subquery("r.cd_filial in (" + ivs_Filiais + ")", 5)
	End If
End If

If Not IsNull(lvl_Filial) and lvl_Filial > 0 Then
	This.of_appendwhere_subquery("r.cd_filial = " + String(lvl_Filial), 2)
	This.of_appendwhere_subquery("r.cd_filial = " + String(lvl_Filial), 5)
End If

If ls_Manipulacao = 'N' Then
	lvs_Sql = "f.id_rede_filial not in ('MP', 'PF')"
	
	// Ser$$HEX1$$e100$$ENDHEX$$ utilizado somente do primeiro union, pois o segundo $$HEX1$$e900$$ENDHEX$$ somente para os produtos almoxarifado
	This.of_appendwhere_subquery(lvs_Sql, 2)
End If

If lvs_Somente_Beauty = "S" Then
	This.of_appendwhere_subquery("r.cd_filial in (select cd_filial from parametro_loja where cd_parametro = 'ID_LOJA_BEAUTY_CLUB' " +&
			  "and vl_parametro = 'S')", 2)
End If

dw_4.Event ue_Retrieve()
Return This.Retrieve(lvl_Produto)
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;Long lvl_Linha, &
     lvl_Dias_Bloqueio

String lvs_Matricula, &
       lvs_Nome

DateTime lvdh_Termino_Bloqueio, &
         lvdh_Movimentacao

If pl_Linhas > 0 Then
	
	This.ivm_Menu.mf_SalvarComo(True)
	This.ivm_Menu.mf_Imprimir(True)
	
	For lvl_Linha = 1 To pl_Linhas
		lvs_Matricula         = This.Object.Nr_Matricula_Alteracao[lvl_Linha]
		lvdh_Termino_Bloqueio = This.Object.Dh_Termino_Bloqueio   [lvl_Linha]
		lvdh_Movimentacao     = This.Object.Dh_Movimentacao       [lvl_Linha]	
		
		If Not IsNull(lvs_Matricula) and Trim(lvs_Matricula) <> "" Then
			If wf_Localiza_Usuario(lvs_Matricula, ref lvs_Nome) Then
				This.Object.Nm_Alteracao[lvl_Linha] = lvs_Nome
			End If
		End If
		
		If Not IsNull(lvdh_Termino_Bloqueio) Then
			lvl_Dias_Bloqueio = DaysAfter(Date(lvdh_Movimentacao), Date(lvdh_Termino_Bloqueio))
			
			If lvl_Dias_Bloqueio < 0 Then
				SetNull(lvl_Dias_Bloqueio)
			End If
		Else
			lvl_Dias_Bloqueio = 0
		End If
		
		This.Object.Qt_Dias_Bloqueio[lvl_Linha] = lvl_Dias_Bloqueio
	Next
	
	This.Event RowFocusChanged(1)
Else
	//This.ivm_Menu.mf_SalvarComo(False)
	//This.ivm_Menu.mf_Imprimir(False)
End If

Return pl_Linhas
end event

event dw_2::itemchanged;call super::itemchanged;Long	lvl_Dias_Bloqueio,&
		ll_Filial
	   
DateTime lvdh_Termino_Bloqueio, &
         lvdh_Movimentacao
			
String	ls_Parametro			
			
ll_Filial	= This.Object.cd_filial[Row]

//Verifica se vai ser atulizado no SAP
If Not gf_filial_administrada_sap(ll_Filial, Ref ls_Parametro) Then
	Return 2
End If

If ls_Parametro = "S" And MidA(ivo_Produto.Cd_Subcategoria, 1, 1) <> "5" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Para a filial " +String(ll_Filial)+ " $$HEX1$$e900$$ENDHEX$$ permitida somente a altera$$HEX2$$e700e300$$ENDHEX$$o de ALMOXARIFADO.~rPara realizar altera$$HEX2$$e700e300$$ENDHEX$$o de outro grupo de produto utilize o SAP.", Exclamation!)
	Return 2
End If

Choose Case dwo.Name
	Case "qt_dias_bloqueio"
		lvl_Dias_Bloqueio = Long(Data)
		
		If lvl_Dias_Bloqueio > 0 Then
			lvdh_Movimentacao = This.Object.Dh_Movimentacao[Row]
			
			lvdh_Termino_Bloqueio = DateTime(RelativeDate(Date(lvdh_Movimentacao), lvl_Dias_Bloqueio))
		Else
			SetNull(lvdh_Termino_Bloqueio)
		End If
		
		This.Object.Dh_Termino_Bloqueio_Novo[Row] = lvdh_Termino_Bloqueio
		
//	Case "dh_termino_bloqueio_novo"
//		If Not IsDate(Data) Then
//			lvdh_Movimentacao = This.Object.Dh_Movimentacao[Row]
//			
//			lvdh_Termino_Bloqueio = DateTime(Date(String(Data, "dd/mm/yyyy")))
//			
//			lvl_Dias_Bloqueio = DaysAfter(Date(lvdh_Movimentacao), Date(lvdh_Termino_Bloqueio))
//		Else
//			lvl_Dias_Bloqueio = 0
//		End If
//		
//		This.Object.Qt_Dias_Bloqueio[Row] = lvl_Dias_Bloqueio
End Choose
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge168_manutencao_novo_estoque_base
integer x = 2597
integer y = 460
integer width = 215
integer height = 168
string dataobject = "dw_ge168_relatorio"
boolean vscrollbar = false
end type

type gb_3 from groupbox within w_ge168_manutencao_novo_estoque_base
integer x = 18
integer y = 416
integer width = 1504
integer height = 436
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista de Agrupamentos de Loja"
borderstyle borderstyle = styleraised!
end type

type dw_4 from dc_uo_dw_base within w_ge168_manutencao_novo_estoque_base
integer x = 41
integer y = 476
integer width = 1477
integer height = 348
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge168_lista_perfil_filial"
boolean vscrollbar = true
end type

event itemchanged;call super::itemchanged;//Long lvl_Dias_Bloqueio
//
//DateTime lvdh_Termino_Bloqueio, &
//         lvdh_Movimentacao
//
//Choose Case dwo.Name
//	Case "qt_dias_bloqueio"
//		lvl_Dias_Bloqueio = Long(Data)
//		
//		If lvl_Dias_Bloqueio > 0 Then
//			lvdh_Movimentacao = This.Object.Dh_Movimentacao[Row]
//			
//			lvdh_Termino_Bloqueio = DateTime(RelativeDate(Date(lvdh_Movimentacao), lvl_Dias_Bloqueio))
//		Else
//			SetNull(lvdh_Termino_Bloqueio)
//		End If
//		
//		This.Object.Dh_Bloqueio[Row] = lvdh_Termino_Bloqueio
//End Choose
end event

event constructor;call super::constructor;This.of_SetRowSelection()
end event

type cb_1 from commandbutton within w_ge168_manutencao_novo_estoque_base
boolean visible = false
integer x = 3058
integer y = 752
integer width = 809
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
string text = "&Atualizar Filiais Via Agrup."
end type

event clicked;//desabilitado no Chamado 2027746


DateTime lvdh_Dh_Bloqueio

Long lvl_Contador, &
     lvl_Perfil, &
	  lvl_Qtde, &
	  lvl_Qt_Dias_Bloqueio
	  
SetPointer(HourGlass!)

Open(w_Aguarde)
w_Aguarde.Title = "Atualizando a Quantidade por Perfil de Loja..."

dw_4.AcceptText()

dw_2.SetRedraw(False)	

is_Filias_Nao_Atualizadas = ""

For lvl_Contador = 1 To dw_4.RowCount()
	lvl_Perfil						= dw_4.Object.cd_porte				[lvl_Contador]
	lvl_Qtde  					= dw_4.Object.Qt_Estoque_Base	[lvl_Contador]
	lvl_Qt_Dias_Bloqueio 		= dw_4.Object.Qt_Dias_Bloqueio	[lvl_Contador]
	lvdh_Dh_Bloqueio			= dw_4.Object.Dh_Bloqueio			[lvl_Contador]

	wf_Atualiza_Qtde_Perfil(lvl_Perfil, lvl_Qtde, lvl_Qt_Dias_Bloqueio, lvdh_Dh_Bloqueio)
Next

dw_2.SetRedraw(True)
dw_2.SetFocus()

ivm_Menu.mf_Confirmar(True)
ivm_Menu.mf_Cancelar(True)
ivb_Valida_Salva = True

Close(w_Aguarde)
SetPointer(Arrow!)

If is_Filias_Nao_Atualizadas <> "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "As seguintes filiais devem ser alteradas pelo SAP: "+is_Filias_Nao_Atualizadas+" ~rAs demais foram atualizadas com sucesso. ")
	is_Filias_Nao_Atualizadas = ''
End If
end event

type cb_2 from commandbutton within w_ge168_manutencao_novo_estoque_base
integer x = 3058
integer y = 544
integer width = 809
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Hist$$HEX1$$f300$$ENDHEX$$rico de Altera$$HEX2$$e700f500$$ENDHEX$$es"
end type

event clicked;Long ll_Filial
Long ll_Produto

String ls_Parametro

If dw_2.RowCount() > 0 Then 
	
	dw_1.AcceptText()
	
	ll_Produto 	= dw_1.Object.cd_produto	[ 1 ]
	ll_Filial		= dw_2.Object.cd_filial			[ dw_2.GetRow() ]
	
	ls_Parametro = String( ll_Filial, '0000') + String( ll_Produto )
	
	OpenWithParm(w_ge168_historico_alteracao, ls_Parametro)
	
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Selecione uma filial para visualizar o hist$$HEX1$$f300$$ENDHEX$$rico das altera$$HEX2$$e700f500$$ENDHEX$$es do estoque base.")
	Return
End If
end event

type dw_5 from dc_uo_dw_base within w_ge168_manutencao_novo_estoque_base
boolean visible = false
integer x = 2834
integer y = 652
integer width = 215
integer height = 168
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge168_lista_fat_conv_nao_divisivel"
end type

type cb_3 from commandbutton within w_ge168_manutencao_novo_estoque_base
integer x = 3058
integer y = 648
integer width = 809
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Per$$HEX1$$ed00$$ENDHEX$$odo C$$HEX1$$e100$$ENDHEX$$lculo"
end type

event clicked;If dw_2.RowCount() > 0 Then 
	OpenWithParm(w_ge168_periodos_calculo, String(dw_2.Object.cd_filial[dw_2.GetRow()], "0000"))
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Selecione uma filial para visualizar o per$$HEX1$$ed00$$ENDHEX$$odo do rec$$HEX1$$e100$$ENDHEX$$lculo.")
	Return
End If
end event

type dw_6 from dc_uo_dw_base within w_ge168_manutencao_novo_estoque_base
boolean visible = false
integer x = 2834
integer y = 456
integer width = 215
integer height = 168
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge168_lista_historico_min"
end type

event ue_preretrieve;call super::ue_preretrieve;Long ll_Filial
Long ll_Produto

dw_1.AcceptText()

ll_Filial		= dw_1.Object.Cd_Filial		[1]
ll_Produto	= dw_1.Object.Cd_Produto	[1]

If Not IsNull(ll_Filial) And ll_Filial > 0 Then
	This.of_AppendWhere("a.cd_filial = " + String(ll_Filial))
End If

If Not IsNull(ll_Produto) And ll_Produto > 0 Then
	This.of_AppendWhere("a.cd_produto = " + String(ll_Produto))
End If

Return 1
end event

