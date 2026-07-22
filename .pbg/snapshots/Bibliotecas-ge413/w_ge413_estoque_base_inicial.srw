HA$PBExportHeader$w_ge413_estoque_base_inicial.srw
forward
global type w_ge413_estoque_base_inicial from dc_w_sheet
end type
type gb_1 from groupbox within w_ge413_estoque_base_inicial
end type
type dw_1 from dc_uo_dw_base within w_ge413_estoque_base_inicial
end type
type cb_cancelar from commandbutton within w_ge413_estoque_base_inicial
end type
type cb_confirma from commandbutton within w_ge413_estoque_base_inicial
end type
type pb_selecao from picturebutton within w_ge413_estoque_base_inicial
end type
end forward

global type w_ge413_estoque_base_inicial from dc_w_sheet
integer width = 1943
integer height = 876
string title = "GE413 - Estoque Base para Filial Nova"
long backcolor = 80269524
gb_1 gb_1
dw_1 dw_1
cb_cancelar cb_cancelar
cb_confirma cb_confirma
pb_selecao pb_selecao
end type
global w_ge413_estoque_base_inicial w_ge413_estoque_base_inicial

type variables
uo_filial ivo_filial_origem
uo_filial ivo_filial_destino
uo_promocao ivo_promocao

long ivl_Filial_Base
long ivl_Filial_Nova

integer ivl_log

string ivs_Promocao
string ivs_responsavel
string ivs_tipo_atualizacao
string ivs_arquivo_log

datetime ivdt_alteracao

dc_uo_ds_base ivds_Atualizacao
end variables

forward prototypes
public function boolean wf_copia_estoque_base ()
public function boolean wf_zera_estoque_base ()
public function boolean wf_atualiza_parametro_reposicao_estoque ()
public function boolean wf_importa_arquivo_excel ()
public function boolean wf_valida_informacoes ()
public function boolean wf_atualiza_mix_produto ()
public function boolean wf_fator_conversao (long al_produto, ref decimal adc_fator_conversao)
public function boolean wf_atualiza_estoque_base (long al_produto, long al_estoque_base)
public function boolean wf_inclui_loja_promocao (integer filial_base, integer filial_nova)
public function boolean wf_verifica_consistencia (integer pi_filial_base, integer pi_filial_nova)
public function boolean wf_abre_arquivo_log ()
public subroutine wf_grava_log (string as_mensagem)
public function boolean wf_parametros_novo_eb ()
public function boolean wf_perfil_estoque (ref long al_perfil)
public function boolean wf_inclui_saldo_produto ()
public function boolean wf_atualiza_saldo_inicial (string as_dh_saldo)
end prototypes

public function boolean wf_copia_estoque_base ();Boolean lvb_Sucesso = True

Long lvl_Linhas,&
	 lvl_Linha,&
	 lvl_Produto,&
	 lvl_Estoque_Base

dc_uo_ds_base lvds_Base

lvds_Base = Create dc_uo_ds_base

If Not lvds_Base.of_ChangeDataObject("ds_ge413_estoque_base") Then
	Destroy(lvds_Base)
	Return False
End If

lvds_Base.Retrieve(ivl_Filial_Base)

lvl_Linhas = lvds_Base.RowCount()

Open(w_Aguarde)

w_Aguarde.Title = "Atualizando o estoque base ..."

If lvl_Linhas > 0 Then
	
	w_Aguarde.uo_Progress.of_SetMax(lvl_Linhas)
		
	For lvl_Linha = 1 To lvl_Linhas
		
		w_Aguarde.uo_Progress.of_SetProgress(lvl_Linha)
		
		lvl_Produto 	 = lvds_Base.Object.cd_produto	   [lvl_Linha]
		lvl_Estoque_Base = lvds_Base.Object.qt_estoque_base[lvl_Linha]
		
		// Verificar Filial/Produto Vacina liberada para Loja
		If Not gf_parametro_filial_vacina(ivl_Filial_Nova,lvl_Produto) Then 
			lvb_Sucesso = False
			Exit
		End If 		
		
		
		If Not wf_atualiza_estoque_base(lvl_Produto, lvl_Estoque_Base) Then
			lvb_Sucesso = False
		End If
		
//		Update resumo_reposicao_estoque
//		Set qt_estoque_base 	   =:lvl_Estoque_Base, 
//			nr_matricula_alteracao =:ivs_Responsavel, 
//			id_alteracao 		   = 'M',
//			dh_alteracao 		   = getdate(),
//			dh_termino_bloqueio    = null
//		Where cd_filial  =:ivl_Filial_Nova
//		  and cd_produto =:lvl_Produto 
//		Using SqlCa;
//		
//		If SqlCa.SqlCode = -1 Then
//			SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do estoque base da filial nova.")
//			lvb_Sucesso = False
//		End If
		
		If Not lvb_Sucesso Then Exit
	Next
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", StopSign!)
	lvb_Sucesso = False
End If

Close(w_Aguarde)

Destroy(lvds_Base)

Return lvb_Sucesso
end function

public function boolean wf_zera_estoque_base ();Open(w_Aguarde)
w_Aguarde.Title = "Zerando o EB da filial nova ..."

update resumo_reposicao_estoque
Set qt_estoque_base 	   = 0, 
	nr_matricula_alteracao = :ivs_Responsavel, 
	id_alteracao 	   	   = 'M', 
	dh_alteracao 		   = getdate(),
	dh_termino_bloqueio    = null
Where cd_filial =:ivl_Filial_Nova
Using SqlCa;

If Sqlca.SqlCode = -1 Then 
	SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do estoque base da filial nova")
	Close(w_Aguarde)
	Return False
End If

SqlCa.of_Commit();

Close(w_Aguarde)

Return True
end function

public function boolean wf_atualiza_parametro_reposicao_estoque ();Integer lvi_Count 

Date lvdt_Proximo_Recalculo


Open(w_Aguarde)
w_Aguarde.Title = "Atualizando o par$$HEX1$$e200$$ENDHEX$$metro reposi$$HEX2$$e700e300$$ENDHEX$$o de estoque ..."

// Isso $$HEX1$$e900$$ENDHEX$$ para garantir que o sistema N$$HEX1$$c300$$ENDHEX$$O efetue o rec$$HEX1$$e100$$ENDHEX$$lculo da filial NOVA,
// pois pode existir algum rec$$HEX1$$e100$$ENDHEX$$lculo j$$HEX1$$e100$$ENDHEX$$ programado para filial BASE
lvdt_Proximo_Recalculo = Date("31/12/2099")

Select Count(*)
Into :lvi_Count
From parametro_reposicao_estoque
Where cd_filial =:ivl_Filial_Nova
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro reposicao da filial nova.")
	Close(w_Aguarde)
	Return False
Else
	If lvi_Count = 0 Then
		
		Insert Into parametro_reposicao_estoque ( cd_filial,   
												  id_tipo_reposicao,   
												  dh_inicio_periodo_1,   
												  dh_termino_periodo_1,   
												  vl_peso_periodo_1,   
												  dh_inicio_periodo_2,   
												  dh_termino_periodo_2,   
												  vl_peso_periodo_2,   
												  dh_inicio_periodo_3,   
												  dh_termino_periodo_3,   
												  vl_peso_periodo_3,   
												  dh_inicio_periodo_4,   
												  dh_termino_periodo_4,   
												  vl_peso_periodo_4,   
												  dh_inicio_periodo_5,   
												  dh_termino_periodo_5,   
												  vl_peso_periodo_5,   
												  dh_inicio_periodo_6,   
												  dh_termino_periodo_6,   
												  vl_peso_periodo_6,   
												  id_periodos_atualizados,   
												  dh_proximo_calculo,   
												  id_reduz_estoque_base,
												  dh_termino_calculo,
												  dh_inicio_calculo)  
 		Select :ivl_Filial_Nova,   
			   id_tipo_reposicao,   
			   dh_inicio_periodo_1,   
			   dh_termino_periodo_1,   
			   vl_peso_periodo_1,   
			   dh_inicio_periodo_2,   
			   dh_termino_periodo_2,   
			   vl_peso_periodo_2,   
			   dh_inicio_periodo_3,   
			   dh_termino_periodo_3,   
			   vl_peso_periodo_3,   
			   dh_inicio_periodo_4,   
			   dh_termino_periodo_4,   
			   vl_peso_periodo_4,   
			   dh_inicio_periodo_5,   
			   dh_termino_periodo_5,   
			   vl_peso_periodo_5,   
			   dh_inicio_periodo_6,   
			   dh_termino_periodo_6,   
			   vl_peso_periodo_6,   
			   id_periodos_atualizados,   
			   :lvdt_Proximo_Recalculo,   
				'N',
				getdate(),
				dateadd(day, -1, cast(getdate() as date))
	   From parametro_reposicao_estoque
	   Where cd_filial =:ivl_Filial_Base
	   Using SqlCa;
	   
	   If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgDbError("Inclus$$HEX1$$e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro de reposi$$HEX2$$e700e300$$ENDHEX$$o de estoque da filial nova.")
			Close(w_Aguarde)
			Return False
	   End If
	End If
End If

SqlCa.of_Commit();

Close(w_Aguarde)

Return True
end function

public function boolean wf_importa_arquivo_excel ();Boolean lvb_Sucesso = True

Any lva_Dado

Decimal{2} lvdc_Fator_Conversao

String lvs_Arquivo

Long lvl_Linhas,&
	 lvl_Linha,&
	 lvl_Produto,&
	 lvl_Estoque_Base

dw_1.AcceptText()

lvs_Arquivo = dw_1.Object.nm_arquivo[1]

dc_uo_excel lvo_Excel

lvo_Excel = Create dc_uo_excel

Open(w_Aguarde)
w_Aguarde.Title = "Atualizando o estoque base via arquivo excel ..."

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
				Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto inv$$HEX1$$e100$$ENDHEX$$lido '" + String(lva_Dado) + "' na linha '" +&
								   	  String(lvl_Linha) + "'.", StopSign!)
				lvb_Sucesso = False
				Exit
			End If
						
			lvl_Produto = Long(lva_Dado)
			
			// Verificar Filial/Produto Vacina liberada para Loja
			If Not gf_parametro_filial_vacina(ivl_Filial_Nova,lvl_Produto) Then 
				lvb_Sucesso = False
				Exit
			End If 		

			// Estoque base			
			lva_Dado = lvo_Excel.uo_Lendo_Dados(lvl_Linha, "B")
			
			If ClassName(lva_Dado) <> "double" Then
				Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Estoque base inv$$HEX1$$e100$$ENDHEX$$lido '" + String(lva_Dado) + "' na linha '" +&
				String(lvl_Linha) + "'.", StopSign!)
				lvb_Sucesso = False
				Exit
			End If
						
			lvl_Estoque_Base = Long(lva_Dado)
			
			If IsNull(lvl_Estoque_Base) or lvl_Estoque_Base < 0 Then lvl_Estoque_Base = 0
			
			If lvl_Estoque_Base = 0 Then
				w_Aguarde.uo_Progress.of_SetProgress(lvl_Linha)
				Continue				
			End If
			
			If Not wf_Fator_Conversao(lvl_Produto, Ref lvdc_Fator_Conversao) Then
				lvb_Sucesso = False
				Exit
			End If
			
			If Mod(lvl_Estoque_Base, lvdc_Fator_Conversao) <> 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O estoque base '" + String(lvl_Estoque_Base) + "' do produto '" + String(lvl_Produto) + "' n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ divis$$HEX1$$ed00$$ENDHEX$$vel pelo fator de convers$$HEX1$$e300$$ENDHEX$$o '" + String(lvdc_Fator_Conversao) + "'.")
				lvb_Sucesso = False
				Exit
			End If
			
			If Not wf_Atualiza_Estoque_Base(lvl_Produto, lvl_Estoque_Base) Then
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

public function boolean wf_valida_informacoes ();String lvs_Arquivo

dw_1.AcceptText()

lvs_Arquivo = dw_1.Object.nm_arquivo[1]

If IsNull(ivl_Filial_Base) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a filial base.")
	dw_1.Event ue_Pos(1, "nm_filial_base")
	dw_1.SetFocus()
	Return False
End If

If IsNull(ivl_Filial_Nova) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a filial nova.")
	dw_1.Event ue_Pos(1, "nm_filial_nova")
	dw_1.SetFocus()
	Return False
End If

If ivl_Filial_Nova = ivl_Filial_Base Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A filial base n$$HEX1$$e300$$ENDHEX$$o pode ser igual a nova.")
	dw_1.Event ue_Pos(1, "nm_filial_base")
	dw_1.SetFocus()
	Return False
End If

If IsNull(ivs_Tipo_Atualizacao) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o tipo de atualiza$$HEX2$$e700e300$$ENDHEX$$o do estoque base.")
	dw_1.Event ue_Pos(1, "id_tipo_atualizacao")
	dw_1.SetFocus()
	Return False
End If

If ivs_Tipo_Atualizacao = "EX" Then
	If IsNull(lvs_Arquivo) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o arquivo para atualiza$$HEX2$$e700e300$$ENDHEX$$o do estoque base.")
		pb_selecao.SetFocus()
		Return False
	End If
End If

Return True
end function

public function boolean wf_atualiza_mix_produto ();Open(w_Aguarde)
w_Aguarde.Title = "Atualizando o mix de produto da filial ..."

// Exclui o mix da filial NOVA que n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ na filial BASE
Delete From mix_produto_filial
Where cd_filial = :ivl_Filial_Nova
  and cd_mix_produto not in (Select cd_mix_produto from mix_produto_filial
		   			     	  Where cd_filial = :ivl_Filial_Base)
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Erro ao excluir o mix da filial NOVA.")
	Close(w_Aguarde)
	Return False
Else
	// Inclui o mix da filial BASE na NOVA
	Insert Into mix_produto_filial (cd_filial, 
									cd_mix_produto)
	Select :ivl_Filial_Nova,
		   cd_mix_produto
	From mix_produto_filial m1
	Where m1.cd_filial = :ivl_Filial_Base
	  and not exists (Select * from mix_produto_filial m2
					  Where m2.cd_filial =:ivl_Filial_Nova
						and m1.cd_mix_produto = m2.cd_mix_produto)
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgDbError("Erro ao incluir o mix da filial NOVA.")
		Close(w_Aguarde)
		Return False
	End If
End If

SqlCa.of_Commit()

Close(w_Aguarde)

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

public function boolean wf_atualiza_estoque_base (long al_produto, long al_estoque_base);Long lvl_Find

Date lvdt_Nulo

SetNull(lvdt_Nulo)

lvl_Find = ivds_Atualizacao.Find("cd_produto = " + String(al_Produto), 1, ivds_Atualizacao.RowCount())

ivdt_Alteracao = gf_GetServerDate()

If lvl_Find > 0 Then
	ivds_Atualizacao.Object.qt_estoque_base			[lvl_Find] = al_Estoque_Base
	ivds_Atualizacao.Object.nr_matricula_alteracao	[lvl_Find] = ivs_Responsavel
	ivds_Atualizacao.Object.dh_alteracao					[lvl_Find] = ivdt_Alteracao
	ivds_Atualizacao.Object.id_alteracao					[lvl_Find] = "M"
	ivds_Atualizacao.Object.dh_termino_bloqueio		[lvl_Find] = lvdt_Nulo
	ivds_Atualizacao.Object.qt_estoque_base_inicial	[lvl_Find] = ivds_Atualizacao.Object.qt_estoque_base_inicial[lvl_Find]
Else
	If lvl_Find = 0 Then
		wf_Grava_Log( "Produto '" + String(al_Produto) + "' n$$HEX1$$e300$$ENDHEX$$o localizado para a atualiza$$HEX2$$e700e300$$ENDHEX$$o do EB.")
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o produto '" + String(al_Produto) + "' para a atualiza$$HEX2$$e700e300$$ENDHEX$$o.")
		Return False
	End If
End If
		
Return True
end function

public function boolean wf_inclui_loja_promocao (integer filial_base, integer filial_nova);Long lvl_cd_promocao_sos 

String lvs_nm_promocao_sos

DateTime lvdt_dh_inicio     ,&
         lvdt_dh_termino
			
If ivs_Promocao = 'S' Then
	
	Open(w_Aguarde)
	w_Aguarde.Title = "Incluindo a filial na promo$$HEX2$$e700e300$$ENDHEX$$o da filial base ..."
		
	// Promo$$HEX2$$e700f500$$ENDHEX$$es futuras
	Insert Into promocao_sos_filial (cd_promocao_sos, cd_filial)
	select p1.cd_promocao_sos, 
			 :Filial_Nova  
	from promocao_sos p1, parametro p2, promocao_sos_filial f
	where p1.dh_inicio > p2.dh_movimentacao
	  and p1.cd_promocao_sos = f.cd_promocao_sos
	  and f.cd_filial = :filial_base
	  and p1.id_tipo_promocao <> 'P' // 17/02/2015 -> n$$HEX1$$e300$$ENDHEX$$o ir$$HEX1$$e100$$ENDHEX$$ mais pegar as promo$$HEX2$$e700f500$$ENDHEX$$es de planograma
	  and p1.cd_promocao_sos not in (select p1.cd_promocao_sos
												  from promocao_sos p1, parametro p2, promocao_sos_filial f
												 where p1.dh_inicio > p2.dh_movimentacao
													and p1.cd_promocao_sos = f.cd_promocao_sos
													and f.cd_filial = :filial_nova)
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgdbError("N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel gravar as promo$$HEX2$$e700f500$$ENDHEX$$es futuras")
		Close(w_Aguarde)
		Return False	
	End If	
	
	Insert Into promocao_sos_filial (cd_promocao_sos, cd_filial)
	select p1.cd_promocao_sos, 
			 :Filial_Nova  
	from promocao_sos p1, parametro p2, promocao_sos_filial f
	where p1.dh_inicio <= p2.dh_movimentacao
	  and (p1.dh_termino is null or p1.dh_termino >= p2.dh_movimentacao) 
	  and p1.cd_promocao_sos = f.cd_promocao_sos
	  and f.cd_filial = :filial_base
	  and p1.id_tipo_promocao <> 'P' // 17/02/2015 -> n$$HEX1$$e300$$ENDHEX$$o ir$$HEX1$$e100$$ENDHEX$$ mais pegar as promo$$HEX2$$e700f500$$ENDHEX$$es de planograma
	  and p1.cd_promocao_sos not in (select p1.cd_promocao_sos
												  from promocao_sos p1, parametro p2, promocao_sos_filial f
												 where p1.dh_inicio <= p2.dh_movimentacao
													and (p1.dh_termino is null or p1.dh_termino >= p2.dh_movimentacao) 
													and p1.cd_promocao_sos = f.cd_promocao_sos
													and f.cd_filial = :filial_nova);
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgdbError("N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel gravar as promo$$HEX2$$e700f500$$ENDHEX$$es")
		Close(w_Aguarde)
		Return False	
	Else
		SqlCa.of_Commit();
		Close(w_Aguarde)
	End If
End If
				 								
Return True

end function

public function boolean wf_verifica_consistencia (integer pi_filial_base, integer pi_filial_nova);String ls_Rede_Filial_Base, ls_Rede_Filial_Nova
		 
Long lvl_Count_Vendas

DateTime lvdh_Venda, ldh_Inicio_Movto_Calculo_EB

//Return True

select id_rede_filial
 into :ls_Rede_Filial_Base
  from filial 
 where cd_filial = :pi_Filial_Base
	
Using Sqlca;

Choose Case SqlCa.SqlCode
	Case 0
		If IsNull(ls_Rede_Filial_Base) or (ls_Rede_Filial_Base = "")  Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Rede da FILIAL BASE esta NULA ou em branco.")
		End If
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O tipo da rede da filial BASE n$$HEX1$$e300$$ENDHEX$$o foi localizado.")
		Return False
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro da filial Base 'ID_REDE_FILIAL'")
		Return False
End Choose

select id_rede_filial
 into :ls_Rede_Filial_Nova
  from filial 
 where cd_filial = :pi_Filial_Nova
	
Using Sqlca;

Choose Case SqlCa.SqlCode
	Case 0
		If IsNull(ls_Rede_Filial_Nova) or (ls_Rede_Filial_Nova = "") Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Rede da FILIAL NOVA esta NULA.")
		End If
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O tipo da rede da filial NOVA ou em branco.")
		Return False
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro da filial Nova 'ID_REDE_FILIAL'")
		Return False
End Choose

If ls_Rede_Filial_Base <> ls_Rede_Filial_Nova Then
   Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","A rede da filial NOVA '" + ls_Rede_Filial_Nova +&
   			  "' $$HEX1$$e900$$ENDHEX$$ diferente da rede da filial BASE '" + ls_Rede_Filial_Base + "'.", StopSign!)
   Return False	
End If

select dh_inicio_movimento_calculo_eb
 into :ldh_Inicio_Movto_Calculo_EB
  from filial 
 where cd_filial = :pi_Filial_Nova
Using Sqlca;

Choose Case SqlCa.SqlCode
	Case 100
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da filial base.")
		Return False
End Choose

If IsNull(ldh_Inicio_Movto_Calculo_EB) Then
	select Count(*), Max(dh_movimentacao_caixa) 
	  into :lvl_Count_Vendas ,
			 :lvdh_Venda
	  from nf_venda  
	 where cd_filial = :pi_Filial_Nova	
	Using Sqlca;
Else
	If Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O c$$HEX1$$f300$$ENDHEX$$digo da filial '" + String(pi_Filial_Nova) + "'  esta sendo reutilizado ?", Question!, YesNo!, 2) = 2 Then
		Return False
	End If
	
	select Count(*), Max(dh_movimentacao_caixa) 
	  into :lvl_Count_Vendas ,
			 :lvdh_Venda
	  from nf_venda  
	 where cd_filial = :pi_Filial_Nova	
	 	and dh_movimentacao_caixa >= :ldh_Inicio_Movto_Calculo_EB
	Using Sqlca;
End If

If Sqlca.SqlCode <> 0 Then
	SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o das vendas da filial nova")
	Return False
End If

If lvl_Count_Vendas > 10 Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","A filial '" + String(pi_Filial_Nova) + "' n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ NOVA.~r" +&
			   "Ultima venda: '" + String(Date(lvdh_Venda), "dd/mm/yyyy") + "'.", StopSign! )
	Return False
End If

If ivo_filial_origem.cd_unidade_federacao <> ivo_filial_Destino.cd_unidade_federacao Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O estado da filial BASE '" + ivo_filial_origem.cd_unidade_federacao +&
				"' $$HEX1$$e900$$ENDHEX$$ diferente do estado da filial NOVA '" + ivo_filial_destino.cd_unidade_federacao + "'.", StopSign!)
	Return False 
End If
	
Return True


end function

public function boolean wf_abre_arquivo_log ();//ivs_arquivo_log = "c:\sistemas\co\arquivos\eb_loja_nova.log"

ivs_arquivo_log = "c:\sistemas\" + gvo_Aplicacao.ivo_Seguranca.Cd_Sistema +  "\arquivos\eb_loja_nova.log"

ivl_Log = FileOpen(ivs_arquivo_log, LineMode!, Write!, LockWrite!, Append!)
	
If ivl_Log = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao abrir o arquivo do pedido '" + ivs_arquivo_log + ".")
	Return False
End If
end function

public subroutine wf_grava_log (string as_mensagem);String lvs_Mensagem

lvs_Mensagem = String(ivdt_Alteracao, "dd/mm/yyyy")  + " " + String(Now(), "hh:mm:ss") +  " - " + as_Mensagem

FileWrite(ivl_log, lvs_Mensagem)




end subroutine

public function boolean wf_parametros_novo_eb ();Date ldh_Prox_Recalculo

Long ll_Perfil

String ls_Achou

dw_1.AcceptText()

Select coalesce(vl_parametro, 'N')
	Into :ls_Achou
From parametro_loja
Where cd_filial = :ivl_Filial_Nova
	And cd_parametro = 'ID_UTILIZA_NOVO_CALCULO_ESTOQUE_BASE'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
		Update parametro_loja
			Set vl_parametro = 'S'
		Where cd_filial = :ivl_Filial_Nova
			And cd_parametro = 'ID_UTILIZA_NOVO_CALCULO_ESTOQUE_BASE'
		Using SqlCa;
		
		If SqlCa.Sqlcode = -1 Then
			SqlCa.of_RollBack();
			SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro 'ID_UTILIZA_NOVO_CALCULO_ESTOQUE_BASE'.")
			Return False
		End If
		
	Case 100
		
		 INSERT INTO parametro_loja  ( cd_filial, cd_parametro, vl_parametro )  
		 VALUES ( :ivl_Filial_Nova, 'ID_UTILIZA_NOVO_CALCULO_ESTOQUE_BASE', 'S')
		 Using SqlCa;
		 
		 If SqlCa.Sqlcode = -1 Then
			SqlCa.of_RollBack();
			SqlCa.of_MsgDbError("Inclus$$HEX1$$e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro 'ID_UTILIZA_NOVO_CALCULO_ESTOQUE_BASE'.")
			Return False
		End If	
		
	Case -1
		SqlCa.of_RollBack();
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro 'ID_UTILIZA_NOVO_CALCULO_ESTOQUE_BASE'.")
		Return False
End Choose

ls_Achou = ""

Select coalesce(vl_parametro, 'N')
	Into :ls_Achou
From parametro_loja
Where cd_filial = :ivl_Filial_Nova
	And cd_parametro = 'DH_INICIO_NOVO_CALCULO_EB'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
		Update parametro_loja
			Set vl_parametro = '01/01/1900'
		Where cd_filial = :ivl_Filial_Nova
			And cd_parametro = 'DH_INICIO_NOVO_CALCULO_EB'
		Using SqlCa;
		
		If SqlCa.Sqlcode = -1 Then
			SqlCa.of_RollBack();
			SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro 'DH_INICIO_NOVO_CALCULO_EB'.")
			Return False
		End If
		
	Case 100
		
		 INSERT INTO parametro_loja  ( cd_filial, cd_parametro, vl_parametro )  
		 VALUES ( :ivl_Filial_Nova, 'DH_INICIO_NOVO_CALCULO_EB', '01/01/1900')
		 Using SqlCa;
		 
		 If SqlCa.Sqlcode = -1 Then
			SqlCa.of_RollBack();
			SqlCa.of_MsgDbError("Inclus$$HEX1$$e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro 'DH_INICIO_NOVO_CALCULO_EB'.")
			Return False
		End If	
		
	Case -1
		SqlCa.of_RollBack();
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro 'DH_INICIO_NOVO_CALCULO_EB'.")
		Return False
End Choose

ls_Achou = ""

Select coalesce(vl_parametro, 'N')
Into :ls_Achou
From parametro_loja
Where cd_filial = :ivl_Filial_Nova
	and cd_parametro = 'ID_NOVO_CALCULO_EB_CALCULO_QUINZENAL'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
		Update parametro_loja
			Set vl_parametro = 'S'
		Where cd_filial = :ivl_Filial_Nova
			And cd_parametro = 'ID_NOVO_CALCULO_EB_CALCULO_QUINZENAL'
		Using SqlCa;
		
		If SqlCa.Sqlcode = -1 Then
			SqlCa.of_RollBack();
			SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro 'ID_NOVO_CALCULO_EB_CALCULO_QUINZENAL'.")
			Return False
		End If
		
	Case 100
		
		 INSERT INTO parametro_loja  ( cd_filial, cd_parametro, vl_parametro )  
		 VALUES ( :ivl_Filial_Nova, 'ID_NOVO_CALCULO_EB_CALCULO_QUINZENAL', 'S')
		 Using SqlCa;
		 
		 If SqlCa.Sqlcode = -1 Then
			SqlCa.of_RollBack();
			SqlCa.of_MsgDbError("Inclus$$HEX1$$e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro 'ID_NOVO_CALCULO_EB_CALCULO_QUINZENAL'.")
			Return False
		End If	
		
	Case -1
		SqlCa.of_RollBack();
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro 'ID_NOVO_CALCULO_EB_CALCULO_QUINZENAL'.")
		Return False
End Choose

///// MEDIANA
Select coalesce(vl_parametro, 'N')
Into :ls_Achou
From parametro_loja
Where cd_filial = :ivl_Filial_Nova
	and cd_parametro = 'ID_UTILIZA_MEDIANA_CALCULO_ESTOQUE_BASE'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
		Update parametro_loja
			Set vl_parametro = 'S'
		Where cd_filial = :ivl_Filial_Nova
			And cd_parametro = 'ID_UTILIZA_MEDIANA_CALCULO_ESTOQUE_BASE'
		Using SqlCa;
		
		If SqlCa.Sqlcode = -1 Then
			SqlCa.of_RollBack();
			SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro 'ID_UTILIZA_MEDIANA_CALCULO_ESTOQUE_BASE'.")
			Return False
		End If
		
	Case 100
		
		 INSERT INTO parametro_loja  ( cd_filial, cd_parametro, vl_parametro )  
		 VALUES ( :ivl_Filial_Nova, 'ID_UTILIZA_MEDIANA_CALCULO_ESTOQUE_BASE', 'S')
		 Using SqlCa;
		 
		 If SqlCa.Sqlcode = -1 Then
			SqlCa.of_RollBack();
			SqlCa.of_MsgDbError("Inclus$$HEX1$$e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro 'ID_UTILIZA_MEDIANA_CALCULO_ESTOQUE_BASE'.")
			Return False
		End If	
		
	Case -1
		SqlCa.of_RollBack();
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro 'ID_UTILIZA_MEDIANA_CALCULO_ESTOQUE_BASE'.")
		Return False
End Choose
////

// Trinta dias, pois com quinze a loja ainda pode n$$HEX1$$e300$$ENDHEX$$o estar aberta e isso gera problema no rec$$HEX1$$e100$$ENDHEX$$lculo
ldh_Prox_Recalculo = RelativeDate(Date(gvo_Parametro.of_Dh_Movimentacao()), 30)

// N$$HEX1$$e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ existir c$$HEX1$$e100$$ENDHEX$$lculo do EB no primeiro dia do m$$HEX1$$ea00$$ENDHEX$$s.
If Day(ldh_Prox_Recalculo) = 1 Then
	ldh_Prox_Recalculo = RelativeDate(ldh_Prox_Recalculo, 1)
End If	
				
Update parametro_reposicao_estoque 
Set 	dh_proximo_calculo					= :ldh_Prox_Recalculo,
		nr_matricula_proximo_recalculo	= '14330'
From parametro_reposicao_estoque
Where cd_filial = :ivl_Filial_Nova
Using SqlCa;
  
If SqlCa.SqlCode = -1 Then
	SqlCa.of_RollBack();
	SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o da data do pr$$HEX1$$f300$$ENDHEX$$ximo rec$$HEX1$$e100$$ENDHEX$$lculo")
	Return False
End If

If Not wf_Perfil_Estoque(ll_Perfil) Then Return False

Update filial
	Set cd_perfil_estoque = :ll_Perfil
Where cd_filial = :ivl_Filial_Nova
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_RollBack();
	SqlCa.of_MsgDbError("Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do perfil de estoque da filial.")
	Return False
End If

// Insere os registros de limite na tela par$$HEX1$$e200$$ENDHEX$$metro loja
If Not lf_ge413_insere_limite_alteracao_eb(ivl_Filial_Nova) Then Return False

Return True
end function

public function boolean wf_perfil_estoque (ref long al_perfil);String ls_Uf
String ls_Erro
String ls_Perfil
String ls_Parametro

Select cd_uf
	Into :ls_Uf
From vw_filial
Where cd_filial = :ivl_Filial_Nova
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		//
		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizada a UF da filial na vw_filial.")
		Return False
		
	Case -1
		ls_Erro = SqlCa.SqlErrText
		SqlCa.of_RollBack();
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao consultar a UF da filial. " + ls_Erro, StopSign!)
		Return False
End Choose

Select cd_perfil_estoque
Into :ls_Perfil
from   filial 
where cd_filial = :ivl_Filial_Base
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		al_Perfil = Long(ls_Perfil)
		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado o par$$HEX1$$e200$$ENDHEX$$metro da filial Base:'" + String(ivl_Filial_Base)+ "'.")
		Return False
		
	Case -1
		ls_Erro = SqlCa.SqlErrText
		SqlCa.of_RollBack();
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o par$$HEX1$$e200$$ENDHEX$$metro '" + ls_Parametro + "'. " + ls_Erro)
		Return False
End Choose

Return True
end function

public function boolean wf_inclui_saldo_produto ();Long ll_Linha
Long ll_Linhas
Long ll_Produto
String ls_Saldo_Parametro

Integer li_Contador = 0

Date ldh_Saldo

Try		
	// Central
	Open( w_Aguarde )
	w_Aguarde.Title = "Incluindo Saldo dos Produtos no Central..."
		
	ls_Saldo_Parametro = String(gvo_Parametro.dh_movimentacao, '01/MM/YYYY')
	
	ldh_Saldo= Date( ls_Saldo_Parametro )
	
	If Not wf_Atualiza_Saldo_Inicial( ls_Saldo_Parametro ) Then
		Return False
	End If
		
	dc_uo_ds_base lds_Saldo
	lds_Saldo = Create dc_uo_ds_base
	lds_Saldo.of_ChangeDataObject( "ds_ge413_saldo_produto" )
	ll_Linhas = lds_Saldo.Retrieve( ivl_Filial_Nova, ldh_Saldo )
	
	w_Aguarde.uo_Progress.of_SetMax( ll_Linhas )
	
	IF ll_Linhas > 0 Then
		For ll_Linha = 1 To ll_Linhas
			w_Aguarde.Title = "Incluindo Saldo dos Produtos no Central..." + String( ll_Linha ) + " de " + String( ll_Linhas )
			
			ll_Produto = lds_Saldo.Object.Cd_Produto[ ll_Linha ]
												
			INSERT INTO saldo_produto (	cd_filial,
													cd_produto,
													dh_saldo,
													qt_saldo_final,
													vl_custo_medio,
													vl_custo_gerencial)
				Values( 	:ivl_Filial_Nova,
							:ll_Produto,
							:ldh_Saldo,
							0,
							0,
							0 )
			USING SqlCa;
				
			If SqlCa.SqlCode = -1 Then
				SqlCa.of_RollBack( );
				SqlCa.of_MsgdbError("Inclus$$HEX1$$e300$$ENDHEX$$o do Saldo do Produto " + String ( ll_Produto ) )
				Return False
			End If
			
			li_Contador++
			
			If li_Contador > 100 Then
				li_Contador = 0
				SqlCa.of_Commit()
			End If
			
			w_Aguarde.uo_Progress.of_SetProgress( ll_Linha )					
		Next
		
		SqlCa.of_Commit()
		
	End If
	
	Return True
	
Finally
	Close( w_Aguarde )
	If IsValid(lds_Saldo) 				Then Destroy lds_Saldo
End Try
	
end function

public function boolean wf_atualiza_saldo_inicial (string as_dh_saldo);Integer li_count

SELECT count( cd_parametro ) 
	INTO :li_count 
FROM parametro_loja
	WHERE cd_filial = :ivl_Filial_Nova
		AND cd_parametro = 'DH_SALDO_INICIAL'
USING SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Erro ao localizar o parametro_loja DH_SALDO_INICIAL.")
	Return False
End If

//Parametro existente(reutiliza$$HEX2$$e700e300$$ENDHEX$$o de codigo)
If (li_count>0) Then
	UPDATE parametro_loja SET vl_parametro = :as_dh_saldo
		WHERE cd_filial 			= :ivl_Filial_Nova
			AND cd_parametro 	= 'DH_SALDO_INICIAL'
	USING SqlCa;
	
Else
	INSERT INTO parametro_loja (cd_filial,
											cd_parametro,
											vl_parametro)
		Values( :ivl_Filial_Nova, 
				   'DH_SALDO_INICIAL', 
				   :as_dh_saldo ) 
	USING SqlCa;
End If

If SqlCa.SqlCode = -1 Then
	SqlCa.of_Rollback();
	SqlCa.of_MsgDbError("Erro ao incluir/alterar o par$$HEX1$$e200$$ENDHEX$$metro: DH_SALDO_INICIAL. Fun$$HEX2$$e700e300$$ENDHEX$$o: wf_atualiza_saldo_inicial()")
	Return False
Else 
	SqlCa.of_Commit()
	Return True
End If
end function

on w_ge413_estoque_base_inicial.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.dw_1=create dw_1
this.cb_cancelar=create cb_cancelar
this.cb_confirma=create cb_confirma
this.pb_selecao=create pb_selecao
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.cb_cancelar
this.Control[iCurrent+4]=this.cb_confirma
this.Control[iCurrent+5]=this.pb_selecao
end on

on w_ge413_estoque_base_inicial.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.cb_cancelar)
destroy(this.cb_confirma)
destroy(this.pb_selecao)
end on

event ue_postopen;call super::ue_postopen;dw_1.Event ue_AddRow()

dw_1.SetFocus()

ivo_Filial_Origem  = Create uo_Filial 
ivo_Filial_Destino = Create uo_Filial
ivo_Promocao	   = Create uo_Promocao

end event

event close;call super::close;FileClose(ivl_Log)

Destroy(ivo_Filial_Origem)
Destroy(ivo_Filial_Destino)
Destroy(ivo_Promocao)

end event

type dw_visual from dc_w_sheet`dw_visual within w_ge413_estoque_base_inicial
end type

type gb_aux_visual from dc_w_sheet`gb_aux_visual within w_ge413_estoque_base_inicial
end type

type gb_1 from groupbox within w_ge413_estoque_base_inicial
integer x = 23
integer width = 1842
integer height = 536
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
borderstyle borderstyle = styleraised!
end type

type dw_1 from dc_uo_dw_base within w_ge413_estoque_base_inicial
integer x = 50
integer y = 68
integer width = 1801
integer height = 444
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge413_parametro_inicial"
end type

event constructor;call super::constructor;This.of_SetColSelection(True)
end event

event ue_key;call super::ue_key;String lvs_Coluna

If Key = KeyEnter! Then
	
	lvs_Coluna = This.GetColumnName()
	
	If lvs_Coluna = "nm_filial_base" Then
				
		ivo_Filial_Origem.of_Localiza_Filial(This.GetText())
		
		If ivo_Filial_Origem.Localizada Then
			dw_1.Object.nm_filial_base[1] = ivo_Filial_Origem.nm_fantasia
			dw_1.Object.cd_filial_base[1] = ivo_Filial_Origem.cd_filial
		End If
	End If
	
	If lvs_Coluna = "nm_filial_nova" Then
				
		ivo_Filial_Destino.of_Localiza_Filial(This.GetText())
		
		If ivo_Filial_Destino.Localizada Then
			dw_1.Object.nm_filial_nova[1] = ivo_Filial_Destino.nm_fantasia
			dw_1.Object.cd_filial_nova[1] = ivo_Filial_Destino.cd_filial
		End If
	End If
	
	If lvs_Coluna = "nm_promocao" Then

		ivo_Promocao.of_Localiza(This.GetText())

		If ivo_Promocao.Localizado Then
			dw_1.Object.Cd_Promocao[1] = ivo_Promocao.Cd_Promocao
			dw_1.Object.nm_Promocao[1] = ivo_Promocao.nm_Promocao
		End If
	End If
End If
end event

event losefocus;call super::losefocus;If IsValid(ivo_Filial_Origem) Then
	dw_1.Object.cd_filial_base[1] = ivo_Filial_Origem.cd_filial
	dw_1.Object.nm_filial_base[1] = ivo_Filial_Origem.nm_fantasia
End If

If IsValid(ivo_Filial_Destino) Then
	dw_1.Object.cd_filial_nova[1] = ivo_Filial_Destino.cd_filial
	dw_1.Object.nm_filial_nova[1] = ivo_Filial_Destino.nm_fantasia
End If

//If IsValid(ivo_Promocao) Then
//	dw_1.Object.cd_promocao[1] = ivo_Promocao.cd_promocao
//	dw_1.Object.nm_promocao[1] = ivo_Promocao.nm_promocao
//End If
end event

event itemchanged;call super::itemchanged;String lvs_Coluna 

lvs_Coluna = This.GetColumnName()

If lvs_Coluna = "nm_filial_base" Then
	If Not IsNull(Data) and Trim(Data) <> "" Then
		If Data <> ivo_Filial_Origem.nm_fantasia Then
			Return 1
		End If
	Else
		ivo_Filial_Origem.of_Inicializa()
		
		dw_1.Object.cd_filial_base[1] = ivo_Filial_Origem.cd_filial
		dw_1.Object.nm_filial_base[1] = ivo_Filial_Origem.nm_fantasia
	End If
End If

If lvs_Coluna = "nm_filial_nova" Then
	If Not IsNull(Data) and Trim(Data) <> "" Then
		If Data <> ivo_Filial_Destino.nm_fantasia Then
			Return 1
		End If
	Else
		ivo_Filial_Destino.of_Inicializa()
		
		dw_1.Object.cd_filial_nova[1] = ivo_Filial_Destino.cd_filial
		dw_1.Object.nm_filial_nova[1] = ivo_Filial_Destino.nm_fantasia
	End If
End If

//If lvs_Coluna = "nm_promocao" Then
//	If Not IsNull(Data) and Trim(Data) <> "" Then
//		If Data <> ivo_Promocao.nm_promocao Then
//			Return 1
//		End If
//	Else
//		ivo_Promocao.of_Inicializa()
//		
//		dw_1.Object.cd_promocao[1] = ivo_Promocao.cd_promocao
//		dw_1.Object.nm_promocao[1] = ivo_Promocao.nm_promocao
//	End If
//End If

If lvs_Coluna = "id_tipo_atualizacao" Then
	Choose Case Data
		Case "EX" 
			pb_selecao.Visible 			   = True
			dw_1.Object.nm_arquivo.Visible = 1
			dw_1.Object.st_arquivo.Visible = 1
		Case "CO"
			pb_selecao.Visible 			   = False
			dw_1.Object.nm_arquivo.Visible = 0
			dw_1.Object.st_arquivo.Visible = 0
	End Choose
End If


end event

type cb_cancelar from commandbutton within w_ge413_estoque_base_inicial
integer x = 1481
integer y = 564
integer width = 384
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Cancelar"
end type

event clicked;Close(Parent)
end event

type cb_confirma from commandbutton within w_ge413_estoque_base_inicial
integer x = 1070
integer y = 564
integer width = 384
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Confirmar"
end type

event clicked;Boolean lvb_Sucesso = False

String ls_Erro

dw_1.AcceptText()

SetPointer(HourGlass!)
		
ivl_Filial_Nova = dw_1.Object.cd_filial_nova[1]

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a atualiza$$HEX2$$e700e300$$ENDHEX$$o do estoque base da filial '" +&
						  String(ivl_Filial_Nova) + "'?", Question!, YesNo!, 2) = 2 Then Return

ivs_Responsavel 	   	= gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
ivl_Filial_Base 	   		= dw_1.Object.cd_filial_base     		[1]
ivs_Promocao		   	= dw_1.Object.id_promocao        		[1]
ivs_Tipo_Atualizacao 	= dw_1.Object.id_tipo_atualizacao	[1]

ivdt_Alteracao = gf_GetServerDate()
		
If wf_abre_arquivo_log() Then	Return
						  
ivds_Atualizacao = Create dc_uo_ds_base

try
	If Not ivds_Atualizacao.of_ChangeDataObject("ds_ge413_estoque_base_atualizacao") Then Return
	
	wf_Grava_Log( "In$$HEX1$$ed00$$ENDHEX$$cio Filial '" + String(ivl_Filial_Nova) + "'")
	
	If Not wf_Valida_Informacoes() Then Return
	
	// Verifica se o tipo de rede da filial Base e a mesma da Nova
	// Verifica se a filial realmente $$HEX1$$e900$$ENDHEX$$ NOVA
	// Verifica se o estadao da filial Base $$HEX1$$e900$$ENDHEX$$ a mesmo da Nova
	If Not wf_verifica_consistencia(ivl_Filial_Base, ivl_Filial_Nova) Then Return
	
	If wf_Inclui_Saldo_produto() Then
		If wf_Atualiza_Mix_Produto() Then
			// Quando um c$$HEX1$$f300$$ENDHEX$$digo de loja for reutilizado o estoque base deve ser zerado
			If wf_Zera_Estoque_Base() Then		
				If wf_Atualiza_Parametro_Reposicao_Estoque() Then
					If wf_Inclui_Loja_Promocao(ivl_Filial_Base, ivl_Filial_Nova) Then
							If ivds_Atualizacao.Retrieve(ivl_Filial_Nova)> 0 Then
								
								If ivs_Tipo_Atualizacao = "CO" Then
									// Copia o estoque base da filial base para a filial nova
									If wf_Copia_Estoque_Base() Then
										lvb_Sucesso = True
									End If
								Else
									// Atualizar o estoque base do arquivo excel
									If wf_Importa_Arquivo_Excel() Then
										lvb_Sucesso = True
									End If
								End If
							Else
								Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum produto foi encontrado para atualiza$$HEX2$$e700e300$$ENDHEX$$o na filial nova.")
							End If //Retrieve
					End If // Inclui filial na promo$$HEX2$$e700e300$$ENDHEX$$o
				End If // Atualiza par$$HEX1$$e200$$ENDHEX$$metro reposi$$HEX2$$e700e300$$ENDHEX$$o
			End If // Zera EB
		End If // Atualiza MIX
	End If //Saldo Produto	
	
	If lvb_Sucesso Then
		If ivds_Atualizacao.Update() = 1  Then
			If wf_Parametros_Novo_EB() Then
				Sqlca.of_Commit();
				Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O estoque base da filial '" + String(ivl_Filial_Nova) +&
							"' foi definido com sucesso.", Information!)
				wf_Grava_Log( "T$$HEX1$$e900$$ENDHEX$$rmino Filial '" + String(ivl_Filial_Nova) + "'")
				Close(Parent)
			End If
		Else
			ls_Erro = SqlCa.SqlErrTExt
			SqlCa.of_RollBack();
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao atualizar o estoque base. " + ls_Erro, StopSign!)
			wf_Grava_Log( "T$$HEX1$$e900$$ENDHEX$$rmino Filial '" + String(ivl_Filial_Nova) + "'")
			Return
		End If
	Else
		SqlCa.of_RollBack();
		wf_Grava_Log( "T$$HEX1$$e900$$ENDHEX$$rmino Filial '" + String(ivl_Filial_Nova) + "'")
	End If

finally
	FileClose(ivl_Log)
	If IsValid(ivds_Atualizacao) Then Destroy(ivds_Atualizacao)
	SetPointer(Arrow!)
end try
end event

type pb_selecao from picturebutton within w_ge413_estoque_base_inicial
boolean visible = false
integer x = 1582
integer y = 432
integer width = 110
integer height = 88
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string picturename = "Search!"
alignment htextalign = left!
end type

event clicked;String lvs_Arquivo,&
	   lvs_Nome

Integer lvi_Retorno 

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Os Dados devem estar da seguinte forma:~r~r" + &
                     "Coluna A = Produto~r"     + &
					 "Coluna B = Estoque Base~r")

lvi_Retorno = GetFileOpenName("Seleciona o arquivo", + lvs_Arquivo, lvs_Nome, "XLS", "Excel (*.XLS),*.XLS,")

If lvi_Retorno = 1 Then 
	dw_1.Object.nm_arquivo[1] = Upper(lvs_Arquivo)
End If
	
	


end event

