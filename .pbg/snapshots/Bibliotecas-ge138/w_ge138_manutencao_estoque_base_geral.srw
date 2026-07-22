HA$PBExportHeader$w_ge138_manutencao_estoque_base_geral.srw
forward
global type w_ge138_manutencao_estoque_base_geral from dc_w_selecao_lista_relatorio
end type
type gb_3 from groupbox within w_ge138_manutencao_estoque_base_geral
end type
type dw_4 from dc_uo_dw_base within w_ge138_manutencao_estoque_base_geral
end type
type cb_1 from commandbutton within w_ge138_manutencao_estoque_base_geral
end type
type cb_2 from commandbutton within w_ge138_manutencao_estoque_base_geral
end type
type dw_5 from dc_uo_dw_base within w_ge138_manutencao_estoque_base_geral
end type
end forward

global type w_ge138_manutencao_estoque_base_geral from dc_w_selecao_lista_relatorio
string accessiblename = "Manuten$$HEX2$$e700e300$$ENDHEX$$o do Estoque Base das Filiais (GE138)"
integer width = 3566
integer height = 2068
string title = "GE138 - Manuten$$HEX2$$e700e300$$ENDHEX$$o do Estoque Base das Filiais"
long backcolor = 80269524
gb_3 gb_3
dw_4 dw_4
cb_1 cb_1
cb_2 cb_2
dw_5 dw_5
end type
global w_ge138_manutencao_estoque_base_geral w_ge138_manutencao_estoque_base_geral

type variables
uo_produto ivo_produto 

uo_filial ivo_filial

string ivs_filiais, ivs_nulo


end variables

forward prototypes
public function boolean wf_localiza_usuario (string as_matricula, ref string as_nome)
public subroutine wf_atualiza_qtde_perfil (long al_perfil, long al_qtde, long al_qt_dias_bloqueio, datetime al_dh_bloqueio)
public function boolean wf_verifica_fator_conversao_divisivel (long al_produto)
public subroutine wf_set_somente_consulta ()
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

public subroutine wf_atualiza_qtde_perfil (long al_perfil, long al_qtde, long al_qt_dias_bloqueio, datetime al_dh_bloqueio);Long lvl_Total, &
     lvl_Linha, &
	  lvl_Perfil
	  
lvl_Total = dw_2.RowCount()

If lvl_Total > 0 Then
	For lvl_Linha = 1 To lvl_Total
		lvl_Perfil = dw_2.Object.cd_porte[lvl_Linha]
		
		If lvl_Perfil = al_Perfil Then
			dw_2.Object.Qt_Estoque_Base_Novo    [lvl_Linha] = al_Qtde
			dw_2.Object.Qt_Dias_Bloqueio	      [lvl_Linha] = al_Qt_Dias_Bloqueio
			dw_2.Object.Dh_Termino_Bloqueio_Novo[lvl_Linha] = al_Dh_Bloqueio
		End If		
	Next	
End If
end subroutine

public function boolean wf_verifica_fator_conversao_divisivel (long al_produto);If dw_5.Retrieve(al_Produto) = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no retrieve da dw_5. Fun$$HEX2$$e700e300$$ENDHEX$$o wf_verifica_fator_conversao_divisivel.", StopSign!)
	Return False
End If

If dw_5.Retrieve(al_Produto) > 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existem filiais com estoque base n$$HEX1$$e300$$ENDHEX$$o divis$$HEX1$$ed00$$ENDHEX$$vel pelo fator de convers$$HEX1$$e300$$ENDHEX$$o.", Exclamation!)
	OpenWithParm(w_ge138_lista_fat_conv_nao_divisivel, dw_5)
End If

Return True
end function

public subroutine wf_set_somente_consulta ();dw_2.of_set_somente_leitura(This.ivm_Menu.ivb_permite_alterar)
end subroutine

on w_ge138_manutencao_estoque_base_geral.create
int iCurrent
call super::create
this.gb_3=create gb_3
this.dw_4=create dw_4
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_5=create dw_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_3
this.Control[iCurrent+2]=this.dw_4
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.dw_5
end on

on w_ge138_manutencao_estoque_base_geral.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_3)
destroy(this.dw_4)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_5)
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
		
String ls_Nulo
String ls_Motivo_Alteracao

dw_1.AcceptText()
dw_2.AcceptText()

SetNull(ls_Nulo)

lvl_Fator = dw_1.Object.Vl_Fator_Conversao[1]
ls_Motivo_Alteracao	= dw_1.Object.De_Motivo_Alteracao	[1]

If Trim(ls_Motivo_Alteracao) = "" Or IsNull(ls_Motivo_Alteracao) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o motivo da altera$$HEX2$$e700e300$$ENDHEX$$o.")
	dw_1.Event ue_Pos(1, "de_motivo_alteracao")
	Return -1
End If

For lvl_Linha = 1 To dw_2.RowCount()
	lvl_Filial          = dw_2.Object.Cd_Filial               [lvl_Linha]
	lvl_Produto         = dw_2.Object.Cd_Produto              [lvl_Linha]
	lvl_Estoque_Atual   = dw_2.Object.Qt_Estoque_Base         [lvl_Linha]
	lvl_Estoque_Novo    = dw_2.Object.Qt_Estoque_Base_Novo    [lvl_Linha]
	lvdh_Bloqueio_Atual = dw_2.Object.Dh_Termino_Bloqueio     [lvl_Linha]
	lvdh_Bloqueio_Novo  = dw_2.Object.Dh_Termino_Bloqueio_Novo[lvl_Linha]
	
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

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge138_manutencao_estoque_base_geral
integer y = 1320
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge138_manutencao_estoque_base_geral
integer y = 1248
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge138_manutencao_estoque_base_geral
integer x = 14
integer y = 856
integer width = 3465
integer height = 988
integer weight = 700
string text = "Lista de Filiais"
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge138_manutencao_estoque_base_geral
integer x = 18
integer y = 0
integer width = 3410
integer height = 388
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge138_manutencao_estoque_base_geral
integer x = 41
integer y = 56
integer width = 3374
integer height = 316
string dataobject = "dw_ge138_selecao"
end type

event dw_1::itemchanged;//OverRide

Boolean lb_Ancestral

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
		
	Case "id_eb_novo"
		If Data = 'S' Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Ser$$HEX1$$e300$$ENDHEX$$o listadas as filiais que est$$HEX1$$e300$$ENDHEX$$o no novo c$$HEX1$$e100$$ENDHEX$$lculo do estoque base.")
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

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "de_produto"
			ivo_Produto.of_Localiza_Produto(This.GetText())
			
			If ivo_Produto.Localizado Then
				This.Object.Cd_Produto        [1] = ivo_Produto.Cd_Produto
				This.Object.De_Produto        [1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
				This.Object.Vl_Fator_Conversao[1] = ivo_Produto.Vl_Fator_Conversao
			End If
			
					 
		Case "nm_filial"
			ivo_Filial.of_Localiza_Filial(This.GetText())
			
			If ivo_Filial.Localizada Then
				This.Object.Cd_Filial[1]	= ivo_Filial.Cd_Filial
				This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia	
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

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge138_manutencao_estoque_base_geral
integer x = 32
integer y = 904
integer width = 3424
integer height = 920
string dataobject = "dw_ge138_lista"
end type

event dw_2::editchanged;call super::editchanged;ivm_Menu.mf_Confirmar(True)
ivm_Menu.mf_Cancelar(True)
end event

event dw_2::constructor;call super::constructor;This.of_SetRowSelection("", "if(not isnull(dh_termino_bloqueio), rgb(255,0,0), rgb(0,0,0))")
end event

event dw_2::rowfocuschanged;call super::rowfocuschanged;String lvs_Matricula, &
		 lvs_Nome, &
       lvs_Descricao = ""
		 
DateTime lvdh_Alteracao, &
         lvdh_Termino_Bloqueio, &
			lvdh_Movimentacao

Long lvl_Dias_Bloqueio

If CurrentRow > 0 Then
	lvdh_Alteracao        = This.Object.Dh_Alteracao          [CurrentRow]
	lvs_Matricula         = This.Object.Nr_Matricula_Alteracao[CurrentRow]
	lvs_Nome              = This.Object.Nm_Alteracao          [CurrentRow]	
	lvdh_Termino_Bloqueio = This.Object.Dh_Termino_Bloqueio   [CurrentRow]	
	lvdh_Movimentacao     = This.Object.Dh_Movimentacao       [CurrentRow]	
	
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
			ls_Manipulacao, &
			ls_Id_Eb_Novo

dw_1.AcceptText()

lvl_Produto 					= dw_1.Object.Cd_Produto				[1]
lvl_Filial  						= dw_1.Object.Cd_Filial 					[1]
ls_Manipulacao				= dw_1.Object.id_manipulacao			[1]
lvs_Somente_Beauty	 	= dw_1.Object.id_somente_beauty	[1]
lvs_Filial						= dw_1.Object.id_filiais					[1]
ls_Id_Eb_Novo				= dw_1.Object.Id_Eb_Novo				[1]

If Not IsNull(lvl_Filial) and lvs_Filial = 'C' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a filial ou um conjunto de filiais.", StopSign!)
	dw_1.Event ue_Pos(1, "nm_filial")
	Return -1
End If

If IsNull(lvl_Produto) or lvl_Produto = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o produto.")
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
	lvs_Sql = "r.cd_filial in (select cd_filial from parametro_loja where cd_parametro = 'ID_REDE_FILIAL' " +&
			  "and vl_parametro not in ('MP', 'PF') )"
	
	// Ser$$HEX1$$e100$$ENDHEX$$ utilizado somente do primeiro union, pois o segundo $$HEX1$$e900$$ENDHEX$$ somente para os produtos almoxarifado
	This.of_appendwhere_subquery(lvs_Sql, 2)
End If

If lvs_Somente_Beauty = "S" Then
	This.of_appendwhere_subquery("r.cd_filial in (select cd_filial from parametro_loja where cd_parametro = 'ID_LOJA_BEAUTY_CLUB' " +&
			  "and vl_parametro = 'S')", 2)
End If

If ls_Id_Eb_Novo = 'N' Then
	This.of_appendwhere_subquery("r.cd_filial not in (select cd_filial from parametro_loja where cd_parametro = 'ID_UTILIZA_NOVO_CALCULO_ESTOQUE_BASE' and vl_parametro = 'S')", 2)
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
				lvl_Dias_Bloqueio = 0
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

event dw_2::itemchanged;call super::itemchanged;Long lvl_Dias_Bloqueio

DateTime lvdh_Termino_Bloqueio, &
         lvdh_Movimentacao

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

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge138_manutencao_estoque_base_geral
integer x = 2866
integer y = 464
integer height = 160
string dataobject = "dw_ge138_relatorio"
end type

type gb_3 from groupbox within w_ge138_manutencao_estoque_base_geral
integer x = 18
integer y = 412
integer width = 2615
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
string text = "Lista de Porte de Loja"
borderstyle borderstyle = styleraised!
end type

type dw_4 from dc_uo_dw_base within w_ge138_manutencao_estoque_base_geral
integer x = 41
integer y = 472
integer width = 2569
integer height = 348
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge138_lista_perfil_filial"
boolean vscrollbar = true
end type

event itemchanged;call super::itemchanged;Long lvl_Dias_Bloqueio

DateTime lvdh_Termino_Bloqueio, &
         lvdh_Movimentacao

Choose Case dwo.Name
	Case "qt_dias_bloqueio"
		lvl_Dias_Bloqueio = Long(Data)
		
		If lvl_Dias_Bloqueio > 0 Then
			lvdh_Movimentacao = This.Object.Dh_Movimentacao[Row]
			
			lvdh_Termino_Bloqueio = DateTime(RelativeDate(Date(lvdh_Movimentacao), lvl_Dias_Bloqueio))
		Else
			SetNull(lvdh_Termino_Bloqueio)
		End If
		
		This.Object.Dh_Bloqueio[Row] = lvdh_Termino_Bloqueio
End Choose
end event

event constructor;call super::constructor;This.of_SetRowSelection()
end event

type cb_1 from commandbutton within w_ge138_manutencao_estoque_base_geral
integer x = 2670
integer y = 748
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
string text = "&Atualizar Filiais Via Porte"
end type

event clicked;DateTime lvdh_Dh_Bloqueio

Long lvl_Contador, &
     lvl_Perfil, &
	  lvl_Qtde, &
	  lvl_Qt_Dias_Bloqueio
	  
SetPointer(HourGlass!)

Open(w_Aguarde)
w_Aguarde.Title = "Atualizando a Quantidade por Perfil de Loja..."

dw_4.AcceptText()

dw_2.SetRedraw(False)	

For lvl_Contador = 1 To dw_4.RowCount()
	lvl_Perfil						= dw_4.Object.cd_porte[lvl_Contador]
	lvl_Qtde  					= dw_4.Object.Qt_Estoque_Base	[lvl_Contador]
	lvl_Qt_Dias_Bloqueio 	= dw_4.Object.Qt_Dias_Bloqueio[lvl_Contador]
	lvdh_Dh_Bloqueio		= dw_4.Object.Dh_Bloqueio		[lvl_Contador]

	wf_Atualiza_Qtde_Perfil(lvl_Perfil, lvl_Qtde, lvl_Qt_Dias_Bloqueio, lvdh_Dh_Bloqueio)
Next

dw_2.SetRedraw(True)
dw_2.SetFocus()

ivm_Menu.mf_Confirmar(True)
ivm_Menu.mf_Cancelar(True)
ivb_Valida_Salva = True

Close(w_Aguarde)
SetPointer(Arrow!)
end event

type cb_2 from commandbutton within w_ge138_manutencao_estoque_base_geral
integer x = 2670
integer y = 632
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
	
	OpenWithParm(w_ge138_historico_alteracao, ls_Parametro)
	
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Selecione uma filial para visualizar o hist$$HEX1$$f300$$ENDHEX$$rico das~raltera$$HEX2$$e700f500$$ENDHEX$$es do estoque base.")
	Return
End If
end event

type dw_5 from dc_uo_dw_base within w_ge138_manutencao_estoque_base_geral
boolean visible = false
integer x = 2144
integer y = 336
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge138_lista_fat_conv_nao_divisivel"
end type

