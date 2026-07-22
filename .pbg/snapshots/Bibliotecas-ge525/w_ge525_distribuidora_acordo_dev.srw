HA$PBExportHeader$w_ge525_distribuidora_acordo_dev.srw
forward
global type w_ge525_distribuidora_acordo_dev from dc_w_cadastro_selecao_lista
end type
type cb_alterar from picturebutton within w_ge525_distribuidora_acordo_dev
end type
type gb_3 from groupbox within w_ge525_distribuidora_acordo_dev
end type
type cb_incluir_planilha from commandbutton within w_ge525_distribuidora_acordo_dev
end type
type cb_informa_lote from commandbutton within w_ge525_distribuidora_acordo_dev
end type
type cb_gerar_planilha from commandbutton within w_ge525_distribuidora_acordo_dev
end type
type dw_5 from dc_uo_dw_base within w_ge525_distribuidora_acordo_dev
end type
type dw_4 from dc_uo_dw_base within w_ge525_distribuidora_acordo_dev
end type
type dw_3 from dc_uo_dw_base within w_ge525_distribuidora_acordo_dev
end type
type cb_1 from commandbutton within w_ge525_distribuidora_acordo_dev
end type
type cb_2 from commandbutton within w_ge525_distribuidora_acordo_dev
end type
type gb_4 from groupbox within w_ge525_distribuidora_acordo_dev
end type
end forward

global type w_ge525_distribuidora_acordo_dev from dc_w_cadastro_selecao_lista
integer width = 4805
integer height = 2440
string title = "GE525 - Acordo de Devolu$$HEX2$$e700e300$$ENDHEX$$o por Distribuidora"
cb_alterar cb_alterar
gb_3 gb_3
cb_incluir_planilha cb_incluir_planilha
cb_informa_lote cb_informa_lote
cb_gerar_planilha cb_gerar_planilha
dw_5 dw_5
dw_4 dw_4
dw_3 dw_3
cb_1 cb_1
cb_2 cb_2
gb_4 gb_4
end type
global w_ge525_distribuidora_acordo_dev w_ge525_distribuidora_acordo_dev

type variables
uo_produto io_Produto
uo_Fornecedor ivo_Fornecedor

Boolean ib_Inclusao = False
end variables

forward prototypes
public function boolean wf_le_dados_planilha (string as_arquivo)
public function boolean wf_valida_distribuidora (string as_distribuidora, long al_linha)
public function boolean wf_valida_produto (long al_produto, long al_linha)
public function boolean wf_grava_lote (string as_distribuidora, long al_produto, string as_lote)
public subroutine wf_insere_motivo_default ()
public subroutine wf_insere_distribuidora_default ()
public function boolean wf_grava_produto (string as_distribuidora, long al_produto, string as_lote, long al_motivo)
public function boolean wf_valida_motivo (long al_motivo, long al_linha)
public function boolean wf_le_dados_arquivo (string as_arquivo)
end prototypes

public function boolean wf_le_dados_planilha (string as_arquivo);Any la_Dado

Boolean lb_Sucesso = False

Long ll_Linha
Long ll_Linhas
Long ll_Produto

String ls_Distribuidora
String ls_Lote
String ls_Motivo

dw_1.AcceptText()

dc_uo_excel lo_Excel
lo_Excel = Create dc_uo_excel

Open(w_Aguarde)
w_Aguarde.Title = "Importando Planilha..."

//Refer$$HEX1$$ea00$$ENDHEX$$ncia o arquivo 
If ( lo_Excel.uo_Referencia_Objeto_Excel(as_Arquivo) ) Then
	
	//C$$HEX1$$f300$$ENDHEX$$digo da filial
	ll_Linhas = lo_Excel.uo_Verifica_Tamanho_Arquivo("A")
	
	If ll_Linhas > 0 Then
		w_Aguarde.uo_Progress.of_SetMax(ll_Linhas)
		
		For ll_Linha = 1 To ll_Linhas
			w_Aguarde.uo_Progress.of_SetProgress(ll_Linha)
			
			ib_Inclusao = False
			
			//C$$HEX1$$f300$$ENDHEX$$digo da distribuidora
			la_Dado = lo_Excel.uo_Lendo_Dados(ll_Linha, "A")
			
			ls_Distribuidora = String(la_Dado)
			
			If LenA(ls_Distribuidora) = 8 Then
				ls_Distribuidora = String("0" + ls_Distribuidora)
			End If
			
			If Not wf_Valida_Distribuidora(ls_Distribuidora, ll_Linha) Then
				lb_Sucesso = False
				Exit
			End If

			//C$$HEX1$$f300$$ENDHEX$$digo do produto
			la_Dado = lo_Excel.uo_Lendo_Dados(ll_Linha, "B")
			
			If Not wf_Valida_Produto(Long(la_Dado), ll_Linha) Then
				lb_Sucesso = False
				Exit
			End If
							
			ll_Produto = Long(la_Dado)

			//Lote do Produto
			la_Dado = lo_Excel.uo_Lendo_Dados(ll_Linha, "C")
						
			If LenA(String(la_Dado)) > 15 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O Lote pode ter at$$HEX1$$e900$$ENDHEX$$ 15 caracteres.~rLinha: " + String(ll_Linha))
				lb_Sucesso = False
				Exit
			End If
			ls_Lote = String(la_Dado)
			ls_Lote = Upper(ls_Lote)
		
			
			//Codido do Motivo
			la_Dado = lo_Excel.uo_Lendo_Dados(ll_Linha, "D")
			
			If Not wf_valida_motivo(Long(la_Dado),ll_Linha) Then 
				lb_Sucesso = False
				Exit
			End If 	
			
			If LenA(String(la_Dado))=0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Codigo do Motivo Inv$$HEX1$$e100$$ENDHEX$$lido.~rLinha: " + String(ll_Linha))
				lb_Sucesso = False
				Exit
			End If			
			ls_Motivo =  String(la_Dado)  
				
	
			If Not wf_Grava_Produto(ls_Distribuidora, ll_Produto, ls_Lote, Long(ls_Motivo)) Then
				lb_Sucesso = False
				Exit
			Else
				lb_Sucesso = True
			End If			
		Next
		
		If lb_Sucesso Then
			Close(w_Aguarde)
			Destroy(lo_Excel)
			SqlCa.of_Commit();
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Registros inclu$$HEX1$$ed00$$ENDHEX$$dos com sucesso.")
			dw_2.Event ue_Retrieve()
			dw_2.SetFocus()
		Else
			Close(w_Aguarde)
			Destroy(lo_Excel)
			SqlCa.of_RollBack();
			Return False
		End If
	End If
End If

Return True
end function

public function boolean wf_valida_distribuidora (string as_distribuidora, long al_linha);Long ll_Achou

String ls_Erro

If Not IsNumber(as_Distribuidora) Or IsNull(as_Distribuidora) Then
	SqlCa.of_Rollback();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Distribuidora/Fornecedor inv$$HEX1$$e100$$ENDHEX$$lido.~rLinha: " + String(al_Linha), StopSign!)
	Return False
End If

Select Count(*)
	Into: ll_Achou
From fornecedor
Where cd_fornecedor = :as_Distribuidora
	And (id_situacao = 'A' Or id_situacao Is Null)
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SqlErrText
	SqlCa.of_Rollback();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar a Distribuidora/Fornecedor.~rLinha: " + String(al_Linha) + ".~r" + ls_Erro, StopSign!)
	Return False
End If

If ll_Achou = 0 Then
	SqlCa.of_Rollback();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Distribuidora/Fornecedor inv$$HEX1$$e100$$ENDHEX$$lido ou inativo.~rLinha " + String(al_Linha), StopSign!)
	Return False
Else
	Return True
End If
end function

public function boolean wf_valida_produto (long al_produto, long al_linha);Long ll_Achou

String ls_Erro

If Not IsNumber(String(al_Produto)) Or IsNull(al_Produto) Then
	SqlCa.of_Rollback();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto inv$$HEX1$$e100$$ENDHEX$$lido.~rLinha: " + String(al_Linha), StopSign!)
	Return False
End If

Select Count(*)
	Into: ll_Achou
From produto_geral
Where cd_produto = :al_Produto
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SqlErrText
	SqlCa.of_Rollback();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o produto.~rLinha: " + String(al_Linha) + ".~r" + ls_Erro, StopSign!)
	Return False
End If

If ll_Achou = 0 Then
	SqlCa.of_Rollback();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto inv$$HEX1$$e100$$ENDHEX$$lido.~rLinha: " + String(al_Linha), StopSign!)
	Return False
Else
	Return True
End If
end function

public function boolean wf_grava_lote (string as_distribuidora, long al_produto, string as_lote);Long ll_Achou

String ls_Erro

Select Count(*)
	Into :ll_Achou
From distribuidora_acordo_validade
Where cd_distribuidora = :as_Distribuidora
	And cd_produto = :al_Produto
	And nr_lote = :as_Lote
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SqlErrText
	SqlCa.of_Rollback();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao consultar se o lote [" + as_Lote + "] do produto [" + String(al_Produto) + "] e distribuidora [" + as_Distribuidora + "] tem acordo de devolu$$HEX2$$e700e300$$ENDHEX$$o.~r" + ls_Erro, StopSign!)
	Return False
End If

If ll_Achou = 0 Then
	Insert Into distribuidora_acordo_validade(cd_distribuidora, cd_produto, nr_lote, dh_inclusao, nr_matricula)
		Values(:as_Distribuidora, :al_Produto, :as_Lote, getdate(), :gvo_Aplicacao.ivo_Seguranca.Nr_Matricula)
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		ls_Erro = SqlCa.SqlErrText
		SqlCa.of_Rollback();
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao inserir o lote [" + as_Lote + "] do produto [" + String(al_Produto) + "] e distribuidora [" + as_Distribuidora + "].~r" + ls_Erro, StopSign!)
		Return False
	End If
	
	ib_Inclusao = True
	
	If Not gf_ge525_Revisao_Desconto_Preste(al_Produto, true) Then Return False
	
	
End If

Return True
end function

public subroutine wf_insere_motivo_default ();DataWindowChild lvdwc1

Integer lvi_Retorno,&
        lvi_Row

If dw_1.GetChild("cd_procedimento_acordo", lvdwc1) = 1 Then
	lvdwc1.InsertRow(1)
	
	//lvdwc1.SetItem(1, "cd_procedimento_acordo", 0)
	//lvdwc1.SetItem(1, "de_procedimento_acordo",   "SEM PROCEDIMENTO DEFINIDO")
	
	dw_1.Object.cd_procedimento_acordo[1] =0
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild do motivo acordo.")
End If
end subroutine

public subroutine wf_insere_distribuidora_default ();DataWindowChild lvdwc

Integer lvi_Retorno,&
        lvi_Row

If dw_1.GetChild("cd_distribuidora", lvdwc) = 1 Then
	lvdwc.InsertRow(1)
	
	lvdwc.SetItem(1, "cd_fornecedor", "000000000")
	lvdwc.SetItem(1, "nm_fantasia",   "TODAS")
	
	dw_1.Object.Cd_Distribuidora[1] = "000000000"
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild da distribuidora.")
End If
end subroutine

public function boolean wf_grava_produto (string as_distribuidora, long al_produto, string as_lote, long al_motivo);Long ll_Achou

String ls_Erro

Select Count(*)
	Into :ll_Achou
From distribuidora_acordo_devolucao
Where cd_distribuidora = :as_Distribuidora
	And cd_produto = :al_Produto
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SqlErrText
	SqlCa.of_Rollback();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar se o produto [" + String(al_Produto) + "] tem acordo de devolu$$HEX2$$e700e300$$ENDHEX$$o com a distribuidora [" + as_Distribuidora + "].", StopSign!)
	Return False
End If

If ll_Achou = 0 Then
	Insert Into distribuidora_acordo_devolucao(cd_distribuidora, cd_produto, dh_inclusao, nr_matricula, cd_procedimento_acordo)
		Values(:as_Distribuidora, :al_Produto, getdate(), :gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, :al_motivo   )
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		ls_Erro = SqlCa.SqlErrText
		SqlCa.of_Rollback();
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao inserir o produto [" + String(al_Produto) + "] e distribuidora [" + as_Distribuidora + "] no acordo de devolu$$HEX2$$e700e300$$ENDHEX$$o.~r" + ls_Erro, StopSign!)
		Return False
	End If
	
	ib_Inclusao = True
	
	// Historico de Inclusao
	If Not gf_Grava_Historico_Alteracao_Tabela('DISTRIBUIDORA_ACORDO_DEVOLUCAO',& 
									String(as_Distribuidora)+";"+String(al_Produto),&
									'CD_DISTRIBUIDORA', '0', String(al_motivo) ,&
									gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, "I",&
									Ref ls_Erro, True) Then Return False
	

	If Not gf_ge525_Revisao_Desconto_Preste(al_Produto, true) Then Return False
	
End If

If Not IsNull(as_Lote) And as_Lote <> "" Then
	If Not wf_Grava_Lote(as_Distribuidora, al_Produto, as_Lote) Then Return False
End If

Return True
end function

public function boolean wf_valida_motivo (long al_motivo, long al_linha);Long ll_Achou
String lvs_Erro 

If Not IsNumber(String(al_motivo)) Or IsNull(al_motivo) Then
	SqlCa.of_Rollback();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Motivo inv$$HEX1$$e100$$ENDHEX$$lido.~rLinha: " + String(al_Linha), StopSign!)
	Return False
End If


Select  count(*) 
Into :ll_Achou
From   distribuidora_proced_acordo
where cd_procedimento_acordo =:al_motivo
Using SqlCA;

If SqlCa.SqlCode = -1 Then
	lvs_Erro = SqlCa.SqlErrText
	SqlCa.of_Rollback();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o motivo.~rLinha: " + String(al_Linha) + ".~r" + lvs_Erro, StopSign!)
	Return False
End If

If ll_Achou = 0 Then
	SqlCa.of_Rollback();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Motivo inv$$HEX1$$e100$$ENDHEX$$lido.~rLinha: " + String(al_Linha), StopSign!)
	Return False
Else
	Return True
End If



end function

public function boolean wf_le_dados_arquivo (string as_arquivo);Any la_Dado
Long ll_Linha, ll_Linhas, ll_Index, ll_produto_sybase[], ll_for
String ls_produto, ls_produto_sap[], ls_where

dw_1.AcceptText()

Try
	dc_uo_excel lo_Excel
	lo_Excel = Create dc_uo_excel
	
	Open(w_Aguarde)
	w_Aguarde.Title = "Verificando a quantidade de registros da planilha..."
	
	// Refer$$HEX1$$ea00$$ENDHEX$$ncia o arquivo 
	If ( lo_Excel.uo_Referencia_Objeto_Excel(as_Arquivo) ) Then
		// Coluna de Refer$$HEX1$$ea00$$ENDHEX$$ncia
		ll_Linhas = lo_Excel.uo_Verifica_Tamanho_Arquivo("A") 
		
		If ll_Linhas > 0 Then
			w_Aguarde.uo_Progress.of_SetMax(ll_Linhas)
			
			ll_Index = 0
					
			For ll_Linha = 1 To ll_Linhas
				la_Dado = lo_Excel.uo_Lendo_Dados(ll_Linha, "A")
				
				ls_produto = gf_Tira_Zero_Esquerda(String(la_Dado))
				
				if Len(ls_produto) <= 6 then
					ll_produto_sybase[UpperBound(ll_produto_sybase) + 1] = Long(ls_produto)
				else
					ls_produto_sap[UpperBound(ls_produto_sap) + 1] = ls_produto
				end if
				
				w_Aguarde.Title = "Linha: " + String(ll_Linha) + " at$$HEX1$$e900$$ENDHEX$$ " + String(ll_Linhas)
				w_aguarde.uo_progress.of_setprogress(ll_Linha)
			Next
			
			if UpperBound(ll_produto_sybase) > 0 then
				ls_where = '( g.cd_produto in ('
				
				for ll_for = 1 to UpperBound(ll_produto_sybase)
					if ll_for = 1 then
						ls_where += String(ll_produto_sybase[ll_for])
					else
						ls_where += ' ,' + String(ll_produto_sybase[ll_for])
					end if
				next
				
				ls_where += '))'
			end if
			
			if UpperBound(ls_produto_sap) > 0 then
				if not isnull(ls_where) and trim(ls_where) <> '' then
					ls_where += ' or (g.cd_produto_sap in ('
				else
					ls_where = '(g.cd_produto_sap in ('
				end if
				
				for ll_for = 1 to UpperBound(ls_produto_sap)
					if ll_for = 1 then
						ls_where += " '" + ls_produto_sap[ll_for] + "'"
					else
						ls_where += " ,'" + ls_produto_sap[ll_for] + "'"
					end if
				next
				
				ls_where += '))'
			end if
			
			dw_2.of_AppendWhere (ls_where)
			dw_4.of_AppendWhere (ls_where)
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A planilha est$$HEX1$$e100$$ENDHEX$$ em branco.")
			Return False
		End If
	End If
Finally
	Close(w_Aguarde)
	If IsValid(lo_Excel) Then Destroy(lo_Excel)
End Try
end function

on w_ge525_distribuidora_acordo_dev.create
int iCurrent
call super::create
this.cb_alterar=create cb_alterar
this.gb_3=create gb_3
this.cb_incluir_planilha=create cb_incluir_planilha
this.cb_informa_lote=create cb_informa_lote
this.cb_gerar_planilha=create cb_gerar_planilha
this.dw_5=create dw_5
this.dw_4=create dw_4
this.dw_3=create dw_3
this.cb_1=create cb_1
this.cb_2=create cb_2
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_alterar
this.Control[iCurrent+2]=this.gb_3
this.Control[iCurrent+3]=this.cb_incluir_planilha
this.Control[iCurrent+4]=this.cb_informa_lote
this.Control[iCurrent+5]=this.cb_gerar_planilha
this.Control[iCurrent+6]=this.dw_5
this.Control[iCurrent+7]=this.dw_4
this.Control[iCurrent+8]=this.dw_3
this.Control[iCurrent+9]=this.cb_1
this.Control[iCurrent+10]=this.cb_2
this.Control[iCurrent+11]=this.gb_4
end on

on w_ge525_distribuidora_acordo_dev.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_alterar)
destroy(this.gb_3)
destroy(this.cb_incluir_planilha)
destroy(this.cb_informa_lote)
destroy(this.cb_gerar_planilha)
destroy(this.dw_5)
destroy(this.dw_4)
destroy(this.dw_3)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.gb_4)
end on

event ue_postopen;call super::ue_postopen;This.ivm_Menu.mf_Incluir (False)

wf_Insere_Distribuidora_Default ()

wf_insere_motivo_default () 
end event

event close;call super::close;If IsValid (io_Produto)     Then Destroy io_Produto
If IsValid (ivo_Fornecedor) Then Destroy ivo_Fornecedor
end event

event ue_preopen;call super::ue_preopen;io_Produto = Create uo_produto

//If gvo_Aplicacao.ivo_Seguranca.cd_Sistema = 'GC' Then
//	This.cb_incluir.Visible				= False
//	This.cb_incluir_planilha.Visible = False
//	This.cb_informa_lote.Visible 		= False
//	This.cb_alterar.Visible 			= False
//End If 
end event

event ue_cancel;call super::ue_cancel;dw_1.Object.Cd_Distribuidora [1] = '000000000'
dw_1.Enabled                     = True
end event

event ue_save;call super::ue_save;Long		ll_Linha,               &
			ll_Linhas_dw2,          &
			ll_Linhas_dw4,          &
			ll_Find,                &
			ll_Produto,             &
			ll_procedimento_acordo, &
			ll_achou,               &
			ll_novo_proced

String	ls_Distribuidora, &
			ls_Erro,          &
			ls_novo_proced, 	&
			ls_id_tipo

dw_2.AcceptText ()
ll_Linhas_dw2 = dw_2.RowCount ()
ll_Linhas_dw4 = dw_4.RowCount ()

Open (w_Aguarde)
w_Aguarde.Title = 'Salvando as Informa$$HEX2$$e700f500$$ENDHEX$$es...'

Try
	For ll_Linha = 1 To ll_Linhas_dw4	
		
		ls_Distribuidora = dw_4.Object.Cd_Distribuidora [ll_Linha]
		ll_Produto       = dw_4.Object.Cd_Produto       [ll_Linha]
		
		ll_Find = dw_2.Find ("cd_distribuidora = '" + ls_Distribuidora + "' and cd_produto = " + String (ll_Produto), 1, ll_Linhas_dw2)
			
		If ll_Find < 0 Then
			SQLCA.of_Rollback ()
			MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro no Find da dw_3.', StopSign!)
			Return -1
		End If
		
		//Registro foi exclu$$HEX1$$ed00$$ENDHEX$$do
		If ll_Find = 0 Then
			DELETE distribuidora_acordo_devolucao
			 WHERE cd_distribuidora = :ls_Distribuidora
				AND cd_produto       = :ll_Produto
			 USING SQLCA;
			
			If SQLCA.SQLCode = -1 Then
				ls_Erro = SQLCA.SQLErrText
				SQLCA.of_Rollback ()
				MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao exluir o produto [' + String (ll_Produto) + '] e distribuidora [' + ls_Distribuidora + '].~r' + ls_Erro, StopSign!)
				Return -1
			End If
			
			// Historico de Exclus$$HEX1$$e300$$ENDHEX$$o
			If Not gf_Grava_Historico_Alteracao_Tabela ('DISTRIBUIDORA_ACORDO_DEVOLUCAO', &
																	  String (ls_Distribuidora) + ';' + String (ll_Produto), &
																	  'CD_DISTRIBUIDORA', 'N', '', &
																	  gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'E', &
																	  Ref ls_Erro, True) Then Return -1
			
			DELETE distribuidora_acordo_validade
			 WHERE cd_distribuidora = :ls_Distribuidora
				AND cd_produto       = :ll_Produto
			 USING SQLCA;
			
			If SQLCA.SQLCode = -1 Then
				ls_Erro = SQLCA.SQLErrText
				SQLCA.of_Rollback ()
				MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao excluir o produto [' + String(ll_Produto) + '] e distribuidora [' + ls_Distribuidora + '].~r' + ls_Erro, StopSign!)
				Return -1
			End If
			
			If Not gf_ge525_Revisao_Desconto_Preste (ll_Produto, false) Then
				MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao atualizar atualiza desconto prestes para loja')
				Return -1
			End If
			
			// Historico de Exclus$$HEX1$$e300$$ENDHEX$$o
			If Not gf_Grava_Historico_Alteracao_Tabela ('DISTRIBUIDORA_ACORDO_VALIDADE', & 
																	  String (ls_Distribuidora) + ';' + String (ll_Produto), &
																	  'CD_DISTRIBUIDORA', 'N', '', &
																	  gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'E', &
																	  Ref ls_Erro, True) Then Return -1
		End If
	Next
	
	//Outro for para salvar a dw_2
	For ll_Linha = 1 To ll_Linhas_dw2
		w_Aguarde.uo_progress.of_setmax (ll_Linhas_dw2)
		
		ls_id_tipo = dw_1.Object.id_tipo[1]
		
		If ls_id_tipo = "P" Then
			If gf_Houve_Alteracao_DW (dw_2, 'DE_PROCEDIMENTO_ACORDO', ll_Linha, Ref ls_novo_proced) Then
				
				ls_Distribuidora       = dw_2.Object.Cd_Distribuidora       [ll_Linha]
				ll_Produto             = dw_2.Object.Cd_Produto             [ll_Linha]
				ll_procedimento_acordo = dw_2.Object.cd_procedimento_acordo [ll_linha]
				
				If IsNull (ll_procedimento_acordo) then
					ll_procedimento_acordo = 0
				End if
				
				ll_novo_proced = Long (ls_novo_proced)
				
				If ll_procedimento_acordo <> ll_novo_proced Then
					
					UPDATE distribuidora_acordo_devolucao
						SET cd_procedimento_acordo = :ll_novo_proced
					 WHERE cd_distribuidora = :ls_distribuidora
						AND cd_produto       = :ll_produto
					 USING SQLCA;
					
					If SQLCA.SQLCode = -1 Then
						ls_Erro = SQLCA.SQLErrText
						SQLCA.of_Rollback ()
						MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao Atualizar o procedimento de acordo. Produto [' + String(ll_Produto) + '] tem acordo com a distribuidora [' + ls_Distribuidora + '].', StopSign!)
						Return -1
					End If
				End If
			End if
		End if
	Next
	SQLCA.of_Commit ()
	
	dw_1.Enabled = True
	
	ivm_Menu.mf_Confirmar (False)
	ivm_Menu.mf_Cancelar  (False)
	
	dw_2.Event ue_Retrieve ()
	dw_3.Event ue_Retrieve ()
	dw_4.Event ue_Retrieve ()
	
Finally
	Close (w_Aguarde)
End try

Return AncestorReturnValue
end event

event open;call super::open;ivo_Fornecedor = Create uo_Fornecedor
end event

type dw_visual from dc_w_cadastro_selecao_lista`dw_visual within w_ge525_distribuidora_acordo_dev
integer x = 155
integer y = 852
end type

type gb_aux_visual from dc_w_cadastro_selecao_lista`gb_aux_visual within w_ge525_distribuidora_acordo_dev
integer x = 123
integer y = 780
end type

type dw_1 from dc_w_cadastro_selecao_lista`dw_1 within w_ge525_distribuidora_acordo_dev
integer y = 76
integer width = 2002
integer height = 412
string dataobject = "dw_ge525_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;dw_2.Event ue_Reset()
dw_3.Event ue_Reset()
dw_4.Event ue_Reset()

Choose Case dwo.Name
	Case "de_produto"
		If Not IsNull(Data) and Data <> "" Then
			If Data <> io_Produto.ivs_Descricao_Apresentacao_Venda Then
				Return 1
			End If
			
		Else
			io_Produto.of_Inicializa()
			
			This.Object.Cd_Produto[1] = io_Produto.Cd_Produto
			This.Object.De_Produto[1] = io_Produto.ivs_Descricao_Apresentacao_Venda
		End If
	
	Case "nm_fornecedor"
		If Trim(Data) <> "" Then
			If Data <> ivo_fornecedor.nm_Fantasia Then
				Return 1
			End If	
		Else			
			
			ivo_fornecedor.of_Inicializa()
			
			This.Object.Cd_Fornecedor		[1] = ivo_fornecedor.Cd_Fornecedor
			This.Object.Nm_Fornecedor		[1] = ivo_fornecedor.Nm_Fantasia			
		End If
		
	Case "id_distr_forn"
		ivo_fornecedor.of_Inicializa()
		This.Object.Cd_Fornecedor		[1] = ""
		This.Object.Nm_Fornecedor		[1] = ""
		dw_1.Object.Cd_Distribuidora[1] = "000000000"

		dw_1.Modify('id_tipo.values="'+iif(Data='F',"Fornecedor", "Distribuidora")+'	D/Produto	P/"')
		
End Choose
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "de_produto"
					
			io_Produto.of_Localiza_Produto(Upper(This.GetText()))
						
			If io_Produto.Localizado Then
				This.Object.Cd_Produto[1] = io_Produto.Cd_Produto
				This.Object.De_Produto[1] = io_Produto.ivs_Descricao_Apresentacao_Venda
			End If
			
		Case "nm_fornecedor"
	
			ivo_fornecedor.of_Localiza_Fornecedor(Upper(This.GetText()))
			
			If ivo_fornecedor.Localizado Then
				This.Object.Cd_fornecedor	[1] = ivo_fornecedor.Cd_Fornecedor
				This.Object.Nm_fornecedor	[1] = ivo_fornecedor.Nm_Fantasia
				This.Object.Cd_Distribuidora[1] = This.Object.Cd_fornecedor	[1]
			End If
			
	End Choose
End If
end event

event dw_1::editchanged;call super::editchanged;dw_2.Event ue_Reset()
dw_3.Event ue_Reset()
dw_4.Event ue_Reset()
end event

type gb_2 from dc_w_cadastro_selecao_lista`gb_2 within w_ge525_distribuidora_acordo_dev
integer y = 576
integer width = 4704
integer height = 1136
string text = "Produto"
end type

type gb_1 from dc_w_cadastro_selecao_lista`gb_1 within w_ge525_distribuidora_acordo_dev
integer width = 3730
integer height = 564
end type

type dw_2 from dc_w_cadastro_selecao_lista`dw_2 within w_ge525_distribuidora_acordo_dev
integer y = 652
integer width = 4631
integer height = 1040
string dataobject = "dw_ge525_lista_distribuidora"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Dw

dw_1.AcceptText ()

If dw_1.GetItemString(1, 'Id_Tipo') = 'D' Then
	lvs_Dw = 'dw_ge525_lista_produto'
Else
	lvs_Dw = 'dw_ge525_lista_distribuidora'
End If

If This.DataObject <> lvs_Dw Then
	If Not dw_2.of_ChangeDataObject(lvs_Dw) Then
		MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', "Erro no change data object da dw '" + lvs_Dw + "'.", StopSign!)
		Return 1
	End If
	
	This.of_SetRowSelection()
	This.GroupCalc()
End If

If lvs_Dw = "dw_ge525_lista_distribuidora" And gvo_Aplicacao.ivo_Seguranca.cd_Sistema = "GC" Then
    dw_2.Modify("de_procedimento_acordo.Protect = '1'")
End If

//Deixar os appendwheres iguais no preretrieve na dw_4 e dw_5
If dw_1.Object.Cd_Distribuidora [1] <> '000000000' Then
	This.of_AppendWhere ("d.cd_distribuidora = '" + dw_1.Object.Cd_Distribuidora [1] + "'")
End If

If Not IsNull (dw_1.Object.Cd_Produto [1]) And dw_1.Object.Cd_Produto [1] > 0 Then
	This.of_AppendWhere ('d.cd_produto = ' + String (dw_1.Object.Cd_Produto [1]))
End If

If dw_1.Object.cd_procedimento_acordo [1] > 0 Then
	This.of_AppendWhere ('d.cd_procedimento_acordo = ' + String (dw_1.Object.cd_procedimento_acordo [1]))	
End If 	

This.of_AppendWhere ("COALESCE (f.id_distribuidora, 'N') = '" + iif (dw_1.GetItemString (1, 'id_distr_forn') = 'D', 'S', 'N') + "'")

Return 1
end event

event dw_2::rowfocuschanged;call super::rowfocuschanged;If CurrentRow > 0 Then
	dw_3.Event ue_Retrieve()
End If
end event

event dw_2::constructor;call super::constructor;ivi_Tipo_Cancelar = RETRIEVE
end event

event dw_2::ue_postretrieve;//OverRide

Boolean lvb_Classificar, &
        lvb_Filtrar, &
		  lvb_Localizar, &
		  lvb_Excluir

If pl_Linhas > 0 Then
	lvb_Classificar = IsValid (This.ivo_Sort)
	lvb_Filtrar     = IsValid (This.ivo_Filter)
	lvb_Localizar   = IsValid (This.ivo_Find)
	
	lvb_Excluir = False

	This.SetRow  (1)
	This.SetFocus ()	
	dw_4.Event ue_Retrieve()
	
Else
	If pl_Linhas = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!)
	End If
End If

Parent.ivm_Menu.mf_Classificar (lvb_Classificar)
Parent.ivm_Menu.mf_Filtrar     (lvb_Filtrar)
Parent.ivm_Menu.mf_Localizar   (lvb_Localizar)
Parent.ivm_Menu.mf_Incluir     (lvb_Excluir)

Return pl_Linhas
end event

event dw_2::doubleclicked;call super::doubleclicked;Long		ll_for
String 	ls_Retorno, ls_id_selecionado


Choose Case String(dwo.name)
	Case 'st_distrib_selec'
		if dw_2.RowCount() > 0 then
			ls_id_selecionado = dw_2.GetItemString(1, 'id_selecionado')
		
			if ls_id_selecionado = 'N' then 
				ls_id_selecionado = 'S'
			else
				ls_id_selecionado = 'N'
			end if
			
			for ll_for = 1 to dw_2.RowCount()
				dw_2.SetItem(ll_for, 'id_selecionado', ls_id_selecionado)
			next
		end if
	Case Else
		If dw_2.RowCount() > 0 Then
		
			str_ge525_parametro st
			
			st.Cd_Produto	= dw_2.Object.Cd_Produto[dw_2.GetRow()]
			st.De_Produto	= dw_2.Object.De_Produto[dw_2.GetRow()]
			st.Id_Tipo		= "A"
			
			OpenWithParm(w_ge525_inclui_altera_distribuidora, st)
			
			ls_Retorno = Message.StringParm
			
			If ls_Retorno = "OK" Then
				dw_2.Event ue_Retrieve()
			End If
		End If
End Choose
end event

event dw_2::getfocus;call super::getfocus;Parent.ivm_Menu.mf_Incluir(False)
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
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum registro foi selecionado para ser exclu$$HEX1$$ed00$$ENDHEX$$do.")
	Return False
End If

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a exclus$$HEX1$$e300$$ENDHEX$$o do(s) registro(s) selecionado(s)?", Question!, YesNo!, 2) = 2 Then Return False

Do While ll_Find > 0
		
	ls_Selecionado = This.Object.Id_Selecionado	[ll_Find]
	ll_Produto		= This.Object.Cd_Produto		[ll_Find]	
	
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
//			If ivb_UpdateAble Then
//				ivw_ParentWindow.ivb_Valida_Salva = True
//			End If
			
			lvb_Retorno = True
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao excluir o registro.", StopSign!)
			Return False
		End If
	End If
	
	ll_Find = This.Find("id_selecionado = 'S'", 1, This.RowCount())
Loop

dw_1.Enabled = False

Return lvb_Retorno
end event

event dw_2::itemchanged;//OverRide

Choose Case dwo.Name
	Case 'de_procedimento_acordo'
		If gvo_Aplicacao.ivo_Seguranca.cd_Sistema <> 'GC' Then
			Parent.ivm_Menu.mf_Confirmar(True)
			Parent.ivm_Menu.mf_Cancelar(True)
		End If
End Choose
end event

event dw_2::editchanged;//OverRide
end event

event dw_2::buttonclicked;call super::buttonclicked;String lvs_Parametro
String lvs_Produto
String lvs_Distribuidora

lvs_Produto       = String (dw_2.Object.cd_produto       [row])
lvs_Distribuidora = String (dw_2.Object.cd_distribuidora [row])

lvs_Parametro	   = lvs_Distribuidora + ';' + lvs_Produto

OpenWithParm(w_ge525_historico_acordos, lvs_Parametro)
end event

type cb_alterar from picturebutton within w_ge525_distribuidora_acordo_dev
integer x = 2674
integer y = 1924
integer width = 370
integer height = 116
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\botao_alterar.png"
alignment htextalign = left!
long backcolor = 67108864
end type

event clicked;String ls_Retorno

dw_2.AcceptText()

If dw_2.RowCount() > 0 Then
	
	str_ge525_parametro st
	
	st.Cd_Produto = dw_2.Object.Cd_Produto[dw_2.GetRow()]
	st.De_Produto = dw_2.Object.De_Produto[dw_2.GetRow()]
	
	OpenWithParm(w_ge525_inclui_altera_lote, st)
	
	ls_Retorno = Message.StringParm
	
	If ls_Retorno = "OK" Then
		dw_3.Event ue_Retrieve()
	End If
End If
end event

type gb_3 from groupbox within w_ge525_distribuidora_acordo_dev
integer x = 37
integer y = 1728
integer width = 2464
integer height = 484
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Acordo por Lote/Validade"
end type

type cb_incluir_planilha from commandbutton within w_ge525_distribuidora_acordo_dev
integer x = 3890
integer y = 360
integer width = 773
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Incluir Via Planilha"
end type

event clicked;Integer li_Retorno

String ls_Arquivo
String ls_Nome

dw_1.AcceptText()

MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o',  'Os dados devem estar da seguinte forma: ~r'         + &
								'~rColuna A = C$$HEX1$$f300$$ENDHEX$$digo da Distribuidora ou Fornecedor' + &
								'~rColuna B = C$$HEX1$$f300$$ENDHEX$$digo do Produto'                     + &
								'~rColuna C = Lote (se houver)'                      + &
								'~rColuna D = C$$HEX1$$f300$$ENDHEX$$digo Motivo Acordo') 
				
li_Retorno = GetFileOpenName('Seleciona o arquivo', + ls_Arquivo, ls_Nome, 'XLSX', 'Excel 2007 (*.XLSX),*.XLSX, Excel (*.XLS), *.XLS')

If li_Retorno = 1 Then
	If MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Confirma a inclus$$HEX1$$e300$$ENDHEX$$o via planilha?', Question!, YesNo!, 2) = 2 Then
		Return -1
	End If
		
	If Not wf_Le_Dados_Planilha(ls_Arquivo) Then
		Return -1
	End If
End If
end event

type cb_informa_lote from commandbutton within w_ge525_distribuidora_acordo_dev
integer x = 3890
integer y = 160
integer width = 773
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Informa Lote"
end type

event clicked;OpenWithParm(w_ge525_distrib_informa_lote, "")
end event

type cb_gerar_planilha from commandbutton within w_ge525_distribuidora_acordo_dev
integer x = 3890
integer y = 260
integer width = 773
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Gerar Planilha"
end type

event clicked;dw_5.Event ue_Retrieve()
end event

type dw_5 from dc_uo_dw_base within w_ge525_distribuidora_acordo_dev
boolean visible = false
integer x = 3355
integer y = 1328
integer width = 594
integer height = 272
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "dw_5"
string dataobject = "ds_ge525_planilha"
end type

event ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	This.Event ue_SaveAs()
End If

Return pl_Linhas
end event

event ue_preretrieve;call super::ue_preretrieve;dw_1.AcceptText ()

If dw_1.Object.Cd_Distribuidora [1] <> '000000000' Then
	This.of_AppendWhere ("d.cd_distribuidora = '" + dw_1.Object.Cd_Distribuidora [1] + "'")
End If

If Not IsNull (dw_1.Object.Cd_Produto [1]) And dw_1.Object.Cd_Produto [1] > 0 Then
	This.of_AppendWhere ('d.cd_produto = ' + String (dw_1.Object.Cd_Produto [1]))
End If

If dw_1.Object.cd_procedimento_acordo [1] > 0 Then
	This.of_AppendWhere ('d.cd_procedimento_acordo = ' + String (dw_1.Object.cd_procedimento_acordo [1]))	
End If 	

This.of_AppendWhere ("COALESCE (f.id_distribuidora, 'N') = '" + iif (dw_1.GetItemString (1, 'id_distr_forn') = 'D', 'S', 'N') + "'")

Return 1
end event

type dw_4 from dc_uo_dw_base within w_ge525_distribuidora_acordo_dev
boolean visible = false
integer x = 2720
integer y = 1328
integer width = 594
integer height = 272
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "dw_4"
string dataobject = "dw_ge525_lista_distribuidora"
end type

event ue_preretrieve;call super::ue_preretrieve;dw_1.AcceptText ()

If dw_1.Object.Cd_Distribuidora [1] <> '000000000' Then
	This.of_AppendWhere ("d.cd_distribuidora = '" + dw_1.Object.Cd_Distribuidora [1] + "'")
End If

If Not IsNull (dw_1.Object.Cd_Produto [1]) And dw_1.Object.Cd_Produto [1] > 0 Then
	This.of_AppendWhere ('d.cd_produto = ' + String (dw_1.Object.Cd_Produto [1]))
End If

If dw_1.Object.cd_procedimento_acordo [1] > 0 Then
	This.of_AppendWhere ('d.cd_procedimento_acordo = ' + String (dw_1.Object.cd_procedimento_acordo [1]))	
End If 	

This.of_AppendWhere ("COALESCE (f.id_distribuidora, 'N') = '" + iif (dw_1.GetItemString (1, 'id_distr_forn') = 'D', 'S', 'N') + "'")

Return 1
end event

type dw_3 from dc_uo_dw_base within w_ge525_distribuidora_acordo_dev
integer x = 91
integer y = 1776
integer width = 2373
integer height = 408
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge525_lote"
boolean vscrollbar = true
end type

event ue_recuperar;//OverRide

dw_2.AcceptText ()

If dw_2.RowCount () > 0 Then
	Return This.Retrieve (dw_2.Object.Cd_Distribuidora [dw_2.GetRow ()], dw_2.Object.Cd_Produto [dw_2.GetRow ()])
Else
	Return 0
End If
end event

event constructor;call super::constructor;This.of_SetRowSelection()
end event

type cb_1 from commandbutton within w_ge525_distribuidora_acordo_dev
integer x = 3890
integer y = 464
integer width = 773
integer height = 88
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Filtrar Produtos Via Planilha"
end type

event clicked;Int		li_Retorno
Long		ll_linhas
String	ls_Arquivo, ls_Nome


MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Os dados devem estar da seguinte forma:~r~r" + &
							+ "Coluna A = C$$HEX1$$f300$$ENDHEX$$digo de Produto SAP ou Sybase")

li_Retorno = GetFileOpenName("Seleciona o arquivo", ls_Arquivo, ls_Nome, "XLSX", "Excel 2007 (*.XLSX),*.XLSX, Excel (*.XLS), *.XLS")

If li_Retorno = 1 Then
	dw_2.of_RestoreOriginalSQL()
	wf_le_dados_arquivo(ls_Arquivo)
	ll_linhas = dw_2.Retrieve()
	
	if ll_linhas > 0 then
		ivm_Menu.mf_SalvarComo(true)
	else
		ivm_Menu.mf_SalvarComo(false)
	end if
	
	dw_4.Retrieve()
End If
end event

type cb_2 from commandbutton within w_ge525_distribuidora_acordo_dev
integer x = 3890
integer y = 60
integer width = 773
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Incluir"
end type

event clicked;String ls_Retorno

str_ge525_parametro st

st.Id_Tipo = "I"

OpenWithParm(w_ge525_inclui_altera_distribuidora, st)

ls_Retorno = Message.StringParm

If ls_Retorno = "OK" Then
	dw_2.Event ue_Retrieve()
End If
end event

type gb_4 from groupbox within w_ge525_distribuidora_acordo_dev
integer x = 3794
integer width = 942
integer height = 572
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 67108864
string text = "A$$HEX2$$e700f500$$ENDHEX$$es"
borderstyle borderstyle = styleraised!
end type

