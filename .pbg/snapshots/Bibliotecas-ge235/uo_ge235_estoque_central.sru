HA$PBExportHeader$uo_ge235_estoque_central.sru
forward
global type uo_ge235_estoque_central from nonvisualobject
end type
end forward

global type uo_ge235_estoque_central from nonvisualobject
end type
global uo_ge235_estoque_central uo_ge235_estoque_central

type variables
date idt_inicio, idt_termino

Long il_Filial
end variables

forward prototypes
public function boolean of_atualiza_termino_processo (long al_filial, integer ai_log)
public function boolean of_inclui_produtos (long al_filial, integer ai_log)
public subroutine of_atualiza_estoque_base ()
public function boolean of_grava_posicao_atual (long al_filial, integer ai_log)
public function boolean of_atualiza_inicio_processo (long al_filial, integer ai_log)
public function boolean of_exclui_produtos (long al_filial, integer ai_log)
public function boolean of_atualiza_vendas (long al_filial, integer ai_log)
public function boolean of_venda_produto (long al_filial, long al_produto, date adt_inicio, date adt_termino, ref long al_venda, integer ai_log)
public function boolean of_venda_produto (long al_filial, long al_produto, datetime adh_periodo[6, 2], ref long al_venda[6], integer ai_log)
public function boolean of_atualiza_classe_reposicao (long al_filial, integer ai_log, string as_subcategoria)
public function boolean of_atualiza_classe_reposicao (long al_filial, integer ai_log)
private function boolean of_atualiza_estoque_base (long al_filial, integer ai_log)
public function boolean of_periodo_reposicao (integer al_filial, string as_tipo, ref datetime adh_base[6, 2], integer ai_log)
public function boolean of_atualiza_periodos (long al_filial, date adt_recalculo, integer ai_log)
public function boolean of_venda_produto_estavel (long al_produto, ref long al_venda, date adt_inicio, date adt_termino)
public function boolean of_atualiza_classe_reposicao_produto (long al_filial, integer ai_log)
public function boolean of_grava_log (integer ai_arquivo, string as_mensagem, boolean ab_envia_email)
public function date of_mes (date adt_mes_base, integer ai_numero)
public function boolean of_classe_perini ()
end prototypes

public function boolean of_atualiza_termino_processo (long al_filial, integer ai_log);Boolean lvb_Sucesso = False

w_ge235_aguarde.st_Processo.Text = "Atualizando o T$$HEX1$$e900$$ENDHEX$$rmino do Processo..."

Update parametro_reposicao_estoque
Set dh_termino_calculo   = getdate(),
    dh_proximo_calculo   = dateadd(day, 17, dh_termino_periodo_6),
	 id_periodos_atualizados = 'N'
Where cd_filial = :al_Filial
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	This.of_Grava_Log(ai_Log, "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o da data de t$$HEX1$$e900$$ENDHEX$$rmino do processo. " + SqlCa.SqlErrText, True)
Else
	lvb_Sucesso = True
End If

Return lvb_Sucesso
end function

public function boolean of_inclui_produtos (long al_filial, integer ai_log);String lvs_Mensagem
		 
w_ge235_aguarde.st_Processo.Text = "Incluindo Produtos no Resumo..."

Insert Into resumo_reposicao_estoque (cd_filial,   
												  cd_produto,   
												  id_tipo_reposicao,   
												  qt_venda_periodo_1,   
												  qt_venda_periodo_2,   
												  qt_venda_periodo_3,   
												  qt_venda_periodo_4,   
												  qt_venda_periodo_5,   
												  qt_venda_periodo_6,   
												  cd_classe_reposicao,   
												  qt_demanda_diaria,   
												  qt_dias_cobertura,
												  qt_estoque_base_inicial,   
												  qt_estoque_base_anterior,   
												  qt_estoque_calculado,   
												  qt_estoque_minimo,   
												  qt_estoque_base,
												  id_nivel_estoque_minimo,   
												  id_geracao_pedido,
												  id_alteracao,
												  qt_estoque_base_definido)  
select	:al_Filial,  
			g.cd_produto,   
		 	c.id_tipo_reposicao_estoque,
		 	  0, 0, 0, 0, 0, 0,   
			  'C',
			  0,
			  0,   
			  0,   
			  0,   
			  0,   
			  0,
			  0, 
			  '0',   
			  'S', 
			  'N',
			  0
From produto_geral g
inner join produto_central c on c.cd_produto = g.cd_produto
Where g.id_situacao = 'A'
	//and substring(g.cd_subcategoria, 1,1) = '3'
	and not exists (select * from resumo_reposicao_estoque r
							where r.cd_filial = :al_filial
								and r.cd_produto = g.cd_produto)
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	lvs_Mensagem = "Erro na inclus$$HEX1$$e300$$ENDHEX$$o dos produtos ATIVOS. " + SqlCa.SqlErrText
	This.of_Grava_Log(ai_Log, lvs_Mensagem, True)
	w_ge235_aguarde.uo_Progress.of_Reset()
	Return False
End If
		
w_ge235_aguarde.uo_Progress.of_Reset()

Return True
end function

public subroutine of_atualiza_estoque_base ();Long lvl_Total, &
     	lvl_Contador,&
		lvl_Filial

String lvs_Arquivo

Integer lvi_Log

Date lvdt_Parametro

lvdt_Parametro = Date(gf_GetServerDate())

lvs_Arquivo = gvo_Aplicacao.ivs_Path_Arquivos + "calculo_estoque_MATRIZ.log"

lvi_Log = FileOpen(lvs_Arquivo, LineMode!, Write!, LockWrite!, Append!)

If lvi_Log = -1 or IsNull(lvi_Log) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na abertura do arquivo de log '" + lvs_Arquivo + "'.", StopSign!)
	Return
End If

SetPointer(HourGlass!)

Open(w_ge235_aguarde)
w_ge235_aguarde.Title = "Atualizando Curva ABC da Matriz..."

lvl_Filial = 1534

il_Filial = 1534

//This.of_Grava_Log(lvi_Log, "In$$HEX1$$ed00$$ENDHEX$$cio Data Base '" + String(lvdt_Parametro, "dd/mm/yyyy") + "'", True)

If lvl_Filial = 1534 Then
	If This.of_atualiza_periodos(lvl_Filial,lvdt_Parametro,lvi_Log ) Then
		This.of_Atualiza_Estoque_Base(lvl_Filial,lvi_Log)
	End If
Else
	//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Este procedimento s$$HEX1$$f300$$ENDHEX$$ pode ser realizado para a filial 1534.", StopSign!)
	This.of_Grava_Log(lvi_Log, "Este procedimento s$$HEX1$$f300$$ENDHEX$$ pode ser realizado para a filial 1534.", True)
End If
	
//This.of_Grava_Log(lvi_Log, "T$$HEX1$$e900$$ENDHEX$$rmino Data Base '" + String(lvdt_Parametro, "dd/mm/yyyy") + "'", True)

FileClose(lvi_Log)

Close(w_ge235_aguarde)

SetPointer(Arrow!)
end subroutine

public function boolean of_grava_posicao_atual (long al_filial, integer ai_log);String lvs_Mensagem

w_ge235_aguarde.st_Processo.Text = "Gravando Posi$$HEX2$$e700e300$$ENDHEX$$o Atual dos Produtos..."

Update resumo_reposicao_estoque
Set	qt_vendas_periodos_anterior = qt_venda_periodo_1 + qt_venda_periodo_2 + qt_venda_periodo_3 + qt_venda_periodo_4 + qt_venda_periodo_5 + qt_venda_periodo_6,
		qt_demanda_diaria_anterior = qt_demanda_diaria, cd_classe_reposicao_anterior = cd_classe_reposicao
Where cd_filial =:al_Filial
Using SqlCA;

If SqlCa.SqlCode = -1 Then
	lvs_Mensagem = "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o da posi$$HEX2$$e700e300$$ENDHEX$$o atual dos produtos. " + SqlCa.SqlErrText
	This.of_Grava_Log(ai_Log, lvs_Mensagem, True)
	Return False
End If

Return True
end function

public function boolean of_atualiza_inicio_processo (long al_filial, integer ai_log);// Atualiza a data de in$$HEX1$$ed00$$ENDHEX$$cio do processo
Update parametro_reposicao_estoque
Set dh_inicio_calculo    = getdate(),
    dh_termino_calculo   = null
Where cd_filial = :al_Filial
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	This.of_Grava_Log(ai_Log, "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o da data de in$$HEX1$$ed00$$ENDHEX$$cio do processo. " + SqlCa.SqlErrText, True)
	Return False
End If

Return True
end function

public function boolean of_exclui_produtos (long al_filial, integer ai_log);String lvs_Mensagem

w_ge235_aguarde.st_Processo.Text = "Excluindo Produtos do Resumo..."

Delete From resumo_reposicao_estoque
Where cd_filial  		= :al_Filial
 // and cd_produto 	in (select cd_produto from produto_geral where id_situacao <> 'A')
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	lvs_Mensagem = "Erro na exclus$$HEX1$$e300$$ENDHEX$$o dos produtos  INATIVOS. " + SqlCa.SqlErrText
	This.of_Grava_Log(ai_Log, lvs_Mensagem, True)
	Return False
End If

w_ge235_aguarde.uo_Progress.of_Reset()

Return True
end function

public function boolean of_atualiza_vendas (long al_filial, integer ai_log); Boolean lvb_Sucesso = True
 
 Date lvdt_Inicio, lvdt_Termino

Long	lvl_Total, &
     	lvl_Contador, &
	 	lvl_Produto, &
	 	lvl_Venda[6],&
		 ll_Contador,&
		 ll_Qtde_Venda
	  
String	lvs_Mensagem, &
       		lvs_Tipo

DateTime lvdh_Estavel[6, 2], &
         lvdh_Sazonal[6, 2], &
			lvdh_Periodo[6, 2]
			
If Not This.of_Periodo_Reposicao(al_Filial, "E", ref lvdh_Estavel, ai_Log) Then Return False
If Not This.of_Periodo_Reposicao(al_Filial, "S", ref lvdh_Sazonal, ai_Log) Then Return False

dc_uo_ds_Base lvds_1
lvds_1 = Create dc_uo_ds_Base

If Not lvds_1.of_ChangeDataObject("dw_ge235_atualizacao_venda") Then
	lvs_Mensagem = "Erro na troca da dw de atualiza$$HEX2$$e700e300$$ENDHEX$$o das vendas"
	This.of_Grava_Log(ai_Log, lvs_Mensagem, True)
	Destroy(lvds_1)
	Return False
End If

w_ge235_aguarde.st_Processo.Text = "Atualizando as Vendas do Resumo..."

lvl_Total = lvds_1.Retrieve(al_Filial)

If lvl_Total > 0 Then
	w_ge235_aguarde.uo_Progress.of_SetMax(lvl_Total)
	
	For lvl_Contador = 1 To lvl_Total
		
		Yield ( )
		
		lvl_Produto           = lvds_1.Object.Cd_Produto               [lvl_Contador]
		lvs_Tipo              = lvds_1.Object.Id_Tipo_Reposicao_Estoque[lvl_Contador]		
			
		// Verifica as vendas do produto
		If lvs_Tipo = "E" Then
			lvdh_Periodo = lvdh_Estavel
		Else
			lvdh_Periodo = lvdh_Sazonal
		End If
		
		If lvs_Tipo = "E" Then
//			lvdt_Inicio			= Date("01/06/2014")
//			lvdt_Termino		= Date("01/08/2014")
			
			lvdt_Inicio			= idt_inicio
			lvdt_Termino		= idt_termino
			
			If Not This.of_Venda_Produto_Estavel( lvl_Produto, ref ll_Qtde_Venda, lvdt_Inicio, lvdt_Termino) Then
				lvb_Sucesso = False
				Exit
			End If
			
			Update resumo_reposicao_estoque
			Set qt_venda_periodo_1       = :ll_Qtde_Venda,
				 cd_classe_reposicao      = 'C',
				 id_tipo_reposicao        = :lvs_Tipo,
				 qt_demanda_diaria        = 0,
				 qt_estoque_minimo        = 0,
				 id_nivel_estoque_minimo  = '0',
				 id_geracao_pedido        = 'S',				 
				 qt_estoque_base_anterior = qt_estoque_base,				 
				 qt_estoque_base_definido = 0,				 
				 qt_estoque_base          = 0,				 
				 id_alteracao             = 'N',
				 dh_alteracao             = null,
				 nr_matricula_alteracao   = null,
				 dh_termino_bloqueio      = null,
				 id_atualizacao           = 'S',
				 id_utilizado_eb_definido = 'N'
			Where cd_filial  = :al_Filial
			  and cd_produto = :lvl_Produto
			Using SqlCa;
			
		Else
			If Not This.of_Venda_Produto(al_Filial, &
												  lvl_Produto, &
												  lvdh_Periodo, &
												  ref lvl_Venda, &
												  ai_Log) Then
				lvb_Sucesso = False
				Exit
			End If
			
			Update resumo_reposicao_estoque
			Set qt_venda_periodo_1       = :lvl_Venda[1],
				 qt_venda_periodo_2       = :lvl_Venda[2],
				 qt_venda_periodo_3       = :lvl_Venda[3],
				 qt_venda_periodo_4       = :lvl_Venda[4],
				 qt_venda_periodo_5       = :lvl_Venda[5],
				 qt_venda_periodo_6       = :lvl_Venda[6],
				 cd_classe_reposicao      = 'C',
				 id_tipo_reposicao        = :lvs_Tipo,
				 qt_demanda_diaria        = 0,
				 qt_estoque_minimo        = 0,
				 id_nivel_estoque_minimo  = '0',
				 id_geracao_pedido        = 'S',				 
				 qt_estoque_base_anterior = qt_estoque_base,				 
				 qt_estoque_base_definido = 0,				 
				 qt_estoque_base          = 0,				 
				 id_alteracao             = 'N',
				 dh_alteracao             = null,
				 nr_matricula_alteracao   = null,
				 dh_termino_bloqueio      = null,
				 id_atualizacao           = 'S',
				 id_utilizado_eb_definido = 'N'
			Where cd_filial  = :al_Filial
			  and cd_produto = :lvl_Produto
			Using SqlCa;
			
		End If
		
		If SqlCa.SqlCode = -1 Then
			lvs_Mensagem = "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o das vendas do produto '" + String(lvl_Produto) + "'. " + SqlCa.SqlErrText
			This.of_Grava_Log(ai_Log, lvs_Mensagem, True)
			lvb_Sucesso = False
			Exit
		End If
		
		ll_Contador ++
		
		w_ge235_aguarde.st_Processo.Text = "Atualizando as Vendas do Resumo..." + String(ll_Contador, "000")
		
		If ll_Contador = 500 Then
			SqlCa.of_Commit();
			This.of_Grava_Log(ai_Log, "Commit", False)
			ll_Contador = 0
		End If
		
		w_ge235_aguarde.uo_Progress.of_SetProgress(lvl_Contador)
	Next
End If

Destroy(lvds_1)

w_ge235_aguarde.uo_Progress.of_Reset()

Return lvb_Sucesso
end function

public function boolean of_venda_produto (long al_filial, long al_produto, date adt_inicio, date adt_termino, ref long al_venda, integer ai_log);Boolean lvb_Sucesso = True

Select sum(qt_venda - qt_devolucao_venda) Into :al_Venda
From resumo_movto_estq_prd (index idx_data_produto)
Where dh_resumo between :adt_Inicio and :adt_Termino
  //and cd_filial in (select cd_filial from vw_filial where id_rede = 'PP')
  and cd_produto = :al_Produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If IsNull(al_Venda) or al_Venda < 0 Then al_Venda = 0
		
	Case 100
		al_Venda = 0
		
	Case -1
		This.of_Grava_Log(ai_Log, "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o das vendas do produto '" + String(al_Produto) + "'. " + SqlCa.SqlErrText, True)
		lvb_Sucesso = False
End Choose	

Return lvb_Sucesso
end function

public function boolean of_venda_produto (long al_filial, long al_produto, datetime adh_periodo[6, 2], ref long al_venda[6], integer ai_log);Boolean lvb_Sucesso = True

Integer lvi_Contador

Date lvdt_Inicio, &
     lvdt_Termino
	  
Long lvl_Venda, &
     lvl_Filial

For lvi_Contador = 1 To 6
	lvdt_Inicio  = Date(adh_Periodo[lvi_Contador, 1])
	lvdt_Termino = Date(adh_Periodo[lvi_Contador, 2])
			
	If Not This.of_Venda_Produto(lvl_Filial, &
												  al_Produto, &
												  lvdt_Inicio, &
												  lvdt_Termino, &
												  ref lvl_Venda, &
												  ai_Log) Then
		lvb_Sucesso = False
		Exit
	End If
	
	al_Venda[lvi_Contador] = lvl_Venda
	
Next

Return lvb_Sucesso
end function

public function boolean of_atualiza_classe_reposicao (long al_filial, integer ai_log, string as_subcategoria);Boolean lvb_Sucesso = True

Long lvl_Total, &
     lvl_Contador, &
	  lvl_Produto, &
	  lvl_Venda, &
	  lvl_Venda_Anterior

String lvs_Mensagem, &
       lvs_Classe, &
		 lvs_Classe_Anterior
		 
dc_uo_ds_Base lvds_1
lvds_1 = Create dc_uo_ds_Base

If Not lvds_1.of_ChangeDataObject("dw_ge235_atualizacao_classe") Then
	lvs_Mensagem = "Erro na troca da dw de atualiza$$HEX2$$e700e300$$ENDHEX$$o das classes"
	This.of_Grava_Log(ai_Log, lvs_Mensagem, True)
	Destroy(lvds_1)
	Return False
End If

//w_ge235_aguarde.st_Processo.Text = "Atualizando as Classes dos Produtos..."

lvl_Total = lvds_1.Retrieve(al_Filial)

If lvl_Total > 0 Then
	
	Yield ( )
	
	//w_ge235_aguarde.uo_Progress.of_SetMax(lvl_Total)
		
	/* 
	Faz a leitura dos produtos vendidos ordenadamente da classe 'C' at$$HEX1$$e900$$ENDHEX$$ 'A'
	Quando a classe muda, verifica se a quantidade vendida do produto analisado $$HEX1$$e900$$ENDHEX$$ maior
	que a quantidade vendida do produto da classe anterior
	
	OBJETIVO: Produtos com a mesma quantidade vendida far$$HEX1$$e300$$ENDHEX$$o parte da mesma classe,
	          sendo esta, a que tiver maior cobertura, nesta ordem C,B,A
	*/
	
	lvs_Classe_Anterior = ""
	lvl_Venda_Anterior  = 0
	
	For lvl_Contador = lvl_Total To 1 Step -1
		lvl_Produto = lvds_1.Object.Cd_Produto[lvl_Contador]
		lvl_Venda   = lvds_1.Object.Qt_Venda  [lvl_Contador]
		lvs_Classe  = lvds_1.Object.Cd_Classe [lvl_Contador]
					
		If lvs_Classe <> lvs_Classe_Anterior Then
			If lvl_Venda > lvl_Venda_Anterior Then
				lvs_Classe_Anterior = lvs_Classe
			End If
		End If
		
		lvl_Venda_Anterior = lvl_Venda
		
		Update resumo_reposicao_estoque
		Set cd_classe_reposicao = :lvs_Classe_Anterior
		Where cd_filial  = :al_Filial
		  and cd_produto = :lvl_Produto
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			lvs_Mensagem = "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o da classe do produto '" + String(lvl_Produto) + "'. " + SqlCa.SqlErrText
			This.of_Grava_Log(ai_Log, lvs_Mensagem, True)
			lvb_Sucesso = False
			Exit
		End If
		
		//w_ge235_aguarde.uo_Progress.of_SetProgress(lvl_Total - lvl_Contador)
	Next
Else
	//lvs_Mensagem = "Produtos n$$HEX1$$e300$$ENDHEX$$o localizados para atualiza$$HEX2$$e700e300$$ENDHEX$$o das classes do resumo"
	//This.of_Grava_Log(ai_Log, lvs_Mensagem)
	//lvb_Sucesso = False
End If

Destroy(lvds_1)
//w_ge235_aguarde.uo_Progress.of_Reset()

Return lvb_Sucesso
end function

public function boolean of_atualiza_classe_reposicao (long al_filial, integer ai_log);Boolean lvb_Sucesso = True

Long lvl_Total, &
     	lvl_Contador

String 	lvs_Mensagem, &
       		lvs_SubCategoria
		 
dc_uo_ds_Base lvds_1
lvds_1 = Create dc_uo_ds_Base

If Not lvds_1.of_ChangeDataObject("dw_ge235_atualizacao_classe_subcategoria") Then
	lvs_Mensagem = "Erro na troca da dw de atualiza$$HEX2$$e700e300$$ENDHEX$$o das classes subcategoria"
	This.of_Grava_Log(ai_Log, lvs_Mensagem, True)
	Destroy(lvds_1)
	Return False
End If

w_ge235_aguarde.st_Processo.Text = "Atualizando as Classes dos Produtos."

lvl_Total = lvds_1.Retrieve(al_Filial)

If lvl_Total > 0 Then
	
	Yield ( )
	
	w_ge235_aguarde.uo_Progress.of_SetMax(lvl_Total)
	
	// vai rodar apenas uma vez
	For lvl_Contador = 1 to 1
		
		lvs_SubCategoria  = lvds_1.Object.cd_subcategoria [lvl_Contador]
		
		If  Not This.of_Atualiza_Classe_Reposicao(al_Filial, ai_Log, lvs_SubCategoria) Then
			lvb_Sucesso = False
			Exit
		End If

		w_ge235_aguarde.uo_Progress.of_SetProgress(lvl_Contador)
	Next
	
Else
	lvs_Mensagem = "N$$HEX1$$e300$$ENDHEX$$o foram localizadas as subcategorias"
	This.of_Grava_Log(ai_Log, lvs_Mensagem, True)
	lvb_Sucesso = False
End If

Destroy(lvds_1)
w_ge235_aguarde.uo_Progress.of_Reset()

Return lvb_Sucesso
end function

private function boolean of_atualiza_estoque_base (long al_filial, integer ai_log);Boolean lvb_Sucesso

String lvs_Mensagem

Long lvl_Filial

If This.of_Atualiza_Inicio_Processo(al_Filial, ai_Log ) Then
	SqlCa.of_Commit()

	If This.of_Exclui_Produtos(al_Filial, ai_Log) Then
		SqlCa.of_Commit()

		If This.of_Inclui_Produtos(al_Filial, ai_Log) Then
			SqlCa.of_Commit()
			
			//If This.of_Grava_Posicao_Atual(al_Filial, ai_Log) Then
			//	SqlCa.of_Commit()
				
				If This.of_Atualiza_Vendas(al_Filial, ai_Log) Then
					SqlCa.of_Commit()
				
					If This.of_Atualiza_Classe_Reposicao(al_Filial, ai_Log) Then
						SqlCa.of_Commit()
						
						// Atualiza a classe na tabela produto central
						If This.of_atualiza_classe_reposicao_produto(al_Filial, ai_Log) Then
							SqlCa.of_Commit()
							
							If This.of_Atualiza_Termino_Processo(al_Filial, ai_Log) Then										
								lvb_Sucesso = True
							End If
						End If
					End If //
				End If // of_Atualiza_Vendas
			//End If //of_Grava_Posicao_Atual
		End If // of_Inclui_Produtos
	End If // of_Exclui_Produtos
End If //of_Atualiza_Inicio_Processo

If lvb_Sucesso  Then
	Update parametro_reposicao_estoque
	Set dh_proximo_calculo = '20991231'
	Where cd_filial =:al_Filial
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		lvs_Mensagem = "Erro ao atualizar a data do pr$$HEX1$$f300$$ENDHEX$$ximo rec$$HEX1$$e100$$ENDHEX$$lculo. " + SqlCa.SqlErrText
		This.of_Grava_Log(ai_Log, lvs_Mensagem, True)
		lvb_Sucesso = False		
	End If
End If

If lvb_Sucesso Then
	SqlCa.of_Commit()
Else
	SqlCa.of_RollBack()
End If

This.of_Grava_Log(ai_Log, "T$$HEX1$$e900$$ENDHEX$$rmino Filial '" + String(al_Filial) + "'", False)

Return lvb_Sucesso
end function

public function boolean of_periodo_reposicao (integer al_filial, string as_tipo, ref datetime adh_base[6, 2], integer ai_log);Boolean lvb_Sucesso = False

Select dh_inicio_periodo_1,
       dh_termino_periodo_1,
		 dh_inicio_periodo_2,
       dh_termino_periodo_2,		 
		 dh_inicio_periodo_3,
       dh_termino_periodo_3,		 
		 dh_inicio_periodo_4,
       dh_termino_periodo_4,		 
		 dh_inicio_periodo_5,
       dh_termino_periodo_5,		 
		 dh_inicio_periodo_6,
       dh_termino_periodo_6		 
Into :adh_Base[1, 1],
     :adh_Base[1, 2],
	  :adh_Base[2, 1],
	  :adh_Base[2, 2],
	  :adh_Base[3, 1],
	  :adh_Base[3, 2],
	  :adh_Base[4, 1],
	  :adh_Base[4, 2],
	  :adh_Base[5, 1],
	  :adh_Base[5, 2],
	  :adh_Base[6, 1],
	  :adh_Base[6, 2]	  
From parametro_reposicao_estoque
Where cd_filial         = :al_Filial
  and id_tipo_reposicao = :as_Tipo
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		lvb_Sucesso = True
	Case 100
		This.of_Grava_Log(ai_Log, "Datas de reposi$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o localizadas", True)
	Case -1
		This.of_Grava_Log(ai_Log, "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o das datas de reposi$$HEX2$$e700e300$$ENDHEX$$o. " + SqlCa.SqlErrText, True)
End Choose

Return lvb_Sucesso
end function

public function boolean of_atualiza_periodos (long al_filial, date adt_recalculo, integer ai_log);Boolean lvb_Sucesso = True

Update parametro_reposicao_estoque 
Set dh_inicio_periodo_1  			= dateadd(day, -84, :adt_Recalculo), 
	dh_termino_periodo_1 			= dateadd(day, -71, :adt_Recalculo),   
	dh_inicio_periodo_2  			= dateadd(day, -70, :adt_Recalculo),   
	dh_termino_periodo_2 			= dateadd(day, -57, :adt_Recalculo),   
	dh_inicio_periodo_3  			= dateadd(day, -56, :adt_Recalculo),   
	dh_termino_periodo_3 			= dateadd(day, -43, :adt_Recalculo),   
	dh_inicio_periodo_4  			= dateadd(day, -42, :adt_Recalculo),   
	dh_termino_periodo_4 			= dateadd(day, -29, :adt_Recalculo),   
	dh_inicio_periodo_5  			= dateadd(day, -28, :adt_Recalculo),   
	dh_termino_periodo_5 			= dateadd(day, -15, :adt_Recalculo),   
	dh_inicio_periodo_6  			= dateadd(day, -14, :adt_Recalculo),   
	dh_termino_periodo_6 			= dateadd(day,  -1, :adt_Recalculo),   
	id_periodos_atualizados 		= 'S',   
	dh_proximo_calculo      		= :adt_Recalculo,
	nr_matricula_proximo_recalculo 	= '14330'
 From parametro_reposicao_estoque p
Where p.id_tipo_reposicao = 'E' 
  and p.cd_filial = :al_Filial
Using SqlCa;
  
If SqlCa.SqlCode = -1 Then
	This.of_Grava_Log(ai_Log, "Atualiza$$HEX2$$e700e300$$ENDHEX$$o da data do pr$$HEX1$$f300$$ENDHEX$$ximo rec$$HEX1$$e100$$ENDHEX$$lculo.", True)
	 lvb_Sucesso = False
End If
		
If lvb_Sucesso Then
	Update parametro_reposicao_estoque 
	Set dh_inicio_periodo_1  			= dateadd(day, -365, :adt_Recalculo), 
		dh_termino_periodo_1 			= dateadd(day, -352, :adt_Recalculo),   
		dh_inicio_periodo_2  			= dateadd(day, -351, :adt_Recalculo),   
		dh_termino_periodo_2 			= dateadd(day, -338, :adt_Recalculo),   
		dh_inicio_periodo_3  			= dateadd(day,  -56, :adt_Recalculo),   
		dh_termino_periodo_3 			= dateadd(day,  -43, :adt_Recalculo),   
		dh_inicio_periodo_4  			= dateadd(day,  -42, :adt_Recalculo),   
		dh_termino_periodo_4 			= dateadd(day,  -29, :adt_Recalculo),   
		dh_inicio_periodo_5  			= dateadd(day,  -28, :adt_Recalculo),   
		dh_termino_periodo_5 			= dateadd(day,  -15, :adt_Recalculo),   
		dh_inicio_periodo_6  			= dateadd(day,  -14, :adt_Recalculo),   
		dh_termino_periodo_6 			= dateadd(day,   -1, :adt_Recalculo),   
		id_periodos_atualizados 		= 'S',   
		dh_proximo_calculo      		= :adt_Recalculo,
		nr_matricula_proximo_recalculo 	= '14330'
	From parametro_reposicao_estoque p
	Where p.id_tipo_reposicao = 'S' and
		  p.cd_filial =:al_Filial
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		This.of_Grava_Log(ai_Log, "Atualiza$$HEX2$$e700e300$$ENDHEX$$o da data do pr$$HEX1$$f300$$ENDHEX$$ximo rec$$HEX1$$e100$$ENDHEX$$lculo.", True)
		lvb_Sucesso = False
	End If
End If

If lvb_Sucesso Then
	SqlCa.of_Commit();
Else
	SqlCa.of_Rollback();
End If

select dh_inicio_periodo_1, dh_termino_periodo_6 
Into :idt_inicio, :idt_termino
From parametro_reposicao_estoque p
Where p.id_tipo_reposicao = 'E' 
  and p.cd_filial = :al_Filial
Using SqlCa;
	
If SqlCa.SqlCode = -1 Then
	This.of_Grava_Log(ai_Log, "Erro ao localizar os per$$HEX1$$ed00$$ENDHEX$$odos estavel.", True)
	lvb_Sucesso = False
End If

Return lvb_Sucesso
end function

public function boolean of_venda_produto_estavel (long al_produto, ref long al_venda, date adt_inicio, date adt_termino);Boolean lvb_Sucesso = True

//--Select sum(qt_venda - qt_devolucao_venda) Into :al_Venda
//From resumo_produto_filial

Select sum(qt_venda - qt_devolucao_venda) Into :al_Venda
From resumo_movto_estq_prd (index idx_data_produto)
Where dh_resumo between :adt_Inicio and :adt_Termino
  //and cd_filial in (select cd_filial from vw_filial where id_rede = 'PP')
  and cd_produto = :al_Produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If IsNull(al_Venda) or al_Venda < 0 Then al_Venda = 0
		
	Case 100
		al_Venda = 0
		
	Case -1
		//This.of_Grava_Log(ai_Log, "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o das vendas do produto '" + String(al_Produto) + "'. " + SqlCa.SqlErrText)
		SqlCa.of_MsgDBError("Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o das vendas do produto '" + String(al_Produto) + "'. ")
		lvb_Sucesso = False
End Choose	

Return lvb_Sucesso


end function

public function boolean of_atualiza_classe_reposicao_produto (long al_filial, integer ai_log);Long ll_Total, ll_Contador, ll_Produto

String ls_Classe_Reposicao
		 
w_ge235_aguarde.st_Processo.Text = "Atualizando as Classes da Tabela Produto Central ..."

dc_uo_ds_Base lds

try
	
	lds = Create dc_uo_ds_Base
	
	If Not lds.of_ChangeDataObject("dw_ge235_atualizacao_classe") Then
		This.of_Grava_Log(ai_Log, "Erro na troca da DW 'dw_ge235_resumo_reposicao'", True)
		Return False
	End If
	
	ll_Total = lds.Retrieve(al_Filial)
	
	If ll_Total > 0 Then
		
		w_ge235_aguarde.uo_Progress.of_SetMax(ll_Total)
	
		For ll_Contador = 1 To ll_Total
			
			ls_Classe_Reposicao 	= lds.Object.cd_classe_reposicao	[ll_Contador]
			ll_Produto				= lds.Object.cd_produto				[ll_Contador]
					
			Update produto_central
			Set cd_curva_abc_filiais = :ls_Classe_Reposicao
			Where cd_produto = :ll_Produto
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				SqlCa.of_RollBack();
				This.of_Grava_Log(ai_Log, "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o da classe do produto '" + String(ll_Produto) + "'. " + SqlCa.SqlErrText, True)
				Return False
			End If
			
			w_ge235_aguarde.uo_Progress.of_SetProgress(ll_Contador)
			
		Next
		
	End If
	
	SqlCa.of_Commit();
	
	// Atualiza para CLASSE C quando o produto n$$HEX1$$e300$$ENDHEX$$o estiver mais ativo
	update produto_central
	set cd_curva_abc_filiais = 'C'
	where cd_produto in (select c.cd_produto 
								from produto_central c
								inner join produto_geral g
									on g.cd_produto = c.cd_produto
								where c.cd_produto = g.cd_produto
									and g.id_situacao <> 'A'
									and coalesce(c.cd_curva_abc_filiais, 'X') <> 'C')
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_RollBack();
		This.of_Grava_Log(ai_Log, "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o da classe do produto '" + String(ll_Produto) + "'. " + SqlCa.SqlErrText, True)
		Return False
	End If
	
	SqlCa.of_Commit();
	
	// Atualiza para CLASSE para C quando o produto n$$HEX1$$e300$$ENDHEX$$o tiver vendido
	update produto_central
	set cd_curva_abc_filiais = 'C'
	where coalesce(cd_curva_abc_filiais, 'X') <> 'C'
	  	and cd_produto in (select r.cd_produto
								from resumo_reposicao_estoque r
								where cd_filial = 1534
									and (qt_venda_periodo_1 +  qt_venda_periodo_2 +  qt_venda_periodo_3 + qt_venda_periodo_4 +  qt_venda_periodo_5 +  qt_venda_periodo_6) = 0)
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_RollBack();
		This.of_Grava_Log(ai_Log, "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o da classe do produto '" + String(ll_Produto) + "'. " + SqlCa.SqlErrText, True)
		Return False
	End If
	
	SqlCa.of_Commit();
	
finally
	Destroy lds
	w_ge235_aguarde.uo_Progress.of_Reset()
end try

Return True



end function

public function boolean of_grava_log (integer ai_arquivo, string as_mensagem, boolean ab_envia_email);Integer lvi_Status

String lvs_Mensagem, ls_Anexo[]

lvs_Mensagem = String(Today(), "dd/mm/yyyy") + " " + &
               String(Now(), "hh:mm:ss") + " " +  as_Mensagem
	
lvi_Status = FileWrite(ai_Arquivo, lvs_Mensagem)

If ab_envia_email Then
	If Not gf_ge202_envia_email_automatico(112, "", "Filial: '" + String(il_Filial) + "'<br><br>" + as_mensagem, ls_Anexo) Then
		Return False
	End If
End If

If lvi_Status <> LenA(lvs_Mensagem) Then	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro no arquivo de log da aplica$$HEX2$$e700e300$$ENDHEX$$o.", StopSign!)
	
	gf_ge202_envia_email_automatico(112, "", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro no arquivo de log da aplica$$HEX2$$e700e300$$ENDHEX$$o.", ls_Anexo)
	
	Return False
Else
	Return True
End If
end function

public function date of_mes (date adt_mes_base, integer ai_numero);Date lvdt_Mes_Anterior

Integer lvi_Mes_Atual, &
        lvi_Ano_Atual, &
		  lvi_Mes_Anterior, &
		  lvi_Ano_Anterior
	  
lvi_Mes_Atual = Month(adt_Mes_Base)
lvi_Ano_Atual = Year(adt_Mes_Base)

lvi_Ano_Anterior = lvi_Ano_Atual
lvi_Mes_Anterior = lvi_Mes_Atual - ai_Numero

If lvi_Mes_Anterior <= 0 Then
	lvi_Ano_Anterior = lvi_Ano_Atual - 1
	lvi_Mes_Anterior = lvi_Mes_Anterior + 12
End If

lvdt_Mes_Anterior = Date("01/" + String(lvi_Mes_Anterior, "00") + "/" + &
                                 String(lvi_Ano_Anterior, "0000"))

Return lvdt_Mes_Anterior
end function

public function boolean of_classe_perini ();Long lvl_Total, lvl_Contador, ll_Produto

Integer lvi_Log

Date ldt_Inicio, ldt_Termino, ldt_Mes_Base

String ls_Classe_Reposicao, lvs_Arquivo

ldt_Mes_Base = gf_Primeiro_Dia_Mes(Date(gf_GetServerDate()))

ldt_Termino = of_Mes(ldt_Mes_Base, 1)
ldt_Inicio 	= of_Mes(ldt_Mes_Base, 3)

dc_uo_ds_Base lvds_1

try
	
	Open(w_ge235_aguarde)
	
	lvs_Arquivo = gvo_Aplicacao.ivs_Path_Arquivos + "calculo_estoque_EC.log"

	lvi_Log = FileOpen(lvs_Arquivo, LineMode!, Write!, LockWrite!, Append!)

	If lvi_Log = -1 or IsNull(lvi_Log) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na abertura do arquivo de log '" + lvs_Arquivo + "'.", StopSign!)
		Return False
	End If
	
	lvds_1 = Create dc_uo_ds_Base

	If Not lvds_1.of_ChangeDataObject("dw_ge235_atualizacao_classe_perini") Then Return False

	w_ge235_aguarde.st_Processo.Text = "Atualizando as Classes dos Produtos..."

	lvl_Total = lvds_1.Retrieve(ldt_Inicio, ldt_Termino)
	
	If lvl_Total > 0 Then
		w_ge235_aguarde.uo_Progress.of_SetMax(lvl_Total)
	
		For lvl_Contador = 1 To lvl_Total
			
			lvds_1.Object.cd_classe_nova[lvl_Contador] = lvds_1.Object.cd_classe[lvl_Contador]
			
			ls_Classe_Reposicao 	= lvds_1.Object.cd_classe	[lvl_Contador]
			ll_Produto				= lvds_1.Object.cd_produto	[lvl_Contador]
					
			Update produto_central
			Set cd_curva_abc_perini = :ls_Classe_Reposicao
			Where cd_produto = :ll_Produto
			    and coalesce(cd_curva_abc_perini, 'X') <> :ls_Classe_Reposicao
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				SqlCa.of_RollBack();
				This.of_Grava_Log(lvi_Log, "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o da classe do produto PERINI '" + String(ll_Produto) + "'. " + SqlCa.SqlErrText, True)
				Return False
			End If
			
			w_ge235_aguarde.uo_Progress.of_SetProgress(lvl_Contador)
		Next
		
		SqlCa.of_Commit();
		
		// Atualiza para CLASSE  E diferente de ativos onde a classe $$HEX1$$e900$$ENDHEX$$ diferente de E
		update produto_central
		set cd_curva_abc_perini = 'C'
		where cd_produto in (select c.cd_produto 
									from produto_central c
									inner join produto_geral g
										on g.cd_produto = c.cd_produto
									where c.cd_produto = g.cd_produto
										and g.id_situacao <> 'A'
										and coalesce(c.cd_curva_abc_perini, 'X') <> 'C')
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_RollBack();
			This.of_Grava_Log(lvi_Log, "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o da classe do produto PERINI '" + String(ll_Produto) + "'. " + SqlCa.SqlErrText, True)
			Return False
		End If
		
		SqlCa.of_Commit();
		
		// Atualiza para CLASSE  E  os produtos sem transfer$$HEX1$$ea00$$ENDHEX$$ncia
		update produto_central
		set cd_curva_abc_perini = 'C'
		where coalesce(cd_curva_abc_perini, 'X') <> 'C'
			and cd_produto in (select g.cd_produto from produto_geral g
									where g.id_situacao = 'A'
										and not exists (select * from resumo_transferencia_perini r
															  where r.dh_resumo between :ldt_Inicio and :ldt_Termino
																  and r.cd_produto = g.cd_produto) )
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_RollBack();
			This.of_Grava_Log(lvi_Log, "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o da classe do produto PERINI '" + String(ll_Produto) + "'. " + SqlCa.SqlErrText, True)
			Return False
		End If
		
		SqlCa.of_Commit();
				
	End If

	w_ge235_aguarde.uo_Progress.of_Reset()
	
finally
	Destroy(lvds_1)
	FileClose(lvi_Log)
	Close(w_ge235_aguarde)
end try

Return True


end function

on uo_ge235_estoque_central.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge235_estoque_central.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

