HA$PBExportHeader$w_ge138_altera_estoque_base_via_excel.srw
forward
global type w_ge138_altera_estoque_base_via_excel from dc_w_response_ok_cancela
end type
type cb_selecionar from commandbutton within w_ge138_altera_estoque_base_via_excel
end type
end forward

global type w_ge138_altera_estoque_base_via_excel from dc_w_response_ok_cancela
integer width = 2350
integer height = 840
string title = "GE138 - Atualiza$$HEX2$$e700e300$$ENDHEX$$o do Estoque Base via Excel"
long backcolor = 80269524
cb_selecionar cb_selecionar
end type
global w_ge138_altera_estoque_base_via_excel w_ge138_altera_estoque_base_via_excel

type variables
uo_filial ivo_filial

Boolean ib_Novo_Eb = False

Date ivdt_bloqueio
Date ivdt_Movimentacao

Long ivl_Filial

String ivs_varias_filiais
String is_Produtos_Novos
String is_reduz_eb
String is_responsavel
end variables

forward prototypes
public function boolean wf_importa ()
public function boolean wf_atualiza_estoque_base (long al_produto, long al_estoque_base)
public function boolean wf_fator_conversao (long al_produto, ref decimal adc_fator_conversao)
public function boolean wf_atualiza_filial ()
public function boolean wf_atualiza_filiais ()
public function boolean wf_atualiza_estoque_base (long al_filial, long al_produto, long al_estoque_base)
public function boolean wf_localiza_filial (long al_filial)
public function boolean wf_localiza_produto (long al_produto)
public function boolean wf_verifica_novo_eb (long al_filial)
end prototypes

public function boolean wf_importa ();Boolean lvb_Retorno

If ivs_Varias_Filiais = "S" Then
	lvb_Retorno = wf_Atualiza_Filiais()
Else
	lvb_Retorno = wf_Atualiza_Filial()
End If

Return lvb_Retorno
end function

public function boolean wf_atualiza_estoque_base (long al_produto, long al_estoque_base);// Est$$HEX1$$e100$$ENDHEX$$ fazendo update na coluna qt_estoque_base_inicial para for$$HEX1$$e700$$ENDHEX$$ar a atualiza$$HEX2$$e700e300$$ENDHEX$$o
// do log de exporta$$HEX2$$e700e300$$ENDHEX$$o

Long ll_EB_Atual

String ls_Nulo
String ls_Motivo

SetNull(ls_Nulo)

dw_1.AcceptText()

ls_Motivo = dw_1.Object.De_Motivo_Alteracao[1]

If is_reduz_eb = 'S' Then
	
	Select coalesce(qt_estoque_base, 0)
	Into :ll_EB_Atual
	From resumo_reposicao_estoque
	Where cd_filial   =:ivl_Filial
		  and cd_produto =:al_Produto 
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do EB da filial.")
		Return False
	End If
	
	If SqlCa.SqlCode = 0 Then
		// S$$HEX1$$f300$$ENDHEX$$ vai atualizar se o EB atual for menor que o novo
		If ll_EB_Atual > al_Estoque_Base Then
			Return True
		End If
	End If	
	
End If

If IsNull(ivdt_bloqueio) Then
	If is_Produtos_Novos = 'S' Then
		Update resumo_reposicao_estoque
		Set qt_estoque_base_inicial = :al_Estoque_Base,
			qt_estoque_base 	    =:al_Estoque_Base, 
			nr_matricula_alteracao  =:gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 
			id_alteracao 		    = 'M',
			dh_alteracao 		    = getdate(),
			dh_termino_bloqueio     = :ivdt_Bloqueio,
			de_motivo_alteracao = :ls_Motivo
		Where cd_filial  =:ivl_Filial
		  and cd_produto =:al_Produto 
		Using SqlCa;
	Else
		Update resumo_reposicao_estoque
		Set qt_estoque_base_inicial = qt_estoque_base_inicial,
			qt_estoque_base 	    =:al_Estoque_Base, 
			nr_matricula_alteracao  =:gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 
			id_alteracao 		    = 'M',
			dh_alteracao 		    = getdate(),
			dh_termino_bloqueio     = :ivdt_Bloqueio,
			de_motivo_alteracao = :ls_Motivo
		Where cd_filial  =:ivl_Filial
		  and cd_produto =:al_Produto 
		Using SqlCa;
	End If
Else
	
	Update resumo_reposicao_estoque
	Set qt_estoque_base_inicial = qt_estoque_base_inicial,
		qt_estoque_base 	    =:al_Estoque_Base, 
		nr_matricula_alteracao  =:gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 
		id_alteracao 		    = 'M',
		dh_alteracao 		    = getdate(),
		dh_termino_bloqueio     = :ivdt_Bloqueio,
		de_motivo_alteracao	= :ls_Motivo
	Where cd_filial  =:ivl_Filial
	  and cd_produto =:al_Produto 
	Using SqlCa;
End If

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do estoque base da filial nova.")
	Return False
End If
		
Return True
end function

public function boolean wf_fator_conversao (long al_produto, ref decimal adc_fator_conversao);Select vl_fator_conversao
Into :adc_Fator_Conversao
From produto_geral
Where cd_produto =:al_Produto
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Erro ao localizar o fator de convers$$HEX1$$e300$$ENDHEX$$o.")
	Return False
End If

If SqlCa.SqlCode = 100 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O fator de convers$$HEX1$$e300$$ENDHEX$$o do produto n$$HEX1$$e300$$ENDHEX$$o foi localizado.")
	Return False
End If

Return True
end function

public function boolean wf_atualiza_filial ();Boolean lvb_Sucesso = True

Any lva_Dado

Decimal{2} lvdc_Fator_Conversao

String	lvs_Arquivo

Long lvl_Linhas,&
	 lvl_Linha,&
	 lvl_Produto,&
	 lvl_Estoque_Base

dw_1.AcceptText()

lvs_Arquivo = dw_1.Object.nm_arquivo[1]

dc_uo_excel lvo_Excel
lvo_Excel = Create dc_uo_excel

Open(w_Aguarde)
w_Aguarde.Title = "Atualizando o estoque base da filial '" + String(ivl_Filial) + "' ..."

// Refer$$HEX1$$ea00$$ENDHEX$$ncia o arquivo 
If ( lvo_Excel.uo_Referencia_Objeto_Excel(lvs_Arquivo) ) Then
	// Coluna de Refer$$HEX1$$ea00$$ENDHEX$$ncia
	lvl_Linhas = lvo_Excel.uo_Verifica_Tamanho_Arquivo("A") 
	
	If lvl_Linhas > 0 Then
		w_Aguarde.uo_Progress.of_SetMax(lvl_Linhas)
		
		For lvl_Linha = 1 To lvl_Linhas
							
			// Produto
			lva_Dado    = lvo_Excel.uo_Lendo_Dados(lvl_Linha, "A")
									
			If ClassName(lva_Dado) <> "double" Then
				SqlCa.of_RollBack();
				Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto inv$$HEX1$$e100$$ENDHEX$$lido '" + String(lva_Dado) + "' na linha '" +&
								   	  String(lvl_Linha) + "'.", StopSign!)
				lvb_Sucesso = False
				Exit
			End If
						
			lvl_Produto = Long(lva_Dado)
			
			// Verifica se o produto $$HEX1$$e900$$ENDHEX$$ v$$HEX1$$e100$$ENDHEX$$lido
			If Not wf_Localiza_Produto(lvl_Produto) Then
				lvb_Sucesso = False
				Exit
			End If
			
			// Estoque base			
			lva_Dado = lvo_Excel.uo_Lendo_Dados(lvl_Linha, "B")
			
			If ClassName(lva_Dado) <> "double" Then
				SqlCa.of_RollBack();
				Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Estoque base inv$$HEX1$$e100$$ENDHEX$$lido '" + String(lva_Dado) + "' na linha '" +&
				String(lvl_Linha) + "'.", StopSign!)
				lvb_Sucesso = False
				Exit
			End If
						
			lvl_Estoque_Base = Long(lva_Dado)
			
			If IsNull(lvl_Estoque_Base) or lvl_Estoque_Base < 0 Then lvl_Estoque_Base = 0
			
			If Not wf_Fator_Conversao(lvl_Produto, Ref lvdc_Fator_Conversao) Then
				lvb_Sucesso = False
				Exit
			End If
			
			If Mod(lvl_Estoque_Base, lvdc_Fator_Conversao) <> 0 Then
				SqlCa.of_RollBack();
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O estoque base '" + String(lvl_Estoque_Base) + "' do produto '" +&
								      String(lvl_Produto) + "' n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ divis$$HEX1$$ed00$$ENDHEX$$vel pelo fator de convers$$HEX1$$e300$$ENDHEX$$o '" +&
									  String(lvdc_Fator_Conversao) + "'.")
				lvb_Sucesso = False
				Exit
			End If
			
			If Not wf_Atualiza_Estoque_Base(ivl_Filial,lvl_Produto, lvl_Estoque_Base) Then
				lvb_Sucesso = False
				Exit
			End If
															
			w_Aguarde.uo_Progress.of_SetProgress(lvl_Linha)
		Next
	  
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A planilha n$$HEX1$$e300$$ENDHEX$$o possui nenhuma linha.")
		lvb_Sucesso = False
	End If
End If

Close(w_Aguarde)

Destroy(lvo_Excel)

Return lvb_Sucesso
end function

public function boolean wf_atualiza_filiais ();Boolean lvb_Sucesso = True

Any lva_Dado

Decimal{2} lvdc_Fator_Conversao

String lvs_Arquivo

Long lvl_Linhas,&
	 lvl_Linha,&
	 lvl_Produto,&
	 lvl_Estoque_Base,&
	 lvl_Filial

dw_1.AcceptText()

lvs_Arquivo = dw_1.Object.nm_arquivo[1]

dc_uo_excel lvo_Excel
lvo_Excel = Create dc_uo_excel

Open(w_Aguarde)
w_Aguarde.Title = "Atualizando o estoque base das filiais..."

// Refer$$HEX1$$ea00$$ENDHEX$$ncia o arquivo 
If ( lvo_Excel.uo_Referencia_Objeto_Excel(lvs_Arquivo) ) Then
	// Coluna de Refer$$HEX1$$ea00$$ENDHEX$$ncia
	lvl_Linhas = lvo_Excel.uo_Verifica_Tamanho_Arquivo("A") 
	
	If lvl_Linhas > 0 Then
		w_Aguarde.uo_Progress.of_SetMax(lvl_Linhas)
		
		For lvl_Linha = 1 To lvl_Linhas
			
			// Filial
			lva_Dado    = lvo_Excel.uo_Lendo_Dados(lvl_Linha, "A")
									
			If ClassName(lva_Dado) <> "double" Then
				Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Filial inv$$HEX1$$e100$$ENDHEX$$lida '" + String(lva_Dado) + "' na linha '" +&
								   	  String(lvl_Linha) + "'.", StopSign!)
				lvb_Sucesso = False
				Exit
			End If
			lvl_Filial = Long(lva_Dado)
						
			// Verifica se a filial $$HEX1$$e900$$ENDHEX$$ v$$HEX1$$e100$$ENDHEX$$lida
			If Not wf_Localiza_Filial(lvl_Filial) Then
				lvb_Sucesso = False
				Exit
			End If
									
			// Produto
			lva_Dado    = lvo_Excel.uo_Lendo_Dados(lvl_Linha, "B")
									
			If ClassName(lva_Dado) <> "double" Then
				SqlCa.of_RollBack();
				Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto inv$$HEX1$$e100$$ENDHEX$$lido '" + String(lva_Dado) + "' na linha '" +&
								   	  String(lvl_Linha) + "'.", StopSign!)
				lvb_Sucesso = False
				Exit
			End If
			lvl_Produto = Long(lva_Dado)
			
			// Verifica se o produto $$HEX1$$e900$$ENDHEX$$ v$$HEX1$$e100$$ENDHEX$$lido
			If Not wf_Localiza_Produto(lvl_Produto) Then
				lvb_Sucesso = False
				Exit
			End If
			
			// Estoque base			
			lva_Dado = lvo_Excel.uo_Lendo_Dados(lvl_Linha, "C")
			
			If ClassName(lva_Dado) <> "double" Then
				SqlCa.of_RollBack();
				Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Estoque base inv$$HEX1$$e100$$ENDHEX$$lido '" + String(lva_Dado) + "' na linha '" +&
				String(lvl_Linha) + "'.", StopSign!)
				lvb_Sucesso = False
				Exit
			End If
			lvl_Estoque_Base = Long(lva_Dado)
			
			If IsNull(lvl_Estoque_Base) or lvl_Estoque_Base < 0 Then lvl_Estoque_Base = 0
			
			If Not wf_Fator_Conversao(lvl_Produto, Ref lvdc_Fator_Conversao) Then
				lvb_Sucesso = False
				Exit
			End If
			
			If Mod(lvl_Estoque_Base, lvdc_Fator_Conversao) <> 0 Then
				SqlCa.of_RollBack();
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O estoque base '" + String(lvl_Estoque_Base) + "' do produto '" +&
								      String(lvl_Produto) + "' n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ divis$$HEX1$$ed00$$ENDHEX$$vel pelo fator de convers$$HEX1$$e300$$ENDHEX$$o '" +&
									  String(lvdc_Fator_Conversao) + "'.")
				lvb_Sucesso = False
				Exit
			End If
			
			If Not wf_Atualiza_Estoque_Base(lvl_Filial, lvl_Produto, lvl_Estoque_Base) Then
				lvb_Sucesso = False
				Exit
			End If
															
			w_Aguarde.uo_Progress.of_SetProgress(lvl_Linha)
		Next
	  
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A planilha n$$HEX1$$e300$$ENDHEX$$o possui nenhuma linha.")
		lvb_Sucesso = False
	End If
End If

Close(w_Aguarde)

Destroy(lvo_Excel)

Return lvb_Sucesso
end function

public function boolean wf_atualiza_estoque_base (long al_filial, long al_produto, long al_estoque_base);// Est$$HEX1$$e100$$ENDHEX$$ fazendo update na coluna qt_estoque_base_inicial para for$$HEX1$$e700$$ENDHEX$$ar a atualiza$$HEX2$$e700e300$$ENDHEX$$o
// do log de exporta$$HEX2$$e700e300$$ENDHEX$$o

Long ll_EB_Atual

String ls_Nulo
String ls_Motivo

dw_1.AcceptText()

ls_Motivo = dw_1.Object.De_Motivo_Alteracao[1]

SetNull(ls_Nulo)

If is_reduz_eb = 'N' Then
	
	Select coalesce(qt_estoque_base, 0)
	Into :ll_EB_Atual
	From resumo_reposicao_estoque
	Where cd_filial  =:al_Filial
		  and cd_produto =:al_Produto 
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do EB da filial.")
		Return False
	End If
	
	If SqlCa.SqlCode = 0 Then
		// S$$HEX1$$f300$$ENDHEX$$ vai atualizar se o EB atual for menor que o novo
		If ll_EB_Atual > al_Estoque_Base Then
			Return True
		End If
	End If
End If

If is_Produtos_Novos = 'S' Then
//	If Not ib_Novo_Eb Then
//		Update resumo_reposicao_estoque
//		Set qt_estoque_base_inicial = :al_Estoque_Base,
//			qt_estoque_base 	    =:al_Estoque_Base, 
//			nr_matricula_alteracao  =:is_responsavel, 
//			id_alteracao 		    = 'M',
//			dh_alteracao 		    = getdate(),
//			dh_termino_bloqueio     = :ivdt_Bloqueio,
//			de_motivo_alteracao = :ls_Nulo
//		Where cd_filial  =:al_Filial
//		  and cd_produto =:al_Produto 
//		Using SqlCa;
//
//	Else

		Update resumo_reposicao_estoque
		Set qt_estoque_base_inicial = :al_Estoque_Base,
			qt_estoque_base 	    =:al_Estoque_Base, 
			nr_matricula_alteracao  =:is_responsavel, 
			id_alteracao 		    = 'M',
			dh_alteracao 		    = getdate(),
			dh_termino_bloqueio     = :ivdt_Bloqueio,
			de_motivo_alteracao = :ls_Motivo
		Where cd_filial  =:al_Filial
		  and cd_produto =:al_Produto 
		Using SqlCa;
//	End If
End If

If is_Produtos_Novos = 'N' Then
//	If Not ib_Novo_Eb Then
//		Update resumo_reposicao_estoque
//		Set qt_estoque_base_inicial = qt_estoque_base_inicial,
//			qt_estoque_base 	    =:al_Estoque_Base, 
//			nr_matricula_alteracao  =:is_responsavel, 
//			id_alteracao 		    = 'M',
//			dh_alteracao 		    = getdate(),
//			dh_termino_bloqueio     = :ivdt_Bloqueio,
//			de_motivo_alteracao = :ls_Nulo
//		Where cd_filial  =:al_Filial
//		  and cd_produto =:al_Produto 
//		Using SqlCa;
//		
//	Else
		
		Update resumo_reposicao_estoque
		Set qt_estoque_base_inicial = qt_estoque_base_inicial,
			qt_estoque_base 	    =:al_Estoque_Base, 
			nr_matricula_alteracao  =:is_responsavel, 
			id_alteracao 		    = 'M',
			dh_alteracao 		    = getdate(),
			dh_termino_bloqueio     = :ivdt_Bloqueio,
			de_motivo_alteracao = :ls_Motivo
		Where cd_filial  =:al_Filial
		  and cd_produto =:al_Produto 
		Using SqlCa;
//	End If
End If

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do estoque base da filial nova.")
	Return False
End If
		
Return True
end function

public function boolean wf_localiza_filial (long al_filial);Long lvl_Filial

Select cd_filial
Into :lvl_Filial
From filial
Where cd_filial =:al_Filial
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Filial n$$HEX1$$e300$$ENDHEX$$o cadastrada '" + String(al_Filial) + ".")
		Return False
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da Filial.")
End Choose

Return True



end function

public function boolean wf_localiza_produto (long al_produto);Long lvl_Produto
Date ldt_Termino_Avaliacao

Select	cd_produto,
		dh_termino_avaliacao
Into	:lvl_Produto,
		:ldt_Termino_Avaliacao
From produto_geral
Where cd_produto =:al_Produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If is_Produtos_Novos = 'S' Then
			If ivdt_Movimentacao >= ldt_Termino_Avaliacao Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Per$$HEX1$$ed00$$ENDHEX$$odo de avalia$$HEX2$$e700e300$$ENDHEX$$o do produto '" + String(lvl_Produto) + "' j$$HEX1$$e100$$ENDHEX$$ encerrado." + &
				"~rO estoque base n$$HEX1$$e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ ser alterado.", Exclamation!)
				Return False
			End If
		End If
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto n$$HEX1$$e300$$ENDHEX$$o cadastrado '" + String(al_Produto) + ".")
		Return False
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da Filial.")
End Choose

Return True

end function

public function boolean wf_verifica_novo_eb (long al_filial);String ls_Parametro

Select vl_parametro
	Into :ls_Parametro
From parametro_loja
Where cd_parametro = 'ID_UTILIZA_NOVO_CALCULO_ESTOQUE_BASE'
	And cd_filial = :al_Filial
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If ls_Parametro = "S" Then
			ib_Novo_Eb = True
		Else
			ib_Novo_Eb = False
		End If
		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado o par$$HEX1$$e200$$ENDHEX$$metro 'id_utiliza_novo_calculo_estoque_base' da tabela 'parametro_geral'. Filial '" + String(al_Filial) + "'.", Exclamation!)
		Return False
		
	Case -1
		SqlCa.of_MsgdbError("Erro na localizacao do par$$HEX1$$e200$$ENDHEX$$metro id_utiliza_novo_calculo_estoque_base da parametro_geral. Filial " + String(al_Filial) + "'")
		Return False
End Choose

Return True
end function

on w_ge138_altera_estoque_base_via_excel.create
int iCurrent
call super::create
this.cb_selecionar=create cb_selecionar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_selecionar
end on

on w_ge138_altera_estoque_base_via_excel.destroy
call super::destroy
destroy(this.cb_selecionar)
end on

event close;call super::close;Destroy(ivo_Filial)
end event

event ue_postopen;call super::ue_postopen;ivo_Filial = Create uo_Filial
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge138_altera_estoque_base_via_excel
integer x = 37
integer y = 16
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge138_altera_estoque_base_via_excel
integer width = 2277
integer height = 612
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge138_altera_estoque_base_via_excel
integer x = 46
integer y = 56
integer width = 2245
integer height = 540
integer taborder = 50
string dataobject = "dw_ge138_selecao_arquivo"
end type

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	
	If This.GetColumnName() = "nm_filial" Then
				
		ivo_Filial.of_Localiza_Filial(This.GetText())
		
		If ivo_Filial.Localizada Then
			dw_1.Object.nm_filial[1] = ivo_Filial.nm_fantasia
			dw_1.Object.cd_filial[1] = ivo_Filial.cd_filial
			cb_selecionar.Enabled    = True
		Else
			ivo_Filial.of_Inicializa()

			dw_1.Object.cd_filial[1] = ivo_Filial.cd_filial
			dw_1.Object.nm_filial[1] = ivo_Filial.nm_fantasia
			
			cb_selecionar.Enabled    = False
		End If
	End If
End If
end event

event dw_1::itemchanged;call super::itemchanged;Date lvdt_Nulo

String lvs_Nulo

Long lvl_Dias_Bloqueio

SetNull(lvs_Nulo)
SetNull(lvdt_Nulo)

This.AcceptText()

If This.GetColumnName() = "nm_filial" Then
	If Not IsNull(Data) and Trim(Data) <> "" Then
		If Data <> ivo_Filial.nm_fantasia Then
			Return 1
		End If
	Else
		ivo_Filial.of_Inicializa()
		
		dw_1.Object.cd_filial[1] = ivo_Filial.cd_filial
		dw_1.Object.nm_filial[1] = ivo_Filial.nm_fantasia
	End If
End If

If This.GetColumnName() = "id_varias_filiais" Then
	If Data = "S" Then
		ivo_Filial.of_Inicializa()
			
		dw_1.Object.cd_filial[1] = ivo_Filial.cd_filial
		dw_1.Object.nm_filial[1] = ivo_Filial.nm_fantasia
		
		dw_1.Object.nm_filial.Protect 	= 1
		cb_selecionar.Enabled			= True
	Else
		dw_1.Object.nm_filial.Protect	= 0
		cb_selecionar.Enabled			= False
	End If
	
//	dw_1.Object.de_motivo_alteracao[1]     = lvs_Nulo
End If

If This.GetColumnName() <> "de_motivo_alteracao" And This.GetColumnName() <> "qt_dias_bloqueio" Then
	cb_ok.Enabled						= False
	dw_1.Object.nm_arquivo[1]     = lvs_Nulo
End If

If This.GetColumnName() = "id_produto_novo" Then
	If Data = 'S' Then
		dw_1.Object.Qt_Dias_Bloqueio	[1]		= 0
		dw_1.Object.dh_bloqueio		[1]		= lvdt_Nulo
		ivdt_Bloqueio = lvdt_Nulo
		
		dw_1.Object.Qt_Dias_Bloqueio.Protect	= 1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Esta op$$HEX2$$e700e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ somente para atualiza$$HEX2$$e700e300$$ENDHEX$$o de produtos novos.", Exclamation!)
	Else
		dw_1.Object.Qt_Dias_Bloqueio.Protect	= 0
	End If
End If

If This.GetColumnName() = "id_reduz_eb" Then
	If Data = 'N' Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O estoque base N$$HEX1$$c300$$ENDHEX$$O SER$$HEX1$$c100$$ENDHEX$$ REDUZIDO.~r~r" +&
						"O sistema ir$$HEX1$$e100$$ENDHEX$$ atualizar somente onde o estoque base novo for maior que o atual.", Exclamation!)
	End If
End If

ivdt_Movimentacao = Date(gvo_Parametro.of_Dh_Movimentacao())

If This.GetColumnName() = "qt_dias_bloqueio" Then
	
	lvl_Dias_Bloqueio = dw_1.Object.qt_dias_bloqueio[1]
	
	If lvl_Dias_Bloqueio > 0 Then
		If lvl_Dias_Bloqueio <= 365 Then
			ivdt_bloqueio 			   = RelativeDate(ivdt_Movimentacao, lvl_Dias_Bloqueio)
			dw_1.Object.dh_bloqueio[1] = ivdt_bloqueio
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O n$$HEX1$$fa00$$ENDHEX$$mero dias bloqueados n$$HEX1$$e300$$ENDHEX$$o pode maior que 365 dias.")
			Return 1
		End If
	Else
		ivdt_Bloqueio = lvdt_Nulo
	End If
End If
end event

event dw_1::losefocus;call super::losefocus;//If IsValid(ivo_Filial) Then
//	dw_1.Object.cd_filial	[1] = ivo_Filial.cd_filial
//	dw_1.Object.nm_filial	[1] = ivo_Filial.nm_fantasia
//End If
end event

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

event dw_1::editchanged;call super::editchanged;String ls_Nulo

SetNull(ls_Nulo)

If dwo.Name = "nm_filial" Then
	This.Object.Nm_Arquivo[1] = ls_Nulo
End If
end event

event dw_1::doubleclicked;//OverRide
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge138_altera_estoque_base_via_excel
integer x = 1623
integer y = 632
integer width = 325
boolean enabled = false
string text = "&Alterar"
boolean default = false
end type

event cb_ok::clicked;call super::clicked;Date lvdt_Nulo

Long lvl_Dias_Bloqueio

String	lvs_Arquivo, &
	   	lvs_MSG, &
	   	lvs_MSG2, &
		ls_Motivo

dw_1.AcceptText()

SetNull(lvdt_Nulo)
ib_Novo_Eb = False

ivl_Filial				= dw_1.Object.cd_filial					[1]
lvs_Arquivo			= dw_1.Object.nm_arquivo				[1]
lvl_Dias_Bloqueio	= dw_1.Object.qt_dias_bloqueio		[1]
is_reduz_eb			= dw_1.Object.id_reduz_eb				[1]
ls_Motivo				= dw_1.Object.De_Motivo_Alteracao	[1]

is_responsavel =  gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
	
If lvl_Dias_Bloqueio <= 0 Then
	ivdt_Bloqueio = lvdt_Nulo
End If

If IsNull(lvs_Arquivo) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione o arquivo a ser importado.")
	dw_1.SetFocus()
	Return
End If

If IsNull(ls_Motivo) Or Trim(ls_Motivo) = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o motivo da altera$$HEX2$$e700e300$$ENDHEX$$o.")
	dw_1.Event ue_Pos(1, "de_motivo_alteracao")
	Return
End If

If ivs_Varias_Filiais = "N" Then
	If IsNull(ivl_Filial) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a filial.")
		dw_1.Event ue_Pos(1, "nm_filial")
		dw_1.SetFocus()
		Return
	End If
	lvs_MSG2 = "Confirma a altera$$HEX2$$e700e300$$ENDHEX$$o do estoque base da filial '" + String(ivl_Filial) + "' ?"
Else
	lvs_MSG2 = "Confirma a altera$$HEX2$$e700e300$$ENDHEX$$o do estoque base das filiais ?"
End If

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_MSG2, Question!, YesNo!, 1) = 1 Then
	If wf_Importa() Then
		If ivs_Varias_Filiais = "S" Then
			lvs_MSG = "O estoque base das filiais foram atualizados com sucesso."
		Else
			lvs_MSG = "O estoque base da filial '" + String(ivl_Filial) + "' foi atualizado com sucesso."
		End If
		
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_MSG)
		SqlCa.of_Commit();
		dw_1.Event ue_Reset()
		dw_1.Event ue_AddRow()
		cb_ok.Enabled = False
	Else
		SqlCa.of_RollBack();
	End If
End If
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge138_altera_estoque_base_via_excel
integer x = 1979
integer y = 632
integer width = 325
end type

type cb_selecionar from commandbutton within w_ge138_altera_estoque_base_via_excel
integer x = 914
integer y = 632
integer width = 640
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
string text = "&Selecionar Arquivo"
end type

event clicked;String lvs_Arquivo,&
	   lvs_Nome,&
	   lvs_Nulo

Integer lvi_Retorno 

dw_1.AcceptText()

ivs_Varias_Filiais	= dw_1.Object.id_varias_filiais		[1]
is_Produtos_Novos	= dw_1.Object.Id_Produto_Novo	[1]

If ivs_Varias_Filiais = "S" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Os Dados devem estar da seguinte forma:~r~r" + &
			  		 "Coluna A = Filial~r"     + &
					 "Coluna B = Produto~r"    + &
					 "Coluna C = Estoque Base~r")
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Os Dados devem estar da seguinte forma:~r~r" + &
                     	 "Coluna A = Produto~r"     + &
					 	 "Coluna B = Estoque Base~r")
End If

lvi_Retorno = GetFileOpenName("Seleciona o arquivo", + lvs_Arquivo, lvs_Nome, "XLS", "Excel (*.XLS),*.XLS,")

If lvi_Retorno = 1 Then 
	dw_1.Object.nm_arquivo[1] = Upper(lvs_Arquivo)
	cb_ok.Enabled = True
Else
	SetNull(lvs_Nulo)
	dw_1.Object.nm_arquivo[1] = lvs_Nulo
	cb_ok.Enabled = False
End If
end event

