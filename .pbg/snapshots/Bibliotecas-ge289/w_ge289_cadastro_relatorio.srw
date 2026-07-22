HA$PBExportHeader$w_ge289_cadastro_relatorio.srw
forward
global type w_ge289_cadastro_relatorio from dc_w_cadastro_freeform
end type
type cb_2 from commandbutton within w_ge289_cadastro_relatorio
end type
end forward

global type w_ge289_cadastro_relatorio from dc_w_cadastro_freeform
string tag = "w_ge289_cadastro_relatorio"
integer width = 2066
integer height = 1476
string title = "GE289 - Cadastro de Relat$$HEX1$$f300$$ENDHEX$$rios de Rentabilidade (Custo Gerencial)"
long backcolor = 80269524
cb_2 cb_2
end type
global w_ge289_cadastro_relatorio w_ge289_cadastro_relatorio

type variables

uo_ge216_Filiais ivo_Filiais
uo_ge229_selecao_prd_personalizado ivo_Selecao
uo_promocao ivo_promocao
uo_ge289_consulta_rentabilidade ivo_consulta

boolean ivb_Excluindo = False

string ivs_Id_Selecao_Filial, &
         ivs_Id_Selecao_Produto, &
         ivs_Selecao_Fornecedor
end variables

forward prototypes
public function boolean wf_proximo_codigo (ref long pl_consulta)
public function boolean wf_grava_consulta (long pl_parametro)
public function boolean wf_atualiza_consulta (long pl_parametro)
public function boolean wf_valida_data ()
public function boolean wf_recupera_filiais ()
public function boolean wf_grava_filiais (long pl_parametro)
public function boolean wf_exclui_filiais (long pl_parametro)
public function boolean wf_deleta_relatorio (long pl_consulta, string ps_consulta)
public function boolean wf_executa_sql_dev (long pl_consulta, string ps_consulta)
public function boolean wf_executa_sql_venda (long pl_consulta, string ps_consulta)
public subroutine wf_seleciona_produtos ()
public function boolean wf_atualiza_vendas (long pl_consulta, string ps_consulta)
public function string wf_monta_sql (string ps_consulta)
public function boolean wf_grava_produtos (long pl_consulta, string ps_consulta)
public function boolean wf_syntaxfromsql (ref dc_uo_ds_base pds_1, String ps_Sql)
public function boolean wf_grava_consulta_rentab_selecao (long pl_consulta)
public subroutine wf_seleciona_fornecedor ()
public subroutine wf_seleciona_convenio ()
public function boolean wf_exclui_selecao (long pl_consulta)
public function boolean wf_exclui_produtos (string ps_parametro)
public subroutine wf_grava_sql (string ps_sql, string ps_operacao)
public subroutine wf_seleciona_filiais (string ps_operacao)
public function long wf_erro_relatorio (long pl_consulta, string ps_consulta)
public subroutine of_appendgroup (ref string ps_sql, string ps_group)
public subroutine of_appendselect (ref string ps_sql, string ps_select)
public subroutine of_appendfrom (ref string ps_sql, string ps_from)
public subroutine of_appendwhere (ref string ps_sql, string ps_where)
public function boolean wf_atualiza_vendas_totalizadas (string ps_consulta)
end prototypes

public function boolean wf_proximo_codigo (ref long pl_consulta);Boolean lvb_Sucesso = True

Select max(cd_consulta) Into :pl_Consulta
From consulta_rentabilidade
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If Not IsNull(pl_Consulta) Then
			pl_Consulta++
		Else
			pl_Consulta = 1
		End If
	Case 100
		lvb_Sucesso = False
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do pr$$HEX1$$f300$$ENDHEX$$ximo c$$HEX1$$f300$$ENDHEX$$digo.")
		lvb_Sucesso = False
End Choose

Return lvb_Sucesso
end function

public function boolean wf_grava_consulta (long pl_parametro);DateTime lvdh_Dh_Inicio, &
			lvdh_Termino
			
Long lvl_Cd_Promocao

String lvs_Sql, &
		 lvs_De_Consulta, &
		 lvs_Id_Tipo_Venda, &
		 lvs_Id_Selecao_Produto, &
		 lvs_Id_Selecao_Filial, &
		 lvs_Id_Apresentacao_Periodo, &
		 lvs_id_Apresentacao_Produto, &
		 lvs_Id_Apresentacao_Filial, &
		 lvs_Cd_Fornecedor

lvs_De_Consulta				 = Trim(dw_1.Object.De_Consulta 	     [1])
lvdh_Dh_Inicio 				 = dw_1.Object.Dh_Inicio 				  [1]
lvdh_Termino					 = dw_1.Object.Dh_Termino				  [1]
lvs_Id_Tipo_Venda				 = dw_1.Object.Id_Tipo_Venda			  [1]
lvs_Id_Selecao_Produto		 = dw_1.Object.Id_Selecao_Produto	  [1]
lvs_Id_Selecao_Filial 		 = dw_1.Object.Id_Selecao_Filial		  [1]
lvs_Id_Apresentacao_Periodo = dw_1.Object.Id_Apresentacao_Periodo[1]
lvs_id_Apresentacao_Produto = dw_1.Object.Id_Apresentacao_Produto[1]
lvs_Id_Apresentacao_Filial	 = dw_1.Object.Id_Apresentacao_Filial [1]
lvl_Cd_Promocao				 = dw_1.Object.Cd_Promocao				  [1]
lvs_Cd_Fornecedor				 = dw_1.Object.Cd_Fornecedor			  [1]

Insert Into consulta_rentabilidade
	 Values (:pl_Parametro,
				:lvs_De_Consulta,
				:lvdh_Dh_Inicio,
				:lvdh_Termino,
			 	:lvs_Id_Tipo_Venda,
			 	:lvs_Id_Selecao_Produto,
			 	:lvs_Id_Selecao_Filial,
			 	:lvs_Id_Apresentacao_Periodo,
			 	:lvs_id_Apresentacao_Produto,
			 	:lvs_Id_Apresentacao_Filial,
			 	:lvl_Cd_Promocao,
			 	:lvs_Cd_Fornecedor)
	 Using SqlCa;
			 
If SqlCa.SqlCode = -1 Then 
	SqlCa.of_MsgDbError("INCLUS$$HEX1$$c300$$ENDHEX$$O DA CONSULTA")
	SqlCa.of_Rollback()
	Return False
End If

Return True
end function

public function boolean wf_atualiza_consulta (long pl_parametro);DateTime lvdh_Dh_Inicio, &
			lvdh_Termino
			
Long lvl_Cd_Promocao

String lvs_Sql, &
		 lvs_De_Consulta, &
		 lvs_Id_Tipo_Venda, &
		 lvs_Id_Selecao_Produto, &
		 lvs_Id_Selecao_Filial, &
		 lvs_Id_Apresentacao_Periodo, &
		 lvs_id_Apresentacao_Produto, &
		 lvs_Id_Apresentacao_Filial, &
		 lvs_Fornecedor

lvs_De_Consulta				 = Trim(dw_1.Object.De_Consulta 	     [1])
lvdh_Dh_Inicio 				 = dw_1.Object.Dh_Inicio 				  [1]
lvdh_Termino					 = dw_1.Object.Dh_Termino				  [1]
lvs_Id_Tipo_Venda				 = dw_1.Object.Id_Tipo_Venda			  [1]
lvs_Id_Selecao_Produto		 = dw_1.Object.Id_Selecao_Produto	  [1]
lvs_Id_Selecao_Filial 		 = dw_1.Object.Id_Selecao_Filial		  [1]
lvs_Id_Apresentacao_Periodo = dw_1.Object.Id_Apresentacao_Periodo[1]
lvs_id_Apresentacao_Produto = dw_1.Object.Id_Apresentacao_Produto[1]
lvs_Id_Apresentacao_Filial	 = dw_1.Object.Id_Apresentacao_Filial [1]
lvl_Cd_Promocao				 = dw_1.Object.Cd_Promocao				  [1]
lvs_Fornecedor 				 = Trim(dw_1.Object.Cd_Fornecedor	  [1])

Update consulta_rentabilidade
	Set de_consulta				 = :lvs_De_Consulta,
	    dh_inicio					 = :lvdh_Dh_Inicio,
		 dh_termino					 = :lvdh_Termino,
		 id_tipo_venda				 = :lvs_Id_Tipo_Venda,
		 id_selecao_produto		 = :lvs_Id_Selecao_Produto,
		 id_selecao_filial		 = :lvs_Id_Selecao_Filial,
		 id_apresentacao_periodo = :lvs_Id_Apresentacao_Periodo,
		 id_apresentacao_produto = :lvs_id_Apresentacao_Produto,
		 id_apresentacao_filial  = :lvs_Id_Apresentacao_Filial,
		 cd_promocao				 = :lvl_Cd_Promocao,
		 cd_fornecedor				 = :lvs_Fornecedor
 Where cd_consulta = :pl_parametro
 Using SqlCa;
 
If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("ATUALIZA$$HEX2$$c700c300$$ENDHEX$$O DA CONSULTA")
	SqlCa.of_Rollback()
	Return False
End If
 
Return True
end function

public function boolean wf_valida_data ();DateTime lvdh_Inicio, &
			lvdh_Termino
			
lvdh_Inicio  = dw_1.Object.Dh_Inicio  [1]
lvdh_Termino = dw_1.Object.Dh_Termino [1]

If IsNull(lvdh_Inicio) Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","A data de in$$HEX1$$ed00$$ENDHEX$$cio deve ser informada.")
	dw_1.Event ue_Pos(1, "dh_inicio")
	Return False
End If

If IsNull(lvdh_Termino) Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","A data de t$$HEX1$$e900$$ENDHEX$$rmino deve ser informada.")
	dw_1.Event ue_Pos(1, "dh_termino")
	Return False
End If

If lvdh_Inicio > lvdh_Termino Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","A data de t$$HEX1$$e900$$ENDHEX$$rmino deve ser maior ou igual a data de in$$HEX1$$ed00$$ENDHEX$$cio.")
	dw_1.Event ue_Pos(1, "dh_termino")
	Return False
End If

//ldt_Limite = RelativeDate(Date(lvdh_Inicio), 90)
//
//If Date(lvdh_Termino) > ldt_Limite Then
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O per$$HEX1$$ed00$$ENDHEX$$odo a ser analisado n$$HEX1$$e300$$ENDHEX$$o pode ultrapassar 90 dias.", Exclamation!)
//	dw_1.Event ue_Pos(1, "dh_inicio")
//	Return False
//End If

If Not gf_Periodo_Permitido(Date(lvdh_Inicio), Date(lvdh_Termino), 90) Then
	dw_1.Event ue_Pos(1, "dh_inicio")
	Return False
End If

Return True
end function

public function boolean wf_recupera_filiais ();dc_uo_ds_base lvds_Filial

Long lvl_Cd_Consulta, &
	  lvl_Row, &
	  lvl_Linha

String lsv_Id_apresentacao_Filial

lvl_Cd_Consulta 				= dw_1.Object.Cd_Consulta		 [1]
lsv_Id_apresentacao_Filial = dw_1.Object.Id_Selecao_Filial[1]

If lsv_Id_apresentacao_Filial = "C" Then
	lvds_Filial = Create dc_uo_ds_base
	
	If Not lvds_Filial.of_ChangeDataObject("dw_ge289_consulta_rentab_filial") Then	Return False
 
 	lvds_Filial.Retrieve(lvl_Cd_Consulta)
	lvl_Row = lvds_Filial.RowCount()
	
	If lvl_Row > 0 Then
		For lvl_Linha = 1 To lvl_Row
			ivo_Selecao.ivl_Filiais[lvl_Linha] = lvds_Filial.Object.Cd_Filial[lvl_Linha]
		Next
	End If
	
End If

Return True

end function

public function boolean wf_grava_filiais (long pl_parametro);Boolean lvb_Commit = True

Long lvl_Linha, &
	  lvl_Qtde_Filiais = 0

If UpperBound(ivo_Selecao.ivl_Filiais) < 1 Then
	
	Select count(*)
	  Into :lvl_Qtde_Filiais
	  from consulta_rentabilidade_filial
	 Where cd_consulta = :pl_Parametro
	 Using SqlCa;
	 
	 
	If lvl_Qtde_Filiais <= 0  Or IsNull(lvl_Qtde_Filiais) Then
	
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione pelo menos uma filial no conjunto de filiais.")
		dw_1.Event ue_Pos(1, "id_selecao_filial")
		Return False
		
	Else
		Return True
	End If
End If

If Not wf_exclui_filiais(pl_parametro) Then Return False

For lvl_Linha = 1 To UpperBound(ivo_Selecao.ivl_Filiais)
	
	Insert Into consulta_rentabilidade_filial
			 (cd_consulta,
			  cd_filial)
	Values (:pl_Parametro,
			  :ivo_Selecao.ivl_Filiais[lvl_Linha])
	 Using SqlCa;

	If SqlCa.SqlCode = -1 Then
		lvb_Commit = False
		SqlCa.of_MsgDbError("INCLUS$$HEX1$$c300$$ENDHEX$$O DO CONJUNTO DE FILIAIS")
		Exit
	End If

Next

If Not lvb_Commit Then
	Return False
End If

Return True
end function

public function boolean wf_exclui_filiais (long pl_parametro);Delete
  From consulta_rentabilidade_filial
 Where cd_consulta = :pl_Parametro
 Using SqlCa;
 
If SqlCa.SqlCode <> -1 Then 
	SqlCa.of_Commit()
	Return True
Else
	SqlCa.of_MsgDbError("EXCLUS$$HEX1$$c300$$ENDHEX$$O DO CONJUNTO DE FILIAIS")
	SqlCa.of_RollBack()
	Return False
End If
end function

public function boolean wf_deleta_relatorio (long pl_consulta, string ps_consulta);String lvs_Sql

lvs_Sql = "Delete From consulta_rentabilidade_dev" + &
			 " Where cd_consulta = '" + ps_Consulta + "'"
			 
Execute Immediate :lvs_Sql Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError('EXCLUS$$HEX1$$c300$$ENDHEX$$O DOS DADOS DA CONSULTA ANTERIOR')
	SqlCa.of_Rollback()
	Close(w_Aguarde)
	Return False
Else
	SqlCa.of_Commit()
End If


lvs_Sql = "Delete From consulta_rentabilidade_dev2" + &
			 " Where cd_consulta = '" + ps_Consulta + "'"
			 
Execute Immediate :lvs_Sql Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError('EXCLUS$$HEX1$$c300$$ENDHEX$$O DOS DADOS DA CONSULTA ANTERIOR')
	SqlCa.of_Rollback()
	Close(w_Aguarde)
	Return False
Else
	SqlCa.of_Commit()
End If

lvs_Sql = "Delete From consulta_rentabilidade_venda" + &
			 " Where cd_consulta = '" + ps_Consulta + "'"
			 
Execute Immediate :lvs_Sql Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError('EXCLUS$$HEX1$$c300$$ENDHEX$$O DOS DADOS DA CONSULTA ANTERIOR')
	SqlCa.of_Rollback()
	Close(w_Aguarde)
	Return False
Else
	SqlCa.of_Commit()
End If

lvs_Sql = "Delete From consulta_rentabilidade_venda2" + &
			 " Where cd_consulta = '" + ps_Consulta + "'"
			 
Execute Immediate :lvs_Sql Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError('EXCLUS$$HEX1$$c300$$ENDHEX$$O DOS DADOS DA CONSULTA ANTERIOR')
	SqlCa.of_Rollback()
	Close(w_Aguarde)
	Return False
Else
	SqlCa.of_Commit()
	Return True
End If
end function

public function boolean wf_executa_sql_dev (long pl_consulta, string ps_consulta);String lvs_Id_Selecao_Filial 		 , &
		 lvs_Id_Selecao_Produto		 , &
		 lvs_Id_Apresentacao_Periodo, &
 		 lvs_Id_Apresentacao_Filial , &
		 lvs_Id_Tipo_Venda
		 
String lvs_SQL, &
       lvs_Insert, &
       lvs_Select_Fixo, &
		 lvs_Select_Filial, &
		 lvs_Select_Data, &
		 lvs_Where, &
		 lvs_Group, &
		 lvs_Cd_Fornecedor,&
		 lvs_Insert2,&
		 lvs_Group2
		 
Long lvl_Cd_Promocao
		 
DateTime lvdh_Inicio, &
			lvdh_Termino
			
lvs_Id_Tipo_Venda	= dw_1.Object.Id_Tipo_Venda[1]

If lvs_Id_Tipo_Venda = "02" Then Return True

lvdh_Inicio				 		 = dw_1.Object.Dh_Inicio  		 		  [1]
lvdh_Termino 		    		 = dw_1.Object.Dh_Termino 		  		  [1]
lvl_Cd_Promocao		 		 = dw_1.Object.Cd_Promocao		 		  [1]
lvs_Id_Selecao_Filial 		 = dw_1.Object.Id_Selecao_Filial 	  [1]
lvs_Id_Selecao_Produto		 = dw_1.Object.Id_Selecao_Produto 	  [1]
lvs_Id_Apresentacao_Periodo = dw_1.Object.Id_Apresentacao_Periodo[1]
lvs_Id_Apresentacao_Filial  = dw_1.Object.Id_Apresentacao_Filial [1]
lvs_Cd_Fornecedor				 = dw_1.Object.Cd_Fornecedor			  [1]

// Determina a parte fixa do insert
lvs_Insert =  "insert into consulta_rentabilidade_dev (cd_filial, " + &
																		  "dh_devolucao, "  + &
																		  "cd_consulta, " + &
																		  "cd_produto, "	+ &
																		  "qt_devolucao, " + &
																		  "vl_devolucao_bruta, " + &
																		  "vl_devolucao_liquida, " + &
																		  "vl_comissao_bruta, " + &											 
																		  "vl_comissao_liquida)"
// Determina a parte fixa do insert
lvs_Insert2 =  "insert into consulta_rentabilidade_dev2 (cd_filial, " + &
																		  "dh_devolucao, "  + &
																		  "cd_consulta, " + &
																		  "cd_produto, "	+ &
																		  "qt_devolucao, " + &
																		  "vl_devolucao_bruta, " + &
																		  "vl_devolucao_liquida, " + &
																		  "vl_comissao_bruta, " + &											 
																		  "vl_comissao_liquida)"
										 
// Determina a parte fixa do select
lvs_Select_Fixo = "'"  + ps_Consulta + "', " + &
						"i.cd_produto, " + &
						"sum(i.qt_devolvida) qt_devolucao, " + &
						"sum(round(i.vl_preco_unitario * i.qt_devolvida, 2)) vl_devolucao_bruta, " + &
						"sum(round(round(round(i.vl_preco_unitario" + &
						" * ((100 - i.pc_desconto) / 100), 2) * i.qt_devolvida, 2)" + &
						" * ((100 - n.pc_desconto) / 100), 2)) vl_devolucao_liquida, " + &							 
						"sum(round(round(i.vl_preco_unitario * i.qt_devolvida, 2)" + &
						" * (i.pc_comissao_extra / 100), 2)) vl_comissao_bruta, " + &							 
						"sum(round(round(round(round(i.vl_preco_unitario * ((100 - i.pc_desconto) / 100), 2) * i.qt_devolvida, 2) * ((100 - n.pc_desconto) / 100), 2)" + &
                  " * (i.pc_comissao_extra / 100), 2)) vl_comissao_liquida " + &
						"from nf_devolucao_venda n, item_nf_devolucao_venda i "						
								
// Determina a parte fixa do where
lvs_Where = "where n.dh_movimentacao_caixa between '" + String(lvdh_Inicio, "yyyy/mm/dd") + "' and '" + String(lvdh_Termino, "yyyy/mm/dd") + "' " + &
				"and n.dh_cancelamento is null " + &
				"and i.cd_filial  = n.cd_filial " + &
				"and i.nr_nf      = n.nr_nf " + &
				"and i.de_especie = n.de_especie " + &
				"and i.de_serie   = n.de_serie "

// Determina a parte vari$$HEX1$$e100$$ENDHEX$$vel do where
If Not IsNull(lvl_Cd_Promocao) Then
	lvs_Where += " and n.cd_filial in (select cd_filial from promocao_sos_filial where cd_promocao_sos = " + String(lvl_Cd_Promocao) + ") "
	//lvs_Where += " and i.cd_produto in (select cd_produto from promocao_sos_produto where cd_promocao_sos = " + String(lvl_Cd_Promocao) + ") "
	lvs_Where += " and exists (select * from nf_venda nf " + &
					"inner join item_nf_venda inf  " + &
					"on inf.cd_filial 		= nf.cd_filial " +&
					"and inf.nr_nf			= nf.nr_nf " +&
					"and inf.de_especie	= nf.de_especie " +&
					"and inf.de_serie		= nf.de_serie " +&
					"and nf.cd_filial		= n.cd_filial_venda " +&
					"and nf.nr_nf			= n.nr_nf_venda " +&
					"and nf.de_especie		= n.de_especie_venda " +&
					"and nf.de_serie		= n.de_serie_venda " +&
					"and inf.cd_produto	= i.cd_produto " +&
					"and inf.cd_promocao_sos =  " + String(lvl_Cd_Promocao) +  ") " 		
	
	
	
Else
	If lvs_Id_Selecao_Filial = "C" Then
		lvs_Where += " and n.cd_filial in (select cd_filial from consulta_rentabilidade_filial where cd_consulta = " + String(pl_Consulta) + ") "
	End If

	If lvs_Cd_Fornecedor = "C" Or lvs_Id_Selecao_Produto = "C" Then
		lvs_Where += " and i.cd_produto in (select cd_produto from consulta_rentabilidade_produto where cd_consulta = '" + ps_Consulta + "') "
	Else
		If lvs_Id_Selecao_Produto <> "T" And lvs_Id_Selecao_Produto <> "N" Then
			lvs_Where += " and i.cd_produto in ( select cd_produto from produto_geral where id_lei_generico = '" + lvs_Id_Selecao_Produto + "') " 
		End If
	End If
End If

// Determina a parte fixa do group by
lvs_Group 	= "group by i.cd_produto "
lvs_Group2 	= "group by i.cd_produto "

// Determina a forma de apresenta$$HEX2$$e700e300$$ENDHEX$$o da filial
If lvs_Id_Apresentacao_Filial = "F" Then
	lvs_Select_Filial = "n.cd_filial "
	lvs_Group += ", " + lvs_Select_Filial
Else
	lvs_Select_Filial = "0 cd_filial "
End If

lvs_Select_Data = "n.dh_movimentacao_caixa "
lvs_Group += ", " + lvs_Select_Data
		
// Formata o SQL completo			
lvs_SQL = lvs_Insert + " select " + lvs_Select_Filial + ", " + lvs_Select_Data + ", " + lvs_Select_Fixo + &
          lvs_Where + lvs_Group

Execute Immediate :lvs_Sql Using SqlCa;

wf_Grava_Sql(lvs_sql, 'DEV')

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Sele$$HEX2$$e700e300$$ENDHEX$$o das Devolu$$HEX2$$e700f500$$ENDHEX$$es.")
	Return False
ELse
	If lvs_Id_Apresentacao_Filial = 'F' Then
		Return True
	Else
		// Quando a apresenta$$HEX2$$e700e300$$ENDHEX$$o for totalizada o sistema ter$$HEX1$$e100$$ENDHEX$$ que rodar outro processo para pegar
		// o custo do saldo ai neste caso vai ter gravar em outra tabela aberto por filial.
		
		lvs_Select_Filial = "n.cd_filial "
		lvs_Group2 += ", " + lvs_Select_Filial
		
		lvs_Select_Data = "n.dh_movimentacao_caixa "
		lvs_Group2 += ", " + lvs_Select_Data
				
		lvs_SQL = lvs_Insert2 + " select " + lvs_Select_Filial + ", " + lvs_Select_Data + ", " + lvs_Select_Fixo + &
         lvs_Where + lvs_Group2		
		
		Execute Immediate :lvs_Sql Using SqlCa;

		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgDbError("Sele$$HEX2$$e700e300$$ENDHEX$$o das Devolu$$HEX2$$e700f500$$ENDHEX$$es '2'.")
			Return False
		Else
			Return True
		End If
	End If
End If
end function

public function boolean wf_executa_sql_venda (long pl_consulta, string ps_consulta);String lvs_Id_Selecao_Filial 		 , &
		 lvs_Id_Selecao_Produto		 , &
		 lvs_Id_Apresentacao_Periodo, &
 		 lvs_Id_Apresentacao_Filial , &
		 lvs_Cd_Fornecedor			 , &
		 lvs_Id_Tipo_Venda
		 
String lvs_SQL, &
       lvs_Insert, &
       lvs_Select_Fixo, &
		 lvs_Select_Filial, &
		 lvs_Select_Data, &
		 lvs_Where, &
		 lvs_Group,&
		 lvs_Insert2,&
	  	 lvs_Group2
		 
Long lvl_Cd_Promocao
		 
DateTime lvdh_Inicio, &
			lvdh_Termino
			
lvdh_Inicio				 		 = dw_1.Object.Dh_Inicio  		 		  [1]
lvdh_Termino 		    		 = dw_1.Object.Dh_Termino 		  		  [1]
lvl_Cd_Promocao		 		 = dw_1.Object.Cd_Promocao		 		  [1]
lvs_Id_Selecao_Filial 		 = dw_1.Object.Id_Selecao_Filial 	  [1]
lvs_Id_Selecao_Produto		 = dw_1.Object.Id_Selecao_Produto 	  [1]
lvs_Id_Apresentacao_Periodo = dw_1.Object.Id_Apresentacao_Periodo[1]
lvs_Id_Apresentacao_Filial  = dw_1.Object.Id_Apresentacao_Filial [1]
lvs_Cd_Fornecedor				 = dw_1.Object.Cd_Fornecedor			  [1]
lvs_Id_Tipo_Venda				 = dw_1.Object.Id_Tipo_Venda			  [1]


// Determina a parte fixa do insert
lvs_Insert =  "insert into consulta_rentabilidade_venda (cd_filial, " + &
																		  "dh_venda, "  + &
																		  "cd_consulta, " + &
																		  "cd_produto, "	+ &
																		  "vl_preco_venda, " + &
																		  "vl_preco_custo, " + &
																		  "qt_venda, " + &
																		  "vl_venda_bruta, " + &
																		  "vl_venda_liquida, " + &
																		  "vl_comissao_bruta, " + &											 
																		  "vl_comissao_liquida)"
																		  
// Determina a parte fixa do insert
lvs_Insert2 =  "insert into consulta_rentabilidade_venda2 (cd_filial, " + &
																		  "dh_venda, "  + &
																		  "cd_consulta, " + &
																		  "cd_produto, "	+ &
																		  "vl_preco_venda, " + &
																		  "vl_preco_custo, " + &
																		  "qt_venda, " + &
																		  "vl_venda_bruta, " + &
																		  "vl_venda_liquida, " + &
																		  "vl_comissao_bruta, " + &											 
																		  "vl_comissao_liquida)"
																		  
										 
// Determina a parte fixa do select
lvs_Select_Fixo = "'" + ps_Consulta + "', " + &
						"i.cd_produto, " + &
						"0 vl_preco_venda, " + & 
						"0 vl_preco_custo, " + &
						"sum(i.qt_vendida) qt_venda, " + &
						"sum(round(i.vl_preco_unitario * i.qt_vendida, 2)) vl_venda_bruta, " + &
						"sum(round(round(i.vl_preco_praticado * i.qt_vendida, 2) " + &
						"* ((100 - n.pc_desconto) / 100), 2)) vl_venda_liquida, " + &							 
						"sum(round(round(i.vl_preco_unitario * i.qt_vendida, 2) * (i.pc_comissao_extra / 100), 2)) vl_comissao_bruta, " + &							 
						"sum(round(round(round(i.vl_preco_praticado * i.qt_vendida, 2) " + &
						"* ((100 - n.pc_desconto) / 100), 2) * (i.pc_comissao_extra / 100), 2)) vl_comissao_liquida "				 + &
						"from nf_venda n (index idx_data_filial), item_nf_venda i "
								
// Determina a parte fixa do where
lvs_Where = "where n.dh_movimentacao_caixa between '" + String(lvdh_Inicio, "yyyy/mm/dd") + "' and '" + String(lvdh_Termino, "yyyy/mm/dd") + "' " + &
				"and n.dh_cancelamento is null " + &
				"and n.nr_nf_anexa is null " + &
				"and i.cd_filial  = n.cd_filial " + &
				"and i.nr_nf      = n.nr_nf " + &
				"and i.de_especie = n.de_especie " + &
				"and i.de_serie   = n.de_serie "

// Determina a parte vari$$HEX1$$e100$$ENDHEX$$vel do where
If Not IsNull(lvl_Cd_Promocao) Then
	lvs_Where += " and n.cd_filial in (select cd_filial from promocao_sos_filial where cd_promocao_sos = " + String(lvl_Cd_Promocao) + ") "
	//lvs_Where += " and i.cd_produto in (select cd_produto from promocao_sos_produto where cd_promocao_sos = " + String(lvl_Cd_Promocao) + ") "
	lvs_Where += " and i.cd_promocao_sos = " + String(lvl_Cd_Promocao) + " "
Else
	If lvs_Id_Selecao_Filial = "C" Then
		lvs_Where += " and n.cd_filial in (select cd_filial from consulta_rentabilidade_filial where cd_consulta = " + String(pl_Consulta) + ") "
	End If

	If lvs_Cd_Fornecedor = "C" Or lvs_Id_Selecao_Produto = "C" Then
		lvs_Where += " and i.cd_produto in (select cd_produto from consulta_rentabilidade_produto where cd_consulta = '" + ps_Consulta + "') "
	Else
		If lvs_Id_Selecao_Produto <> "T" And lvs_Id_Selecao_Produto <> "N" Then
			lvs_Where += " and i.cd_produto in ( select cd_produto from produto_geral where id_lei_generico = '" + lvs_Id_Selecao_Produto + "') " 
		End If
	End If
	
End If

//Se houver sele$$HEX2$$e700e300$$ENDHEX$$o de conv$$HEX1$$ea00$$ENDHEX$$nio
If lvs_Id_Tipo_Venda = "02" Then
	lvs_Where += " and n.cd_convenio is not null " + &
					 "	and n.cd_convenio not in (51014,53847,51859,52602,52540,52541,52542,52549,52550,52551,52552,52562,52581,52582,52587,52349,52575,53724,53725) "
End If

// Determina a parte fixa do group by
lvs_Group 	= "group by i.cd_produto "
lvs_Group2 	= "group by i.cd_produto "

// Determina a forma de apresenta$$HEX2$$e700e300$$ENDHEX$$o da filial
If lvs_Id_Apresentacao_Filial = "F" Then
	lvs_Select_Filial = "n.cd_filial "
	lvs_Group += ", " + lvs_Select_Filial
Else
	lvs_Select_Filial = "0 cd_filial "
End If

lvs_Select_Data = "n.dh_movimentacao_caixa "
lvs_Group += ", " + lvs_Select_Data
		
// Formata o SQL completo			
lvs_SQL = lvs_Insert + " select " + lvs_Select_Filial + ", " + lvs_Select_Data + ", " + lvs_Select_Fixo + &
          lvs_Where + lvs_Group

//Teste
wf_grava_sql(lvs_sql, "VENDAS")
Execute Immediate :lvs_Sql Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Sele$$HEX2$$e700e300$$ENDHEX$$o das Vendas.")
	Return False
Else
	If lvs_Id_Apresentacao_Filial = 'F' Then
		Return True
	Else
		// Quando a apresenta$$HEX2$$e700e300$$ENDHEX$$o for totalizada o sistema ter$$HEX1$$e100$$ENDHEX$$ que rodar outro processo para pegar
		// o custo do saldo ai neste caso vai ter gravar em outra tabela aberto por filial.
		
		lvs_Select_Filial = "n.cd_filial "
		lvs_Group2 += ", " + lvs_Select_Filial
		
		lvs_Select_Data = "n.dh_movimentacao_caixa "
		lvs_Group2 += ", " + lvs_Select_Data
				
		lvs_SQL = lvs_Insert2 + " select " + lvs_Select_Filial + ", " + lvs_Select_Data + ", " + lvs_Select_Fixo + &
         lvs_Where + lvs_Group2		
		
		Execute Immediate :lvs_Sql Using SqlCa;

		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgDbError("Sele$$HEX2$$e700e300$$ENDHEX$$o das Vendas '2'.")
			Return False
		Else
			//Desenvolvimento
			//SqlCa.of_Commit();
			Return True
		End If
	End If
End If
end function

public subroutine wf_seleciona_produtos ();Long lvl_Consulta

dw_1.AcceptText()

lvl_Consulta = dw_1.Object.Cd_Consulta[1]

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Caso utilize Planilha com os Produtos estes n$$HEX1$$e300$$ENDHEX$$o podem estar Repetidos!")

ivo_Selecao.ivs_Consulta = String( lvl_Consulta )
OpenWithParm(w_ge229_sel_produto_personalizado, ivo_Selecao)

ivo_Selecao = Message.PowerObjectParm
end subroutine

public function boolean wf_atualiza_vendas (long pl_consulta, string ps_consulta);String lvs_Id_Tipo_Venda, lvs_Id_Apresentacao_Filial

Date lvdh_Dh_Parametro

lvs_Id_Tipo_Venda			= dw_1.Object.Id_Tipo_Venda				[1]
lvs_Id_Apresentacao_Filial  	= dw_1.Object.Id_Apresentacao_Filial	[1]

Select convert(datetime, substring(convert(char(8), dh_movimentacao, 112), 1, 6) + '01')
  Into :lvdh_Dh_Parametro
  From parametro
 Using SqlCa;
 
Choose Case SqlCa.SqlCode
	Case 0
	Case 100, -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da Data do Par$$HEX1$$e200$$ENDHEX$$metro.")
		Close(w_Aguarde)
		Return False
End Choose

If lvs_Id_Tipo_Venda <> "02" Then

	Update consulta_rentabilidade_venda
		Set v.qt_venda				  = v.qt_venda				  - d.qt_devolucao,
			 v.vl_venda_bruta		  = v.vl_venda_bruta		  - d.vl_devolucao_bruta,
			 v.vl_venda_liquida	  = v.vl_venda_liquida	  - d.vl_devolucao_liquida,
			 v.vl_comissao_bruta	  = v.vl_comissao_bruta	  - d.vl_comissao_bruta,
			 v.vl_comissao_liquida = v.vl_comissao_liquida - d.vl_comissao_liquida
	  From consulta_rentabilidade_venda v,
			 consulta_rentabilidade_dev d
	 Where v.cd_consulta = :ps_Consulta
		And d.cd_consulta  = v.cd_consulta
		And d.cd_filial    = v.cd_filial
		And d.cd_produto   = v.cd_produto
		And d.dh_devolucao = v.dh_venda
	 Using SqlCa;
	 
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o das Vendas.")
		Close(w_Aguarde)
		Return False
	Else
		SqlCa.of_Commit();
	End If 
	
	Insert Into consulta_rentabilidade_venda (cd_consulta,   
															cd_filial,   
															cd_produto,   
															dh_venda,   
															vl_preco_venda,   
															vl_preco_custo,   
															qt_venda,   
															vl_venda_bruta,   
															vl_venda_liquida,   
															vl_comissao_bruta,   
															vl_comissao_liquida)  
	Select d.cd_consulta,
			 d.cd_filial,
			 d.cd_produto,
			 d.dh_devolucao,
			 0, 0,
			 d.qt_devolucao			* -1,
			 d.vl_devolucao_bruta	* -1,
			 d.vl_devolucao_liquida * -1,
			 d.vl_comissao_bruta		* -1,
			 d.vl_comissao_liquida	* -1
	From consulta_rentabilidade_dev d
	Where d.cd_consulta = :ps_Consulta
	  And Not Exists (Select *
							  From consulta_rentabilidade_venda v
							 Where v.cd_consulta = d.cd_consulta
								And v.cd_filial   = d.cd_filial
								And v.cd_produto  = d.cd_produto
								And v.dh_venda    = d.dh_devolucao)
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgDbError("Inser$$HEX2$$e700e300$$ENDHEX$$o das Devolu$$HEX2$$e700f500$$ENDHEX$$es sem Vendas.")
		Close(w_Aguarde)
		Return False
	End If
	
End If


// Desenvolvimento
//SqlCa.of_Commit();

Update consulta_rentabilidade_venda
Set v.vl_preco_venda = round(g.vl_preco_venda_atual / g.vl_fator_conversao, 2),
    v.vl_preco_custo = round(s.vl_custo_medio * v.qt_venda,2)
From consulta_rentabilidade_venda v,
     	produto_geral g,
	 	saldo_produto s
Where v.cd_consulta 	= :ps_Consulta
  and v.cd_produto 	<> 684431
  And g.cd_produto 	= v.cd_produto
  and s.cd_filial			= v.cd_filial
  and s.cd_produto		= v.cd_produto
  and s.dh_saldo		= CONVERT( CHAR(6), v.dh_venda, 112 ) + '01'
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do Pre$$HEX1$$e700$$ENDHEX$$o de Venda.")
	Close(w_Aguarde)
	Return False
Else
	SqlCa.of_Commit();
End If 

Update consulta_rentabilidade_venda
   Set vl_preco_custo = round(vl_venda_liquida * 0.21, 2),
       vl_preco_venda = round(vl_venda_liquida / qt_venda, 2)
  From consulta_rentabilidade_venda
 Where cd_consulta = :ps_Consulta
   and cd_produto = 684431
   and qt_venda <> 0
 Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do Pre$$HEX1$$e700$$ENDHEX$$o de Venda do Produto '684431'.")
	Close(w_Aguarde)
	Return False
Else
	SqlCa.of_Commit();
End If 

Update consulta_rentabilidade_venda
   Set vl_preco_custo = round(vl_venda_liquida * 0.9142, 2)
  From consulta_rentabilidade_venda
 Where cd_consulta = :ps_Consulta
   and cd_produto = 700733
   and qt_venda <> 0
 Using SqlCa;
 
If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do Pre$$HEX1$$e700$$ENDHEX$$o de Custo do Produto '700733'.")
	Close(w_Aguarde)
	Return False
Else
	SqlCa.of_Commit();
End If 

Update consulta_rentabilidade_venda
	Set vl_preco_custo = round(vl_venda_liquida * 0.92, 2)
  From consulta_rentabilidade_venda
 Where cd_consulta = :ps_Consulta
   and cd_produto = 700734
   and qt_venda <> 0
 Using SqlCa;
 
If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do Pre$$HEX1$$e700$$ENDHEX$$o de Custo do Produto '700734'.")
	Close(w_Aguarde)
	Return False
Else
	SqlCa.of_Commit();
End If 

 Update consulta_rentabilidade_venda
	 Set vl_imposto = (case g.cd_tributacao_icms
				  				when '1' then round(v.qt_venda * (s.vl_custo_gerencial - s.vl_custo_medio), 2)
								else round(v.vl_venda_liquida * w.pc_icms / 100, 2)
				 			end) +
							(case g.id_situacao_pis_cofins
					  			when 'T' then round(v.vl_venda_liquida * (w.pc_pis_cofins / 100), 2)
					  			else 0
							end)
  From	consulta_rentabilidade_venda v,
	    		produto_geral g,
		 	saldo_produto s,
			vw_icms_produto_filial w
 Where cd_consulta 		= :ps_Consulta
     and v.cd_produto 		<> 684431
   	and v.cd_produto 		= g.cd_produto
 	and s.cd_filial			= v.cd_filial
  	and s.cd_produto		= v.cd_produto
  	and s.dh_saldo			= CONVERT( CHAR(6), v.dh_venda, 112 ) + '01'
	and w.cd_produto		= v.cd_produto
	and w.cd_filial			= v.cd_filial
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do Valor do Imposto.")
	Close(w_Aguarde)
	Return False
Else
	SqlCa.of_Commit();
End If 

If lvs_Id_Apresentacao_Filial <> "F" Then
	If Not wf_Atualiza_Vendas_Totalizadas(ps_consulta) Then
		Return False
	End If
End If

Return True
end function

public function string wf_monta_sql (string ps_consulta);String lvs_Select, &
		 lvs_From, &
		 lvs_Where		  , &
		 lvs_Group	  , &
		 lvs_Id_Apresentacao_Produto, &
		 lvs_Id_Apresentacao_Filial , &
		 lvs_Id_Apresentacao_Periodo, &
		 lvs_Sql, &
		 lvs_Data
		 
DateTime lvdh_Termino
		 
Integer lvi_File

dw_1.AcceptText()
lvs_Id_Apresentacao_Produto = dw_1.Object.Id_Apresentacao_Produto[1]
lvs_Id_Apresentacao_Filial  = dw_1.Object.Id_Apresentacao_Filial [1]
lvs_Id_Apresentacao_Periodo = dw_1.Object.Id_Apresentacao_Periodo[1]
lvdh_Termino 		    		 = dw_1.Object.Dh_Termino 		  		  [1]

// Determina a forma de apresenta$$HEX2$$e700e300$$ENDHEX$$o do per$$HEX1$$ed00$$ENDHEX$$odo
Choose Case lvs_Id_Apresentacao_Periodo
	Case "D"
		This.of_AppendSelect(lvs_Select, " v.dh_venda data2 ")
		This.of_AppendGroup(lvs_Group, " v.dh_venda ")
		
	Case "M"
		This.of_AppendSelect(lvs_Select, " convert(datetime, substring(convert(char(8), v.dh_venda, 112), 1, 6) + '01') data ")
		This.of_AppendGroup(lvs_Group, " convert(datetime, substring(convert(char(8), v.dh_venda, 112), 1, 6) + '01') ")
		
End Choose

This.of_AppendSelect(lvs_Select, "sum(v.qt_venda) qt_venda, " + &
											"sum(round(v.vl_venda_liquida, 2)) vl_venda, " + &
											"sum(v.vl_preco_custo) vl_cmv, " + &
											"sum(v.vl_comissao_liquida) vl_comissao, " + &
											"sum(vl_imposto) vl_imposto, " + &
											"(sum(v.vl_venda_liquida) - sum(v.vl_preco_custo) - sum(v.vl_comissao_liquida)" + &
											"  -sum(vl_imposto)) rentabilidade ")

This.of_AppendFrom(lvs_From, "consulta_rentabilidade_venda v (index pk_consulta_rentab_venda), " + &
									  "produto_geral g, " + &
									  "produto_central c, " + &
									  "vw_classificacao_produto w, " + &
									  "filial l ")
							
This.of_AppendWhere(lvs_Where, " v.cd_consulta = '" + ps_Consulta + "' " + &
										 "and g.cd_produto = v.cd_produto " + &
										 "and c.cd_produto = g.cd_produto " + &
										 "and w.cd_subcategoria = g.cd_subcategoria " + &
										 "and l.cd_filial =* v.cd_filial " + &
										 "and v.dh_venda is not null ")
					
Choose Case lvs_Id_Apresentacao_Produto
	Case '0' //Totalizado
		//This.of_AppendFrom(lvs_From, "consulta_rentabilidade_venda v (index pk_consulta_rentab_venda) ")
		//This.of_AppendWhere(lvs_Where, "v.cd_consulta = '" + ps_Consulta + "' ")
		
	Case '1' //Grupo
		This.of_AppendSelect(lvs_Select, "w.de_grupo")
		This.of_AppendGroup(lvs_Group  , "w.de_grupo")
		
	Case '2' //Subgrupo
		This.of_AppendSelect(lvs_Select, "w.de_grupo, w.de_subgrupo")
		This.of_AppendGroup(lvs_Group  , "w.de_grupo, w.de_subgrupo")
							 
	Case '3' //Categoria
		This.of_AppendSelect(lvs_Select, "w.cd_grupo, w.de_subgrupo, w.de_categoria")
		This.of_AppendGroup (lvs_Group, "w.cd_grupo, w.de_subgrupo, w.de_categoria")
							 		
	Case '4'
		This.of_AppendSelect(lvs_Select, "w.cd_grupo, w.de_subgrupo, w.de_categoria, w.de_subcategoria")
		This.of_AppendGroup(lvs_Group  , "w.cd_grupo, w.de_subgrupo, w.de_categoria, w.de_subcategoria")
							 
	Case '5'
		This.of_AppendSelect(lvs_Select, "w.de_grupo, " + &
													"w.de_subgrupo, " + &
													"w.de_categoria, " + &
													"w.de_subcategoria, " + &
													"g.cd_fornecedor_usual, " + &
													"f.nm_razao_social, " + &
													"g.cd_produto, " + &
													"g.de_produto, " + &
													"g.de_apresentacao_venda," + &
													" g.id_situacao, " + &
												   "g.de_codigo_barras, " + &
												   "(case g.id_lei_generico " + &
														  " when 'G' then 'GEN$$HEX1$$c900$$ENDHEX$$RICO' " + &
														  " when 'R' then 'REFER$$HEX1$$ca00$$ENDHEX$$NCIA' " + &
  														  " when 'E' then 'EQUIVALENTE' " + &
														  " when 'S' then 'SIMILAR' " + &
													 "end) id_lei_generico, " + &
													 "g.cd_planograma, " + &
													 "p.de_planograma ")
				
		This.of_AppendFrom(lvs_From, "fornecedor f")
		
		This.of_AppendFrom(lvs_From, "categoria_planograma p")

		This.of_Appendwhere(lvs_Where, "f.cd_fornecedor = g.cd_fornecedor_usual")
		
		This.of_Appendwhere(lvs_Where, "p.cd_planograma =* g.cd_planograma")

		This.of_AppendGroup(lvs_Group, "w.de_grupo, " + &
												 "w.de_subgrupo, " + &
												 "w.de_categoria, " + &
												 "w.de_subcategoria, " + &
												 "g.cd_fornecedor_usual, " + &
												 "f.nm_razao_social, " + &
												 "g.cd_produto, " + &
												 "g.de_produto, " + &
												 "g.de_apresentacao_venda, " + &
												 " g.id_situacao, " + &
											    "g.de_codigo_barras, " + &
												 "(case g.id_lei_generico " + &
														" when 'G' then 'GEN$$HEX1$$c900$$ENDHEX$$RICO' " + &
														" when 'R' then 'REFER$$HEX1$$ca00$$ENDHEX$$NCIA' " + &
														" when 'E' then 'EQUIVALENTE' " + &
														" when 'S' then 'SIMILAR' " + &
												 "end), " + &
												 "g.cd_planograma, " + &
												 "p.de_planograma ")
								
		If lvs_Id_Apresentacao_Periodo <> 'D' Then				
			This.of_AppendGroup(lvs_Group, "l.cd_filial, l.nm_fantasia")
		End If

	Case '6' // Lei Gen$$HEX1$$e900$$ENDHEX$$rico
		This.of_AppendSelect(lvs_Select, " (case g.id_lei_generico " + &
															"when 'R' then 'REFER$$HEX1$$ca00$$ENDHEX$$NCIA' " + &
															"when 'S' then 'SIMILAR' " + &
															"when 'E' then 'EQUIVALENTE' " + &
															"when 'G' then 'GEN$$HEX1$$c900$$ENDHEX$$RICO' " + &
														"end) id_lei_generico ")
										
		This.of_AppendGroup(lvs_Group, "g.id_lei_generico")
										
	Case '7' // Grupo & Lei Gen$$HEX1$$e900$$ENDHEX$$rico
		This.of_AppendSelect(lvs_Select, "w.de_grupo, " + &
														"(case g.id_lei_generico " + &
														"when 'R' then 'REFER$$HEX1$$ca00$$ENDHEX$$NCIA' " + &
														"when 'E' then 'EQUIVALENTE' " + &
														"when 'S' then 'SIMILAR' " + &
														"when 'G' then 'GEN$$HEX1$$c900$$ENDHEX$$RICO' " + &
													"end) id_lei_generico ")
										
		This.of_AppendGroup(lvs_Group, "w.de_grupo, g.id_lei_generico")
										
	Case '8' //Fornecedor & Lei Gen$$HEX1$$e900$$ENDHEX$$rico
		This.of_AppendSelect(lvs_Select, "g.cd_fornecedor_usual, " + &
											"		f.nm_razao_social, " + &
											"		(case g.id_lei_generico " + &
														"when 'R' then 'REFER$$HEX1$$ca00$$ENDHEX$$NCIA' " + &
														"when 'S' then 'SIMILAR' " + &
														"when 'E' then 'EQUIVALENTE' " + &
														"when 'G' then 'GEN$$HEX1$$c900$$ENDHEX$$RICO' " + &
													 "end) id_lei_generico ")
									 
		This.of_AppendFrom(lvs_From, "fornecedor f ")
									 
		This.of_AppendWhere(lvs_Where, "f.cd_fornecedor = g.cd_fornecedor_usual")
										
		This.of_AppendGroup(lvs_Group, "g.cd_fornecedor_usual, " + &
											 	  "f.nm_razao_social, " + &
												  "g.id_lei_generico ")
End Choose


If lvs_Id_Apresentacao_Filial = "F" Then	
	This.of_AppendSelect(lvs_Select,  "l.cd_filial, l.nm_fantasia ")
	This.of_AppendGroup(lvs_Group, "l.cd_filial, l.nm_fantasia")
						  
	If lvs_Id_Apresentacao_Produto = '0' Then
		//This.of_AppendFrom(lvs_From, "filial l")
		//This.of_AppendWhere(lvs_Where, "l.cd_filial =* v.cd_filial ")
	End If
	
End If
					
lvs_Sql = lvs_Select + " " + lvs_From + " " + lvs_Where + " " + lvs_Group

//Teste - Para ver o Sql que ser$$HEX1$$e100$$ENDHEX$$ executado. C:\temp\Montagem.sql
wf_Grava_Sql(lvs_Sql, "MONTAGEM")

Return lvs_Sql
end function

public function boolean wf_grava_produtos (long pl_consulta, string ps_consulta);Long lvl_Cont, & 
	  lvl_SubString, &
	  lvl_Id_Tipo_Selecao
	  
String lvs_Sql

dc_uo_ds_base lvds_1

If Not wf_Exclui_Produtos(ps_Consulta) Then Return False

lvs_Sql = "Select id_tipo_selecao, " + &
			 "			de_selecao " + &
			 "  From consulta_rentabilidade_selecao " + &
			 " Where cd_consulta = " + String(pl_Consulta)
			 
If Not wf_SyntaxFromSql(Ref lvds_1, lvs_Sql) Then
	Close(w_Aguarde)
	DesTroy(lvds_1)
	Return False
End If

If dw_1.Object.Cd_Fornecedor[1] = "C" Then
	Insert
     Into consulta_rentabilidade_produto
	  	    (cd_consulta, cd_produto)
   Select :ps_Consulta,
			 g.cd_produto
	  From produto_geral g,
			 consulta_rentabilidade_selecao s
	 Where s.id_tipo_selecao = 7
	   And s.cd_consulta		 = :pl_Consulta
	   And g.cd_fornecedor_usual = s.de_selecao
	   And Not Exists ( Select *
								 From consulta_rentabilidade_produto
							   Where cd_consulta = :ps_Consulta
								  And cd_produto = g.cd_produto)
	  Using SqlCa;
	  
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgDbError("Inclus$$HEX1$$e300$$ENDHEX$$o dos produtos selecionados.")
			Close(w_Aguarde)
			DesTroy(lvds_1)
			Return False
		End If	  
Else

	For lvl_Cont = 1 To lvds_1.RowCount()
		lvl_Id_Tipo_Selecao = Long(lvds_1.Object.Id_Tipo_Selecao[lvl_Cont])
		
		If lvl_Id_Tipo_Selecao = 6 Then
			Insert
			  Into consulta_rentabilidade_produto
					 (cd_consulta, cd_produto)
			 Select :ps_Consulta,
					  c.cd_produto
				From produto_central c,
				  	  consulta_rentabilidade_selecao s
			  Where s.id_tipo_selecao = 6
				 And s.cd_consulta		= :pl_Consulta
				 And c.cd_mix_produto  = convert(integer, s.de_selecao)
				 And Not Exists ( Select *
										  From consulta_rentabilidade_produto
										 Where cd_consulta = :ps_Consulta
											And cd_produto = c.cd_produto)
			Using SqlCa;
				
		ElseIf lvl_Id_Tipo_Selecao = 5 Then
			Insert
				Into consulta_rentabilidade_produto
					  (cd_consulta, cd_produto)
				Select :ps_Consulta,
						 convert(integer, s.de_selecao)
				  From consulta_rentabilidade_selecao s
				 Where s.cd_consulta = :pl_Consulta
				   And s.id_tipo_selecao = 5
				   And Not Exists ( Select *
											From consulta_rentabilidade_produto p
										  Where p.cd_consulta = :ps_Consulta
											 And p.cd_produto = convert(integer, s.de_selecao))
			Using SqlCa;
			
		Else
			Choose Case lvl_Id_Tipo_Selecao
				Case 1; lvl_SubString = 1
				Case 2; lvl_SubString = 3
				Case 3; lvl_SubString = 6
				Case 4; lvl_SubString = 9
			End Choose
			
			Insert
			  Into consulta_rentabilidade_produto
					  (cd_consulta, cd_produto)
			  Select :ps_Consulta,
						g.cd_produto
				 From produto_geral g,
						consulta_rentabilidade_selecao s
				Where s.id_tipo_selecao = :lvl_Id_Tipo_Selecao
				  And s.cd_consulta		= :pl_Consulta
				  And Substring(g.cd_subcategoria, 1, :lvl_SubString) = s.de_selecao
				  And Not Exists ( Select *
											From consulta_rentabilidade_produto
										  Where cd_consulta = :ps_Consulta
											 And cd_produto = g.cd_produto)
			Using SqlCa;
			
		End If
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgDbError("Inclus$$HEX1$$e300$$ENDHEX$$o dos produtos selecionados.")
			Close(w_Aguarde)
			DesTroy(lvds_1)
			Return False
		End If
	Next
	
End IF

Destroy(lvds_1)
Return True
end function

public function boolean wf_syntaxfromsql (ref dc_uo_ds_base pds_1, String ps_Sql);String lvs_Dw_Syntaxe, &
		 lvs_ERRO

SqlCa.AutoCommit = True
lvs_Dw_Syntaxe   = SqlCa.SyntaxFromSQL(ps_Sql, "", lvs_ERRO)

If LenA(lvs_ERRO) > 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "SyntaxFromSQL causou um erro : " + lvs_ERRO)
	Close(w_Aguarde)
	SqlCa.AutoCommit = False
	Return False
End If

SqlCa.AutoCommit = False

pds_1 = Create dc_uo_ds_base
If pds_1.Create(lvs_Dw_Syntaxe, lvs_ERRO) = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Ocorreram erros ao criar o objeto 'DataStore'.")
	Close(w_Aguarde)
	Return False
End If

pds_1.SetTransObject(SqlCa)
pds_1.Retrieve()

Return True
end function

public function boolean wf_grava_consulta_rentab_selecao (long pl_consulta);Boolean lvb_Insert = False

Long lvl_Linha, &
	  lvl_Id_Tipo_Selecao
	  
String lvs_Sql, &
		 lvs_De_Selecao

Delete 
  From consulta_rentabilidade_selecao
 Where cd_consulta = :pl_Consulta
 Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Exclus$$HEX1$$e300$$ENDHEX$$o das sele$$HEX2$$e700f500$$ENDHEX$$es de produtos.")
	Return False
End If

For lvl_Linha = 1 To ivo_Selecao.ivds_Selecao.RowCount()
	
	lvl_Id_Tipo_Selecao = ivo_Selecao.ivds_Selecao.Object.Id_Tipo_Selecao[lvl_Linha]
	lvs_De_Selecao 	  = ivo_Selecao.ivds_Selecao.Object.De_Selecao[lvl_Linha]
	
	If dw_1.Object.Cd_Fornecedor[1] = "C" Then
		If lvl_Id_Tipo_Selecao = 7 Then lvb_Insert = True
	Else
		If lvl_Id_Tipo_Selecao <> 7 Then lvb_Insert = True
	End If
	
	If lvb_Insert Then
			Insert
			  Into consulta_rentabilidade_selecao
						(cd_consulta,
						 id_tipo_selecao,
						 de_selecao)
			 Values (:pl_Consulta,
						:lvl_Id_Tipo_Selecao,
						:lvs_De_Selecao)
			   Using SqlCa;
		  
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgDbError("Inclus$$HEX1$$e300$$ENDHEX$$o das sele$$HEX2$$e700f500$$ENDHEX$$es de produtos.")
			Return False
		End If
		
		lvb_Insert = False
	End If
	
Next

Return True
end function

public subroutine wf_seleciona_fornecedor ();ivo_Selecao.ivs_Consulta = String(dw_1.Object.Cd_Consulta[1])

OpenWithParm(w_ge172_selecao_fornecedores, ivo_Selecao)

ivo_Selecao = Message.PowerObjectParm
end subroutine

public subroutine wf_seleciona_convenio ();ivo_Selecao.ivs_Consulta = String(dw_1.Object.Cd_Consulta[1])

OpenWithParm(w_ge173_selecao_convenios, ivo_Selecao)

ivo_Selecao = Message.PowerObjectParm
end subroutine

public function boolean wf_exclui_selecao (long pl_consulta);Delete
  From consulta_rentabilidade_selecao
 Where cd_consulta = :pl_Consulta
 Using SqlCa;
 
If SqlCa.SqlCode <> -1 Then 
	Return True
Else
	SqlCa.of_MsgDbError("EXCLUS$$HEX1$$c300$$ENDHEX$$O DO CONJUNTO DE PRODUTOS")
	Return False
End If
end function

public function boolean wf_exclui_produtos (string ps_parametro);Delete
  From consulta_rentabilidade_produto
 Where cd_consulta = :ps_Parametro
 Using SqlCa;
 
If SqlCa.SqlCode = -1 Then 
	SqlCa.of_MsgDbError("EXCLUS$$HEX1$$c300$$ENDHEX$$O DO CONJUNTO DE PRODUTOS")
	Return False
End If

Return True
end function

public subroutine wf_grava_sql (string ps_sql, string ps_operacao);integer li_FileNum

li_FileNum = FileOpen("C:\TEMP\" + ps_Operacao + ".TXT", LineMode!, Write!, LockWrite!, Replace!)
FileWrite(li_FileNum, ps_Sql)
FileClose(li_FileNum)
end subroutine

public subroutine wf_seleciona_filiais (string ps_operacao);Integer lvi_Linhas, &
        lvi_Row, &
		  lvi_Filial
		  
If Not IsValid(ivo_Filiais) Then ivo_Filiais = Create uo_ge216_Filiais

If ivo_Selecao.ivds_Selecao_Filial.RowCount() > 0 Then
	For lvi_Linhas = 1 To ivo_Selecao.ivds_Selecao_Filial.RowCount()
		ivo_Filiais.Cd_Filial[lvi_Linhas] = ivo_Selecao.ivds_Selecao_Filial.Object.Cd_Filial[lvi_Linhas]
	Next
End If

If ps_Operacao = 'INSERT' Then

	OpenWithParm(w_ge216_selecao_filiais, ivo_Filiais)
	
	//ivo_Filiais = Message.PowerObjectParm
End If

//lvi_Linhas = UpperBound(ivo_Filiais.Cd_Filial)
lvi_Linhas = Message.DoubleParm

If Not IsNull(lvi_Linhas) And lvi_Linhas > 0 Then
	For lvi_Row = 1 To lvi_Linhas	
		ivo_Selecao.ivl_Filiais[lvi_Row] = ivo_Filiais.Cd_Filial[lvi_Row]		
	Next
End If
end subroutine

public function long wf_erro_relatorio (long pl_consulta, string ps_consulta);SqlCa.of_RollBack()
w_Aguarde.Title = "Excluindo dados do relat$$HEX1$$f300$$ENDHEX$$rio anterior..."
wf_deleta_relatorio(pl_consulta, ps_consulta)
Close(w_Aguarde)

Return -1


end function

public subroutine of_appendgroup (ref string ps_sql, string ps_group);Long lvl_Posicao

lvl_Posicao = PosA(Upper(ps_SQL), "GROUP BY")

If ps_Group <> "" And Not IsNull(ps_Group) Then

	If lvl_Posicao = 0 Then
		ps_SQL += " GROUP BY " + ps_Group
	Else
		ps_SQL = MidA(ps_SQL, 1, lvl_Posicao + 8) + " " + ps_Group + ", " + &
					MidA(ps_SQL, lvl_Posicao + 9)
	End If
	
End If
end subroutine

public subroutine of_appendselect (ref string ps_sql, string ps_select);Long lvl_Posicao

If ps_Select <> "" And Not IsNull(ps_Select) Then

	lvl_Posicao = PosA(Upper(ps_SQL), "SELECT")
	
	If lvl_Posicao = 0 Then
		ps_SQL += "SELECT " + ps_Select
	Else
		ps_SQL = "SELECT " + ps_Select + "," + MidA(ps_Sql, 8)
	End If
	
End If
end subroutine

public subroutine of_appendfrom (ref string ps_sql, string ps_from);Long lvl_Posicao

lvl_Posicao = PosA(Upper(ps_SQL), "FROM")

If lvl_Posicao = 0 Then
	ps_SQL += " FROM " + ps_From
Else
	ps_SQL = MidA(ps_SQL, 1, lvl_Posicao + 4) + " " + ps_From + ", " + &
	         MidA(ps_SQL, lvl_Posicao + 5)
End If
end subroutine

public subroutine of_appendwhere (ref string ps_sql, string ps_where);Long lvl_Posicao

lvl_Posicao = PosA(Upper(ps_sql), "WHERE")

If lvl_Posicao = 0 Then
	ps_sql += " WHERE " + ps_Where
Else
	ps_sql = MidA(ps_sql, 1, lvl_Posicao + 5) + " " + ps_Where + " and " + &
	          MidA(ps_sql, lvl_Posicao + 6)
End If
end subroutine

public function boolean wf_atualiza_vendas_totalizadas (string ps_consulta);// Atualiza as devolu$$HEX2$$e700f500$$ENDHEX$$es
Update consulta_rentabilidade_venda2
Set qt_venda = qt_venda - d.qt_devolucao
From consulta_rentabilidade_venda2 v, consulta_rentabilidade_dev2 d
Where v.cd_consulta		= :ps_consulta
    and d.cd_consulta 		= v.cd_consulta
    and d.cd_filial			= v.cd_filial
    and d.cd_produto		= v.cd_produto
    and d.dh_devolucao	= v.dh_venda
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o das Vendas.")
	Close(w_Aguarde)
	Return False
Else
	SqlCa.of_Commit();
End If 

INSERT INTO consulta_rentabilidade_venda2  
         ( cd_consulta,   
           cd_filial,   
           cd_produto,   
           dh_venda,   
           vl_preco_venda,   
           vl_preco_custo,   
           qt_venda,   
           vl_venda_bruta,   
           vl_venda_liquida,   
           vl_comissao_bruta,   
           vl_comissao_liquida)  

Select  d.cd_consulta,
		 d.cd_filial,
		 d.cd_produto,
		 d.dh_devolucao,
		 0, 0,
		 d.qt_devolucao			* -1,
		 d.vl_devolucao_bruta	* -1,
		 d.vl_devolucao_liquida * -1,
		 d.vl_comissao_bruta		* -1,
		 d.vl_comissao_liquida	* -1
From consulta_rentabilidade_dev2 d
Where d.cd_consulta = :ps_consulta
  and not exists (Select * from consulta_rentabilidade_venda2 v
						Where d.cd_consulta 		= v.cd_consulta
						  	and d.cd_filial			= v.cd_filial
						  	and d.cd_produto		= v.cd_produto
						  	and d.dh_devolucao	= v.dh_venda)
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Inser$$HEX2$$e700e300$$ENDHEX$$o das Devolu$$HEX2$$e700f500$$ENDHEX$$es sem Vendas.")
	Close(w_Aguarde)
	Return False
End If



Update consulta_rentabilidade_venda2
Set v.vl_preco_venda = coalesce(round(g.vl_preco_venda_atual / g.vl_fator_conversao, 2),0),
    v.vl_preco_custo = coalesce(round(s.vl_custo_medio * v.qt_venda,2),0)
From consulta_rentabilidade_venda2 v,
     	produto_geral g,
	 	saldo_produto s
Where v.cd_consulta 	= :ps_Consulta
  and v.cd_produto 	<> 684431
  And g.cd_produto 	= v.cd_produto
  and s.cd_filial			= v.cd_filial
  and s.cd_produto		= v.cd_produto
  and s.dh_saldo		= CONVERT( CHAR(6), v.dh_venda, 112 ) + '01'
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do Pre$$HEX1$$e700$$ENDHEX$$o de Venda.")
	Close(w_Aguarde)
	Return False
Else
	SqlCa.of_Commit();
End If 

Update consulta_rentabilidade_venda2
   Set vl_preco_custo = round(vl_venda_liquida * 0.21, 2),
       vl_preco_venda = round(vl_venda_liquida / qt_venda, 2)
  From consulta_rentabilidade_venda2
 Where cd_consulta = :ps_Consulta
   and cd_produto = 684431
   and qt_venda <> 0
 Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do Pre$$HEX1$$e700$$ENDHEX$$o de Venda do Produto '684431'.")
	Close(w_Aguarde)
	Return False
Else
	SqlCa.of_Commit();
End If 

Update consulta_rentabilidade_venda2
   Set vl_preco_custo = round(vl_venda_liquida * 0.9142, 2)
  From consulta_rentabilidade_venda2
 Where cd_consulta = :ps_Consulta
   and cd_produto = 700733
   and qt_venda <> 0
 Using SqlCa;
 
If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do Pre$$HEX1$$e700$$ENDHEX$$o de Custo do Produto '700733'.")
	Close(w_Aguarde)
	Return False
Else
	SqlCa.of_Commit();
End If 

Update consulta_rentabilidade_venda2
	Set vl_preco_custo = round(vl_venda_liquida * 0.92, 2)
  From consulta_rentabilidade_venda2
 Where cd_consulta = :ps_Consulta
   and cd_produto = 700734
   and qt_venda <> 0
 Using SqlCa;
 
If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do Pre$$HEX1$$e700$$ENDHEX$$o de Custo do Produto '700734'.")
	Close(w_Aguarde)
	Return False
Else
	SqlCa.of_Commit();
End If 



 Update consulta_rentabilidade_venda2
	 Set vl_imposto = (case g.cd_tributacao_icms
				  				when '1' then round(v.qt_venda * (s.vl_custo_gerencial - s.vl_custo_medio), 2)
								else round(v.vl_venda_liquida * w.pc_icms / 100, 2)
				 			end) +
							(case g.id_situacao_pis_cofins
					  			when 'T' then round(v.vl_venda_liquida * (w.pc_pis_cofins / 100), 2)
					  			else 0
							end)
  From	consulta_rentabilidade_venda2 v, 
	    		produto_geral g,
		 	saldo_produto s,
			vw_icms_produto_filial w
 Where cd_consulta 		= :ps_Consulta
     and v.cd_produto 		<> 684431
   	and v.cd_produto 		= g.cd_produto
 	and s.cd_filial			= v.cd_filial
  	and s.cd_produto		= v.cd_produto
  	and s.dh_saldo			= CONVERT( CHAR(6), v.dh_venda, 112 ) + '01'
	and w.cd_produto		= v.cd_produto
	and w.cd_filial			= v.cd_filial
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do Valor do Imposto.")
	Close(w_Aguarde)
	Return False
Else
	SqlCa.of_Commit();
End If 

Long lvl_Linhas, lvl_Linha, lvl_Produto

Decimal lvdc_Preco_Venda, lvdc_Preco_Custo, lvdc_Imposto

Date lvdh_Venda

Boolean lvb_Sucesso = True

dc_uo_ds_base lvds

lvds = Create dc_uo_ds_base 

If Not lvds.of_ChangeDataObject("ds_ge289_lista_consulta_rentabilidade_venda2") Then
	Close(w_Aguarde)
	Return False
End If

lvl_Linhas = lvds.Retrieve(ps_Consulta)

If lvl_Linhas > 0 Then
	
	w_Aguarde.uo_Progress.of_SetMax(lvl_Linhas)
			
	For lvl_Linha = 1 To lvl_Linhas
	
		lvl_Produto 			= lvds.Object.cd_produto		[lvl_Linha]
		lvdh_Venda 			= Date(lvds.Object.dh_venda	[lvl_Linha])
		lvdc_Preco_Venda	= lvds.Object.vl_preco_venda	[lvl_Linha]
		lvdc_Preco_Custo	= lvds.Object.vl_preco_custo	[lvl_Linha]
		lvdc_Imposto		= lvds.Object.vl_imposto			[lvl_Linha]
		
		If IsNull(lvdc_Imposto) Then lvdc_Imposto = 0.00
		
		Update consulta_rentabilidade_venda
		Set  vl_preco_custo = :lvdc_Preco_Custo, 
				vl_preco_venda = :lvdc_Preco_Venda, 
				vl_imposto = :lvdc_Imposto
		Where cd_consulta 	= :ps_Consulta
			and cd_filial			= 0
			and cd_produto 	= :lvl_Produto
			and dh_venda		= :lvdh_Venda
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o dos Valores Totalizados.")
			Close(w_Aguarde)
			lvb_Sucesso = False
			Exit
		Else
			SqlCa.of_Commit();
		End If 
		
		w_Aguarde.Title = "Atualizando Vendas: Produto " + String(lvl_Linha) + " at$$HEX1$$e900$$ENDHEX$$ " + String(lvl_Linhas)
		w_Aguarde.uo_Progress.of_SetProgress(lvl_Linha)		
	Next
	
	w_Aguarde.uo_Progress.of_Reset()
	
	If Not lvb_Sucesso Then Return False
	
Else
	Close(w_Aguarde)
	Return False
End If

Return True
end function

on w_ge289_cadastro_relatorio.create
int iCurrent
call super::create
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
end on

on w_ge289_cadastro_relatorio.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_2)
end on

event open;call super::open;ivo_dbError	 = Create dc_uo_dbError
//ivo_Filiais	 = Create uo_Selecao_Filiais
ivo_Promocao = Create uo_Promocao
ivo_Consulta = Create uo_ge289_Consulta_Rentabilidade

//dw_1.Object.St_Tipo_Venda.Visible = False
//dw_1.Object.Id_Tipo_Venda.Visible = False
end event

event close;call super::close;Destroy(ivo_Filiais)
Destroy(ivo_Promocao)
Destroy(ivo_Consulta)
Destroy(ivo_Selecao)
end event

event ue_postopen;//OverRide

dw_1.Event ue_AddRow()
dw_1.SetFocus()

This.ivm_Menu.mf_Incluir(True)
This.ivm_Menu.mf_Recuperar(True)
end event

event ue_save;//OverRide
Boolean lvb_Commit = True

Long lvl_Consulta, &
	  lvl_Cd_Promocao
	  
String lvs_Consulta
	
Setpointer(HourGlass!)
Open(w_Aguarde)
w_Aguarde.Title = "Aguarde..."

dw_1.AcceptText()

If dw_1.RowCount() < 1 Then Return -1

If dw_1.Object.id_selecao_produto[1] = "C" Then
	If Not IsValid(ivo_Selecao) Then	lvb_Commit = False
End If

If dw_1.RowCount() > 0 And lvb_Commit And Not ivb_Excluindo Then
	If Not wf_valida_data() Then
		lvb_Commit = False		
	Else
		
		lvl_Consulta 	 = dw_1.Object.Cd_Consulta[1]
		lvl_Cd_Promocao = dw_1.Object.Cd_Promocao[1]
	
		If IsNull(lvl_Consulta) Then
			wf_Proximo_Codigo(Ref lvl_Consulta)
			dw_1.Object.Cd_Consulta[1] = lvl_Consulta
			
			w_Aguarde.Title = "Gravando a consulta..."	
			If Not wf_Grava_Consulta(lvl_Consulta) Then lvb_Commit = False
			
		Else
			w_Aguarde.Title = "Atualizando a consulta..."
			If Not wf_Atualiza_Consulta(lvl_Consulta) Then lvb_Commit = False
		End If
		
		If lvb_Commit Then
			
			lvs_Consulta = gvo_Aplicacao.ivo_Seguranca.Nr_Matricula + "_" + String(lvl_Consulta, '000')
			
			If IsNull(lvl_Cd_Promocao) Then
				
				w_Aguarde.Title = "Gravando as filiais selecionadas, aguarde..."
				
				If dw_1.Object.id_selecao_filial[1] = "C" Then					
					If Not wf_grava_filiais(lvl_Consulta) Then lvb_Commit = False
				Else
					If Not wf_Exclui_Filiais(lvl_Consulta) Then lvb_Commit = False
				End If
				
				If lvb_Commit Then
					w_Aguarde.Title = "Excluindo produtos..."
					If Not wf_exclui_produtos(lvs_Consulta) Then lvb_Commit = False
					
					If IsValid(ivo_Selecao) And lvb_Commit Then
						w_Aguarde.Title = "Gravando as sele$$HEX2$$e700f500$$ENDHEX$$es de produtos..."
						If Not wf_Grava_Consulta_Rentab_Selecao(lvl_Consulta) Then lvb_Commit = False
					End If
				End If
			End If
		End If
	End If
	
	If lvb_Commit Then
		w_Aguarde.Title = "Efetivendo a grava$$HEX2$$e700e300$$ENDHEX$$o da consulta..."
		SqlCa.of_Commit()
		Close(w_Aguarde)
		ivm_Menu.mf_Confirmar(False)
		ivm_Menu.mf_Cancelar(False)
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Altera$$HEX2$$e700f500$$ENDHEX$$es efetuadas com sucesso.")
		dw_1.SetFocus()
		Return 1
	Else
		SqlCa.of_RollBack()
		Close(w_Aguarde)
		Return -1
	End If
End If
end event

event ue_cancel;call super::ue_cancel;SqlCa.of_RollBack()
end event

type dw_visual from dc_w_cadastro_freeform`dw_visual within w_ge289_cadastro_relatorio
end type

type gb_aux_visual from dc_w_cadastro_freeform`gb_aux_visual within w_ge289_cadastro_relatorio
end type

type dw_1 from dc_w_cadastro_freeform`dw_1 within w_ge289_cadastro_relatorio
event ue_popula_ds_selecao ( string ps_evento )
integer x = 41
integer y = 56
integer width = 1920
integer height = 1068
string dataobject = "dw_ge289_selecao"
boolean vscrollbar = false
end type

event dw_1::ue_popula_ds_selecao;String lvs_Sql_Selecao, &
		 lvs_Sql_Filiais

This.AcceptText()

lvs_Sql_Selecao = "Select	cd_consulta, " + &
							  "id_tipo_selecao, " + &
							  "de_selecao " + &
						"From consulta_rentabilidade_selecao "
						
lvs_Sql_Filiais = "Select cd_consulta, " + &
							  "cd_filial " + &
						"From consulta_rentabilidade_filial "							

If ps_Evento = 'I' Then
	lvs_Sql_Selecao += "Where cd_consulta is null"							
	lvs_Sql_Filiais += "Where cd_consulta is null"				
Else
	lvs_Sql_Selecao += "Where cd_consulta = " + String(This.Object.Cd_Consulta[1])
	lvs_Sql_Filiais += "Where cd_consulta = " + String(This.Object.Cd_Consulta[1])
End If
				
wf_SyntaxFromSql(Ref ivo_Selecao.ivds_Selecao, lvs_Sql_Selecao)
wf_SyntaxFromSql(Ref ivo_Selecao.ivds_Selecao_Filial, lvs_Sql_Filiais)
end event

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
		
	Case 'id_selecao_filial'
		If Data = "C" Then //Conjunto de Filiais
			wf_Seleciona_Filiais('INSERT')
		ElseIf Data = "N" Then //Nenhuma
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A op$$HEX2$$e700e300$$ENDHEX$$o 'NENHUMA' s$$HEX1$$f300$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ dipon$$HEX1$$ed00$$ENDHEX$$vel quando existir uma promo$$HEX2$$e700e300$$ENDHEX$$o selecionada.")
			This.Event ue_Pos(1, "de_promocao")
			
			If ivi_Tipo_Cancelar = RETRIEVE Then
					This.Object.Id_Selecao_Filial[1] = ivs_Id_Selecao_Filial
				Else
				This.Object.Id_Selecao_Filial[1] = "T"
			End If
			
			Return 1
		Else //TODAS
			Destroy(ivo_Filiais)
		End If
		
		Case 'id_selecao_produto'
			If Data = "C" Then //Conjunto de Produtos
				wf_Seleciona_Produtos()
			ElseIf Data = "N" Then //Nenhum
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A op$$HEX2$$e700e300$$ENDHEX$$o 'NENHUM' s$$HEX1$$f300$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ dipon$$HEX1$$ed00$$ENDHEX$$vel quando existir uma promo$$HEX2$$e700e300$$ENDHEX$$o selecionada.")
				This.Event ue_Pos(1, "de_promocao")
				
				If ivi_Tipo_Cancelar = RETRIEVE Then
					This.Object.Id_Selecao_Produto [1] = ivs_Id_Selecao_Produto
				Else
					This.Object.Id_Selecao_Produto[1] = "T"
				End If
				
				Return 1
			End If
			
//		Case 'id_tipo_venda'
//			If Data = '02' Then //Conv$$HEX1$$ea00$$ENDHEX$$nio
//				This.Object.Cd_Fornecedor[1] = "T"
//				wf_seleciona_convenio()
//			End If
		
	Case 'de_promocao'
		If Not IsNull(Data) Or Trim(Data) <> "" Then
			If Data <> ivo_Promocao.Nm_Promocao Then
				Return 1
			End If
		Else
			
			ivo_Promocao.of_Inicializa()
			This.Object.De_Promocao[1] = ivo_Promocao.Nm_Promocao
			This.Object.Cd_Promocao[1] = ivo_Promocao.Cd_Promocao
			
			If ivi_Tipo_Cancelar = RETRIEVE Then
				This.Object.Id_Selecao_Filial [1] = ivs_Id_Selecao_Filial
				This.Object.Id_Selecao_Produto[1] = ivs_Id_Selecao_Produto
				This.Object.Cd_Fornecedor		[1] = ivs_Selecao_Fornecedor
			Else				
				This.Object.Id_Selecao_Filial [1] = 'T'
				This.Object.Id_Selecao_Produto[1] = 'T'
				This.Object.Cd_Fornecedor		[1] = 'T'
			End If
			
		End If
				
	Case 'cd_fornecedor'
		If Data = "C" Then
			wf_Seleciona_Fornecedor()
		End If

End Choose
end event

event dw_1::constructor;call super::constructor;This.ivs_Coluna_Sem_Validacao_Salva = {"localizacao"}

This.of_SetColSelection(True)
end event

event dw_1::ue_key;String lvs_Texto

If Key = KeyEnter! Then
	
	lvs_Texto = This.GetText()
	
	Choose Case This.GetColumnName()
		Case "localizacao"
  		   ivo_Consulta.of_Localiza(lvs_Texto)
			  
			This.Object.localizacao[1] = ""  
			  
			If ivo_Consulta.Localizada Then
				This.Object.de_consulta[1] = ivo_Consulta.De_Consulta
				This.Object.cd_consulta[1] = ivo_Consulta.Cd_Consulta
				This.Event ue_Retrieve()
			End If
		
		Case "de_promocao"
  		   ivo_Promocao.of_Localiza(lvs_Texto)

			If ivo_Promocao.Localizado Then
				This.Object.cd_promocao			[1] = ivo_Promocao.Cd_Promocao
				This.Object.de_promocao			[1] = ivo_Promocao.Nm_Promocao
				This.Object.id_selecao_produto[1] = 'N'
				This.Object.id_selecao_filial [1] = 'N'				
			End If
			
		Case "cd_fornecedor"
			wf_Seleciona_Fornecedor()
			
	End Choose
End If
end event

event dw_1::losefocus;call super::losefocus;This.Object.Localizacao[1] = ""

If IsValid(ivo_Promocao) Then
	This.Object.De_Promocao[1] = ivo_Promocao.Nm_Promocao
	This.Object.Cd_Promocao[1] = ivo_Promocao.Cd_Promocao
End If
end event

event dw_1::ue_preupdate;call super::ue_preupdate;Long lvl_Cd_Consulta, &
	  lvl_Linha
	  
dw_1.AcceptText()

If This.RowCount() > 0 Then
	If IsNull(This.Object.Cd_Consulta[1]) Then
		wf_Proximo_Codigo(Ref lvl_Cd_Consulta)
		This.Object.Cd_Consulta[1] = lvl_Cd_Consulta
	End If
End If

Return 1
end event

event dw_1::ue_postretrieve;call super::ue_postretrieve;Long lvl_Promocao

String lvs_Fornecedor

If pl_Linhas > 0 Then
	Parent.ivm_Menu.mf_Excluir(True)
	
	lvs_Fornecedor	= This.Object.Cd_Fornecedor[1]

	If lvs_Fornecedor = "C" Then
		This.Object.Id_Selecao_produto[1] = "T"
	End If

	lvl_Promocao = This.Object.Cd_Promocao[1]
	
	//Vari$$HEX1$$e100$$ENDHEX$$veis para controle do evento ue_Cancel
	ivs_Id_Selecao_Filial  = This.Object.Id_Selecao_Filial [1]
	ivs_Id_Selecao_Produto = This.Object.Id_Selecao_Produto[1]
	ivs_Selecao_Fornecedor = This.Object.Cd_Fornecedor		 [1]
	//-------
	
	If Not IsNull(lvl_Promocao) Then
		ivo_Promocao.of_Localiza_Codigo(lvl_Promocao)
	Else
		ivo_Promocao.of_Inicializa()
		If Not wf_Recupera_Filiais() Then Return -1
	End If
	This.Object.de_promocao[1] = ivo_Promocao.Nm_Promocao
	
	Destroy(ivo_Selecao)
	ivo_Selecao	= Create uo_ge229_selecao_prd_personalizado
Else
	Parent.ivm_Menu.mf_Excluir(False)
End If

This.Event ue_Popula_Ds_Selecao("R")
Destroy(ivo_Filiais)
ivo_Filiais = Create uo_ge216_Filiais

Return pl_Linhas
end event

event dw_1::ue_recuperar;//OverRide
Long lvl_Cd_Consulta

lvl_Cd_Consulta = This.Object.cd_consulta[1]

Return This.Retrieve(lvl_Cd_Consulta)
end event

event dw_1::ue_preretrieve;call super::ue_preretrieve;Long lvl_Cd_Consulta

lvl_Cd_Consulta = This.Object.cd_consulta[1]

If IsNull(lvl_Cd_Consulta) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma consulta para recuperar as informa$$HEX2$$e700f500$$ENDHEX$$es.")
	Return -1
End If

Return 1
end event

event dw_1::ue_predeleterow;call super::ue_predeleterow;Long lvl_Cd_Consulta

String lvs_Consulta

ivb_Excluindo = True

lvl_Cd_Consulta = dw_1.Object.Cd_Consulta[1]
lvs_Consulta = gvo_Aplicacao.ivo_Seguranca.Nr_Matricula + "_" + String(lvl_Cd_Consulta, '000')

If Not IsNull(lvl_Cd_Consulta) Then
	
	If This.Object.Id_Selecao_Filial[1] = "C" Then
		If Not wf_exclui_filiais(lvl_Cd_Consulta) Then Return False
	End If
		
	If This.Object.Id_Selecao_Produto[1] = "C" Then
		If Not wf_exclui_produtos(lvs_Consulta) Then Return False
		If Not wf_exclui_selecao(lvl_Cd_Consulta) Then Return False
	End If
	
	If This.Object.Cd_Fornecedor[1] = "C" Then
		If Not wf_exclui_selecao(lvl_Cd_Consulta) Then Return False
	End If

	Delete
	  From consulta_rentabilidade
	 Where cd_consulta = :lvl_Cd_Consulta
	 Using SqlCa;
	 
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgDbError("EXCLUS$$HEX1$$c300$$ENDHEX$$O DA CONSULTA")
		Return False
	Else
		SqlCa.of_Commit()
	End If
	
End If

Return True
end event

event dw_1::ue_reset;call super::ue_reset;ivo_Promocao.of_Inicializa()
ivo_Consulta.of_Inicializa()
end event

event dw_1::ue_preinsertrow;call super::ue_preinsertrow;Destroy(ivo_Selecao)
ivo_Selecao	= Create uo_ge229_selecao_prd_personalizado
This.Event ue_Popula_Ds_Selecao("I")

Return 1
end event

event dw_1::ue_deleterow;call super::ue_deleterow;ivb_Excluindo = False

Return True
end event

type gb_1 from dc_w_cadastro_freeform`gb_1 within w_ge289_cadastro_relatorio
integer x = 23
integer y = 0
integer width = 1970
integer height = 1144
integer taborder = 20
end type

type cb_2 from commandbutton within w_ge289_cadastro_relatorio
integer x = 1417
integer y = 1168
integer width = 576
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Gerar Relat$$HEX1$$f300$$ENDHEX$$rio"
end type

event clicked;Integer lvi_File

Long lvl_Consulta, &
	  lvl_Pos,&
	  	ll_Retorno

String lvs_ERRO, &
		 lvs_Sql, &
		 lvs_Dw_Syntaxe, &
		 lvs_Consulta , &
		 lvs_Id_Tipo_Venda
		 
dc_uo_ds_base lvds_1

If m_Janelas.m_Editar.m_ConfirmarOperacao.Enabled = True Then
	If Parent.Event ue_Save() = -1 Then Return
Else
	wf_Seleciona_Filiais('RETRIEVE')
End If
		 
dw_1.AcceptText()
lvl_Consulta      = dw_1.Object.Cd_Consulta  [1]
lvs_Id_Tipo_Venda = dw_1.Object.Id_Tipo_Venda[1]

lvs_Consulta = gvo_Aplicacao.ivo_Seguranca.Nr_Matricula + "_" + String(lvl_Consulta, '000')

SetPointer(HourGlass!)
Open(w_Aguarde)

//Apaga no in$$HEX1$$ed00$$ENDHEX$$cio para n$$HEX1$$e300$$ENDHEX$$o tentar inserir o mesmo registro mais de uma vez
w_Aguarde.Title = "Excluindo dados do relat$$HEX1$$f300$$ENDHEX$$rio anterior..."
wf_deleta_relatorio(lvl_Consulta, lvs_Consulta)

w_Aguarde.Title = "Gravando produtos para o relat$$HEX1$$f300$$ENDHEX$$rio..."	
If Not wf_Grava_Produtos(lvl_Consulta, lvs_Consulta) Then Return wf_Erro_Relatorio(lvl_Consulta, lvs_Consulta)
	
w_Aguarde.Title = "Selecionando vendas..."
If Not wf_executa_sql_venda(lvl_Consulta, lvs_Consulta) Then Return wf_Erro_Relatorio(lvl_Consulta, lvs_Consulta)

w_Aguarde.Title = "Selecionando devolu$$HEX2$$e700f500$$ENDHEX$$es..."		
If Not wf_executa_sql_dev(lvl_Consulta, lvs_Consulta) Then Return wf_Erro_Relatorio(lvl_Consulta, lvs_Consulta)
		
w_Aguarde.Title = "Atualizando vendas..."
If Not wf_Atualiza_Vendas(lvl_Consulta, lvs_Consulta) Then Return wf_Erro_Relatorio(lvl_Consulta, lvs_Consulta)
				
w_Aguarde.Title = "Extraindo dados para o relat$$HEX1$$f300$$ENDHEX$$rio, aguarde..."
lvs_Sql = wf_Monta_Sql(lvs_Consulta)
				
If Not wf_SyntaxFromSql(Ref lvds_1, lvs_Sql) Then Return wf_Erro_Relatorio(lvl_Consulta, lvs_Consulta)
				
If lvds_1.RowCount() > 0 Then
	lvds_1.of_SaveAs("")
	//If lvds_1.SaveAs("c:\rentabilidade.txt", Text!, TRUE) = -1 Then
	//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "erro")
	//End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma Informa$$HEX2$$e700e300$$ENDHEX$$o Cadastrada.")
End If
				
w_Aguarde.Title = "Excluindo dados do relat$$HEX1$$f300$$ENDHEX$$rio anterior..."
wf_deleta_relatorio(lvl_Consulta, lvs_Consulta)
				
Close(w_Aguarde)
	
SetPointer(Arrow!)
end event

