HA$PBExportHeader$uo_ge115_remanejamento.sru
forward
global type uo_ge115_remanejamento from nonvisualobject
end type
type st_pct_curva from structure within uo_ge115_remanejamento
end type
end forward

type st_pct_curva from structure
	string		id_curva
	integer		pct_aumento
end type

global type uo_ge115_remanejamento from nonvisualobject
end type
global uo_ge115_remanejamento uo_ge115_remanejamento

type variables
Boolean 	ib_Localizado, ib_selecionar_varios_remanej = False, ib_retirada_excesso_novo_calc_eb = False
Date		idt_ini_prestes
DateTime idt_dh_calculo, idt_dh_inicio_execucao, idt_dh_termino_execucao
Integer 	ii_qt_dias_retirada, ii_qt_dias_remanejamento, ii_id_selecao_produto
Long 		il_cd_remanejamento, il_filial_fechamento
Long		il_dias_media_venda, il_dias_ultima_venda, il_qtd_media_vendas_superior 
String 	is_de_remanejamento, is_nr_matricula_responsavel, is_id_remanejamento_via_arquivo, is_id_montagem_filial, is_cd_remanejamentos_selecionados = '', &
			is_id_psico, is_id_geladeira, is_id_planograma, is_id_tratamento_estoque_base, is_id_beauty_club, is_id_promocao_estoque_minimo, is_id_avulso, &
			is_id_remanejamento_via_prestes
			
dc_uo_ds_base	ids_filiais
dc_uo_ds_base	ids_remanejados

Private st_pct_curva	ist_pct_curva []
end variables

forward prototypes
public subroutine of_inicializa ()
public subroutine of_localiza_codigo (long pl_codigo)
public subroutine of_localiza_generica (string ps_parametro)
public subroutine of_localiza (string ps_parametro)
public function boolean of_calcula_remanejamento ()
public function boolean of_calcula_ultimo_mvto (date pdt_parametro)
public function boolean of_fechamento_filial ()
public function boolean of_verifica_filial_retirada (long pl_filial, ref boolean pb_retirada)
public function boolean of_verifica_filial_recebe (long pl_filial, ref boolean pb_recebe)
public subroutine of_executa_remanejamento (string as_filiais_montagem)
public function boolean of_distribui_excesso (string as_filiais_montagem)
public function boolean of_distribui_excesso_old ()
public function boolean of_calcula_remanejamento_prestes ()
public function boolean of_distribui_excesso_prestes ()
public function boolean of_grava_remanejamento_etiqueta (long al_cd_remanejamento)
public function boolean of_carrega_parametros_prestes ()
public function boolean of_carrega_parametros ()
public function integer of_pct_aumento_curva (string as_curva)
public function boolean of_calcula_ultimo_mvto_prestes (long al_cd_remanejamento, date adt_movto_inicial, date adt_dh_saldo)
public function boolean of_registra_baixa_na_marcacao (long al_filial_origem, long al_filial_destino, long al_produto, long al_qt_remanejamento, long al_qtd_remanejar)
public function boolean of_registra_baixa_na_distribuicao (long al_filial_origem, long al_produto, long al_qtd_excesso)
end prototypes

public subroutine of_inicializa ();ib_Localizado = False

SetNull( is_id_psico )
SetNull( is_id_geladeira )
SetNull( is_id_planograma )
SetNull( is_id_tratamento_estoque_base )

SetNull( idt_dh_calculo )
SetNull( idt_dh_inicio_execucao )
SetNull( idt_dh_termino_execucao )

SetNull( ii_qt_dias_retirada )
SetNull( ii_qt_dias_remanejamento )
SetNull( ii_id_selecao_produto )

SetNull( il_cd_remanejamento )

SetNull( is_de_remanejamento )
SetNull( is_nr_matricula_responsavel )

SetNull( il_filial_Fechamento )
end subroutine

public subroutine of_localiza_codigo (long pl_codigo);SELECT	r.cd_remanejamento					as cd_remanejamento,   
			r.de_remanejamento					as de_remanejamento,
			r.dh_calculo								as dh_calculo,   
			r.qt_dias_retirada						as qt_dias_retirada,   
			r.qt_dias_remanejamento			as qt_dias_remanejamento,   
			r.id_selecao_produto					as id_selecao_produto,   
			r.id_psico								as id_psico,   
			r.id_geladeira							as id_geladeira,   
			r.id_planograma						as id_planograma,   
			r.id_tratamento_estoque_base		as id_tratamento_estoque_base,
			r.id_beauty_club						as id_beauty_club,
			r.id_promocao_estoque_minimo	as id_promocao_estoque_minimo,
			r.cd_filial_fechamento					as cd_filial_fechamento,
			r.id_remanejamento_via_prestes as id_remanejamento_via_prestes
	INTO	:il_cd_remanejamento,
			:is_de_remanejamento,
			:idt_dh_calculo,
			:ii_qt_dias_retirada,
			:ii_qt_dias_remanejamento,
			:ii_id_selecao_produto,
			:is_id_psico,
			:is_id_geladeira,
			:is_id_planograma,
			:is_id_tratamento_estoque_base,
			:is_id_beauty_club,
			:is_id_promocao_estoque_minimo,
			:il_filial_fechamento,
			:is_id_remanejamento_via_prestes
	FROM remanejamento as r
  WHERE r.cd_remanejamento = :pl_Codigo
	USING SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		ib_Localizado = True		
		
	Case 100
		ib_Localizado = False
		
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Remanejamento")
		ib_Localizado = False
End Choose
end subroutine

public subroutine of_localiza_generica (string ps_parametro);String ls_Remanejamento

If ib_selecionar_varios_remanej Then
	OpenWithParm( w_ge115_selecao_remanejamento, "S" + ps_Parametro )
Else
	OpenWithParm( w_ge115_selecao_remanejamento, "N" + ps_Parametro )
End If

ls_Remanejamento = Message.StringParm

If IsNull( ls_Remanejamento ) Then
	ib_Localizado = False
Else
	If ib_selecionar_varios_remanej Then
		is_cd_remanejamentos_selecionados = ls_Remanejamento
		ib_Localizado = True
	Else
		This.of_Localiza_Codigo( Long( ls_Remanejamento ) )
	End If
End If
end subroutine

public subroutine of_localiza (string ps_parametro);Integer lvi_Tamanho

lvi_Tamanho = Len( ps_Parametro )

If lvi_Tamanho > 0 Then
	If IsNumber( ps_Parametro ) Then
		This.of_Localiza_Codigo( Long( ps_Parametro ) )

		If Not ib_Localizado Then
			of_Localiza_Generica( "" )
		End If
	Else
		of_Localiza_Generica( ps_Parametro )
	End If
Else
	of_Localiza_Generica( "" )
End If
end subroutine

public function boolean of_calcula_remanejamento ();DateTime ldh_Movimentacao
Long ll_Linha
Long ll_Linhas
Long ll_Filial
Long ll_Produto
Long ll_for
Long ll_cd_filial
String ls_Sql
String ls_Dh_Inicio_Comando

dc_uo_ds_base lds_filiais

If not of_carrega_parametros () then
	Return False
End if

Select cd_remanejamento,
		 dh_calculo,
		 id_selecao_produto,
		 id_psico,
		 id_beauty_club,
		 id_geladeira,
		 id_planograma,
		 id_tratamento_estoque_base,
		 id_promocao_estoque_minimo,
		 qt_dias_retirada,
		 qt_dias_remanejamento,
		 cd_filial_fechamento,
		 id_avulso,
		 coalesce(id_remanejamento_via_arquivo, 'N'),
		 coalesce(id_montagem_filial, 'N')
   Into	:il_cd_remanejamento,
		:idt_dh_calculo,
		:ii_id_selecao_produto,
 		:is_id_psico,
		:is_id_beauty_club,
		:is_id_geladeira,
		:is_id_planograma,
		:is_id_tratamento_estoque_base,
		:is_id_promocao_estoque_minimo,
		:ii_qt_dias_retirada,
		:ii_qt_dias_remanejamento,
		:il_filial_fechamento,
		:is_id_avulso,
		:is_id_remanejamento_via_arquivo,
		:is_id_montagem_filial
 From remanejamento
 Where cd_remanejamento	= :il_cd_remanejamento
 Using SqlCa;
		
Choose Case SqlCa.SqlCode
	Case -1
		Return False
		
	Case 100
		gvo_Aplicacao.of_Grava_Log( 'Nenhum remanejamento encontrado para processar' )
		Return False
End Choose

ldh_Movimentacao = gvo_Parametro.of_Dh_Movimentacao( )

/* Grava a data de in$$HEX1$$ed00$$ENDHEX$$cio do processo */
Update remanejamento
	 Set dh_inicio_execucao = getdate( )
 Where cd_remanejamento = :il_cd_remanejamento
   Using SqlCa;
	
If SqlCa.SqlCode = -1 Then
	SqlCa.of_RollBack( )
	Return False
End If

w_Aguarde.Title = "Atualizando $$HEX1$$fa00$$ENDHEX$$ltima movimenta$$HEX2$$e700e300$$ENDHEX$$o dos produtos..."
Yield( )

If Not of_Calcula_Ultimo_Mvto( Date( ldh_Movimentacao ) ) Then
	Return False
End If

//ls_Dh_Inicio_Comando = String( DateTime( Today( ), Now( ) ), "dd/mm/yy hh:mm:ss" ) // Para registro de tempo no log

Delete from remanejamento_processamento
		 from remanejamento_filial rf
		where rf.cd_filial = remanejamento_processamento.cd_filial
		  and rf.cd_remanejamento = :il_cd_remanejamento
Using SqlCa;

//gvo_Aplicacao.of_Grava_Log(	"Delete remanejamento_processamento | In$$HEX1$$ed00$$ENDHEX$$cio: " + ls_Dh_Inicio_Comando + &
//										" | T$$HEX1$$e900$$ENDHEX$$rmino: " + String( DateTime( Today( ), Now( ) ), "dd/mm/yy hh:mm:ss" )  + " | Registros: " + String( SqlCa.SqlNRows ) )

If SqlCa.SqlCode = -1 Then
	SqlCa.of_LogDbError( gvo_Aplicacao.ivi_Log )
	SqlCa.of_RollBack( )
	Return False
End If

SqlCa.of_Commit( )

w_Aguarde.Title = "Excluindo dados tempor$$HEX1$$e100$$ENDHEX$$rios do remanejamento anterior..."
Yield( )

Delete From remanejamento_exclusao
 Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_LogDbError( gvo_Aplicacao.ivi_Log )
	SqlCa.of_RollBack( )
	Return False
End If

SqlCa.of_Commit( )

// Se for remanejamento via arquivo n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio incluir registros na REMANEJAMENTO_PROCESSAMENTO 
If is_id_remanejamento_via_arquivo = 'S' and is_id_montagem_filial = 'S'Then Return True

lds_filiais = create dc_uo_ds_base
lds_filiais.of_changedataobject( 'ds_ge115_lista_filial_remanejamento' )

lds_filiais.Retrieve(il_cd_remanejamento)

w_Aguarde.uo_Progress.of_SetMax( lds_filiais.RowCount() )

for ll_for = 1 to lds_filiais.RowCount()
	ll_cd_filial	= lds_filiais.Object.cd_filial[ll_for]

	w_Aguarde.Title = "Inserindo produtos para c$$HEX1$$e100$$ENDHEX$$lculo da filial " + String(ll_cd_filial)
	w_Aguarde.uo_Progress.of_setprogress(ll_for)
	Yield( )

	//ls_Dh_Inicio_Comando = String( DateTime( Today( ), Now( ) ), "dd/mm/yy hh:mm:ss" ) // Para registro de tempo no log
	If This.ii_id_selecao_produto <> 0 Then // Por grupo de produtos
		Insert Into remanejamento_processamento
			(cd_remanejamento,
			 cd_filial,
			 cd_produto,
			 cd_grupo_psico,
			 id_geladeira,
			 id_beauty,
			 qt_saldo,
			 dh_ultimo_mvto,
			 qt_vendida,
			 qt_eb,
			 qt_saldo_filial_destino,
			 cd_classe_reposicao,
			 qt_min_filial_destino
			 )
		Select :il_cd_remanejamento,
				f.cd_filial,
				g.cd_produto,
				g.cd_grupo_psico,
				g.id_geladeira,
				m.id_beauty,
				s.qt_saldo_final,
				mvto.dh_ultimo_movimento,
				(	select coalesce( sum( qt_venda ) - sum( qt_devolucao_venda ), 0 )
					  from resumo_produto_filial as m 
					 where m.cd_produto	= g.cd_produto
						and m.dh_resumo >= convert( char( 6 ), dateadd( day, -:ii_qt_dias_remanejamento, :ldh_Movimentacao ), 112 ) + '01'  
						and m.cd_filial		= f.cd_filial ),
				(CASE WHEN coalesce(r.id_remanejamento_via_arquivo, 'N')  = 'N' 
					THEN rre.qt_estoque_base 
					ELSE  (CASE WHEN coalesce(mi.qt_estoque_minimo, 0) > rre.qt_estoque_base 
								THEN mi.qt_estoque_minimo 
								ELSE rre.qt_estoque_base 
							END)
				 END) qt_estoque_base, 
				s.qt_saldo_final,
				rre.cd_classe_reposicao,
				COALESCE (rre.qt_estoque_minimo, 0)
		 from remanejamento as r
			inner join remanejamento_filial as f
				on f.cd_remanejamento = r.cd_remanejamento
			inner join produto_geral as g
				on substring( g.cd_subcategoria, 1, 1 ) = cast( r.id_selecao_produto as char )
			inner join produto_central as c
				on c.cd_produto = g.cd_produto
			inner join mix_produto as m
				on m.cd_mix_produto = c.cd_mix_produto
			inner join filial f2 on f2.cd_filial  = f.cd_filial 
			inner join saldo_produto as s
				on s.cd_filial					= f2.cd_filial
				and s.cd_produto			= g.cd_produto
					 and s.dh_saldo   			= f2.dh_ultimo_saldo
			inner join remanejamento_movimento as mvto
				 on mvto.cd_filial			= f.cd_filial
			  and mvto.cd_produto		= g.cd_produto
			inner join resumo_reposicao_estoque as rre
				on rre.cd_filial				= f.cd_filial
			 and rre.cd_produto			= g.cd_produto
			 left outer join resumo_estoque_minimo_filial mi
				on mi.cd_filial 		= f.cd_filial
				and mi.cd_produto 	= g.cd_produto
		 where r.cd_remanejamento	= :il_cd_remanejamento
		 	and f.cd_filial			= :ll_cd_filial
		 
		 Union
		 
		 Select :il_cd_remanejamento,
				f.cd_filial,
				g.cd_produto,
				g.cd_grupo_psico,
				g.id_geladeira,
				m.id_beauty,
				s.qt_saldo_final,
				mvto.dh_ultimo_movimento,
				(	select coalesce( sum( qt_venda ) - sum( qt_devolucao_venda ), 0 )
					  from resumo_produto_filial as m 
					 where m.cd_produto	= g.cd_produto
						and m.dh_resumo >= convert( char( 6 ), dateadd( day, -:ii_qt_dias_remanejamento, :ldh_Movimentacao ), 112 ) + '01'  
						and m.cd_filial		= f.cd_filial ),
					(CASE WHEN coalesce(r.id_remanejamento_via_arquivo, 'N')  = 'N' 
						THEN 0 
						ELSE coalesce(mi.qt_estoque_minimo, 0)
					 END) qt_estoque_base, 
				s.qt_saldo_final,
				'' AS cd_classe_reposicao,
				0 as qt_estoque_minimo
		 from remanejamento as r
			inner join remanejamento_filial as f
				on f.cd_remanejamento = r.cd_remanejamento
			inner join produto_geral as g
				on substring( g.cd_subcategoria, 1, 1 ) = cast( r.id_selecao_produto as char )
			inner join produto_central as c
				on c.cd_produto = g.cd_produto
			inner join mix_produto as m
				on m.cd_mix_produto = c.cd_mix_produto
			inner join filial f2 on f2.cd_filial  = f.cd_filial 
			inner join saldo_produto as s
				on s.cd_filial					= f2.cd_filial
				and s.cd_produto			= g.cd_produto
					 and s.dh_saldo   			= f2.dh_ultimo_saldo			
			inner join remanejamento_movimento as mvto
				 on mvto.cd_filial			= f.cd_filial
			  and mvto.cd_produto		= g.cd_produto
			left outer join resumo_estoque_minimo_filial mi
				on mi.cd_filial 		= f.cd_filial
				and mi.cd_produto 	= g.cd_produto
		 where r.cd_remanejamento	= :il_cd_remanejamento
		 	and f.cd_filial			= :ll_cd_filial
			and s.qt_saldo_final > 0
			and not exists (select * from resumo_reposicao_estoque rre
										where rre.cd_filial 		= f.cd_filial
											and rre.cd_produto 	= g.cd_produto)
		Using SqlCa;
		
	Else // Todos os produtos
		Insert Into remanejamento_processamento
			(cd_remanejamento,
			 cd_filial,
			 cd_produto,
			 cd_grupo_psico,
			 id_geladeira,
			 id_beauty,
			 qt_saldo,
			 dh_ultimo_mvto,
			 qt_vendida,
			 qt_eb,
			 qt_saldo_filial_destino,
			 cd_classe_reposicao,
			 qt_min_filial_destino)
		Select :il_cd_remanejamento,
				f.cd_filial,
				g.cd_produto,
				g.cd_grupo_psico,
				g.id_geladeira,
				m.id_beauty,
				s.qt_saldo_final,
				mvto.dh_ultimo_movimento,
				(	select coalesce( sum( qt_venda ) - sum( qt_devolucao_venda ), 0 )
					  from resumo_produto_filial as m 
					 where m.cd_produto	= g.cd_produto
						and m.dh_resumo >= convert( char( 6 ), dateadd( day, -:ii_qt_dias_remanejamento, :ldh_Movimentacao ), 112 ) + '01'  
						and m.cd_filial		= f.cd_filial ),
				(CASE WHEN coalesce(r.id_remanejamento_via_arquivo, 'N')  = 'N' 
					THEN rre.qt_estoque_base 
					ELSE  (CASE WHEN coalesce(mi.qt_estoque_minimo, 0) > rre.qt_estoque_base 
								THEN mi.qt_estoque_minimo 
								ELSE rre.qt_estoque_base 
							END)
				 END) qt_estoque_base, 
				s.qt_saldo_final,
				rre.cd_classe_reposicao,
				COALESCE (rre.qt_estoque_minimo, 0)
		 from remanejamento as r
			inner join remanejamento_filial as f
				on f.cd_remanejamento = r.cd_remanejamento
			inner join produto_geral as g
				on g.cd_produto > 0
			inner join produto_central as c
				on c.cd_produto = g.cd_produto
			inner join mix_produto as m
				on m.cd_mix_produto = c.cd_mix_produto
			inner join filial f2 on f2.cd_filial  = f.cd_filial
			inner join saldo_produto as s
				on s.cd_filial					= f2.cd_filial
				and s.cd_produto			= g.cd_produto
				and s.dh_saldo   			= f2.dh_ultimo_saldo			
			inner join remanejamento_movimento as mvto
				 on mvto.cd_filial			= f.cd_filial
			  and mvto.cd_produto		= g.cd_produto
			inner join resumo_reposicao_estoque as rre
				on rre.cd_filial				= f.cd_filial
			 and rre.cd_produto			= g.cd_produto
			left outer join resumo_estoque_minimo_filial mi
				on mi.cd_filial 		= f.cd_filial
				and mi.cd_produto 	= g.cd_produto
		 where r.cd_remanejamento	= :il_cd_remanejamento
		 	and f.cd_filial			= :ll_cd_filial
		 
		 Union
		 
		 Select :il_cd_remanejamento,
				f.cd_filial,
				g.cd_produto,
				g.cd_grupo_psico,
				g.id_geladeira,
				m.id_beauty,
				s.qt_saldo_final,
				mvto.dh_ultimo_movimento,
				(	select coalesce( sum( qt_venda ) - sum( qt_devolucao_venda ), 0 )
					  from resumo_produto_filial as m 
					 where m.cd_produto	= g.cd_produto
						and m.dh_resumo >= convert( char( 6 ), dateadd( day, -:ii_qt_dias_remanejamento, :ldh_Movimentacao ), 112 ) + '01'  
						and m.cd_filial		= f.cd_filial ),
				(CASE WHEN coalesce(r.id_remanejamento_via_arquivo, 'N')  = 'N' 
					THEN 0 
					ELSE coalesce(mi.qt_estoque_minimo, 0)
				 END) qt_estoque_base, 
				 s.qt_saldo_final,
				 '' AS cd_classe_reposicao,
			 	 0 AS qt_estoque_minimo
		 from remanejamento as r
			inner join remanejamento_filial as f
				on f.cd_remanejamento = r.cd_remanejamento
			inner join produto_geral as g
				on g.cd_produto > 0
			inner join produto_central as c
				on c.cd_produto = g.cd_produto
			inner join mix_produto as m
				on m.cd_mix_produto = c.cd_mix_produto
			inner join filial f2 on f2.cd_filial  = f.cd_filial
			inner join saldo_produto as s
				on s.cd_filial					= f2.cd_filial
				and s.cd_produto			= g.cd_produto
				and s.dh_saldo   			= f2.dh_ultimo_saldo						
			inner join remanejamento_movimento as mvto
				 on mvto.cd_filial			= f.cd_filial
			  and mvto.cd_produto		= g.cd_produto
			left outer join resumo_estoque_minimo_filial mi
				on mi.cd_filial 		= f.cd_filial
				and mi.cd_produto 	= g.cd_produto
		 where r.cd_remanejamento	= :il_cd_remanejamento
		 	and f.cd_filial			= :ll_cd_filial
				and s.qt_saldo_final > 0
			and not exists (select * from resumo_reposicao_estoque rre
										where rre.cd_filial = f.cd_filial
											and rre.cd_produto = g.cd_produto)
		Using SqlCa;

	End If
	
	ll_Linhas = SqlCa.SqlNRows

	If SqlCa.SqlCode = -1 Then
		SqlCa.of_LogDbError( gvo_Aplicacao.ivi_Log )
		SqlCa.of_RollBack( )
		Return False
	End If
	
	SqlCa.of_Commit( )
Next

If ib_retirada_excesso_novo_calc_eb Then Return true

// Se for remanejamento via arquivo n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio incluir registros na REMANEJAMENTO_PROCESSAMENTO, vai remanejar o que estiver na planilha
If is_id_remanejamento_via_arquivo = 'S' Then Return True


//gvo_Aplicacao.of_Grava_Log(	"Insert remanejamento_processamento | In$$HEX1$$ed00$$ENDHEX$$cio: " + ls_Dh_Inicio_Comando + &
//										" | T$$HEX1$$e900$$ENDHEX$$rmino: " + String( DateTime( Today( ), Now( ) ), "dd/mm/yy hh:mm:ss" )  + " | Registros: " + String( ll_Linhas ) )

/* Deleta produtos controlados */
If is_id_Psico = 'N' Then
	w_Aguarde.Title = "Removendo produtos controlados..."
	Yield( )

//	ls_Dh_Inicio_Comando = String( DateTime( Today( ), Now( ) ), "dd/mm/yy hh:mm:ss" ) // Para registro de tempo no log

	Delete
	 From remanejamento_processamento
   Where cd_remanejamento = :il_cd_remanejamento
	  And cd_grupo_psico is not null
	Using SqlCa;
	
//	gvo_Aplicacao.of_Grava_Log(	"Insert remanejamento_processamento id_Psico = 'N' | In$$HEX1$$ed00$$ENDHEX$$cio: " + ls_Dh_Inicio_Comando + &
//											" | T$$HEX1$$e900$$ENDHEX$$rmino: " + String( DateTime( Today( ), Now( ) ), "dd/mm/yy hh:mm:ss" )  + " | Registros: " + String( SqlCa.SqlNRows ) )
											
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_LogDbError( gvo_Aplicacao.ivi_Log )
		SqlCa.of_RollBack( )
		Return False
	End If

	SqlCa.of_Commit( )
End If

/* Deleta produtos beauty */
If is_id_Beauty_Club = 'N' Then
	w_Aguarde.Title = "Removendo produtos beauty club..."
	Yield( )
	
//	ls_Dh_Inicio_Comando = String( DateTime( Today( ), Now( ) ), "dd/mm/yy hh:mm:ss" ) // Para registro de tempo no log

	Delete
	 From remanejamento_processamento
   Where cd_remanejamento = :il_cd_remanejamento
	  And id_beauty = 'S'
	Using SqlCa;
	
//	gvo_Aplicacao.of_Grava_Log(	"Insert remanejamento_processamento id_Beauty_Club = 'N' | In$$HEX1$$ed00$$ENDHEX$$cio: " + ls_Dh_Inicio_Comando + &
//											" | T$$HEX1$$e900$$ENDHEX$$rmino: " + String( DateTime( Today( ), Now( ) ), "dd/mm/yy hh:mm:ss" )  + " | Registros: " + String( SqlCa.SqlNRows ) )
											
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_LogDbError( gvo_Aplicacao.ivi_Log )
		SqlCa.of_RollBack( )
		Return False
	End If

	SqlCa.of_Commit( )
End If

/* Deleta produtos de geladeira */
If is_id_Geladeira = 'N' Then
	w_Aguarde.Title = "Removendo produtos de geladeira..."
	Yield( )
	
//	ls_Dh_Inicio_Comando = String( DateTime( Today( ), Now( ) ), "dd/mm/yy hh:mm:ss" ) // Para registro de tempo no log

	Delete
	 From remanejamento_processamento
   Where cd_remanejamento = :il_cd_remanejamento
	  And id_geladeira = 'S'
	Using SqlCa;
	
//	gvo_Aplicacao.of_Grava_Log(	"Insert remanejamento_processamento id_Geladeira = 'N' | In$$HEX1$$ed00$$ENDHEX$$cio: " + ls_Dh_Inicio_Comando + &
//											" | T$$HEX1$$e900$$ENDHEX$$rmino: " + String( DateTime( Today( ), Now( ) ), "dd/mm/yy hh:mm:ss" )  + " | Registros: " + String( SqlCa.SqlNRows ) )
											
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_LogDbError( gvo_Aplicacao.ivi_Log )
		SqlCa.of_RollBack( )
		Return False
	End If

	SqlCa.of_Commit( )
End If

/* Deleta produtos avulso*/
If is_id_avulso = 'N' Then
	w_Aguarde.Title = "Removendo produtos avulsos..."
	Yield( )
	
	Delete
	From remanejamento_processamento
   	Where cd_remanejamento = :il_cd_remanejamento
	  	And cd_produto in (select cd_produto from produto_geral where vl_fator_conversao > 1)
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_LogDbError( gvo_Aplicacao.ivi_Log )
		SqlCa.of_RollBack( )
		Return False
	End If

	SqlCa.of_Commit( )
End If

/* Deleta produtos de planograma */
If is_id_Planograma = 'N' Then
	w_Aguarde.Title = "Removendo produtos de planograma..."
	Yield( )
	
//	ls_Dh_Inicio_Comando = String( DateTime( Today( ), Now( ) ), "dd/mm/yy hh:mm:ss" ) // Para registro de tempo no log

	//Data: 10/11/2015
	//Programador: S$$HEX1$$e900$$ENDHEX$$rgio
	//Solicitante: Correa
	//Altera$$HEX2$$e700e300$$ENDHEX$$o: Utilizado a view e somente ir$$HEX1$$e100$$ENDHEX$$ excluir do remanejamento os produtos com m$$HEX1$$ed00$$ENDHEX$$nimos
	
	// Insere as filais e produtos de planograma em tabela tempor$$HEX1$$e100$$ENDHEX$$ria
	Insert Into remanejamento_exclusao ( cd_remanejamento, cd_filial, cd_produto )
	Select distinct :il_cd_remanejamento, v.cd_filial, v.cd_produto
	From	vw_promocao_estoque_minimo v
	Where v.id_tipo_promocao	= 'P'
		and v.id_situacao				= 'L'
		and v.qt_estoque_minimo > 0 
		and v.cd_filial in (select cd_filial from remanejamento_filial
								where cd_remanejamento = :il_cd_remanejamento)
	Using SqlCa;
	  
	 If SqlCa.SqlCode = -1 Then
		SqlCa.of_LogDbError( gvo_Aplicacao.ivi_Log )
		SqlCa.of_RollBack( )
		Return False
	End If
	
	ll_Linhas = SqlCa.SqlNRows
	
	SqlCa.of_Commit( )

	// Deleta os produtos de planograma
	Delete
	 From remanejamento_processamento
   Where cd_remanejamento = :il_cd_remanejamento
	  And Exists (	Select *
	  						From remanejamento_exclusao ex
						  Where remanejamento_processamento.cd_remanejamento	= ex.cd_remanejamento
                         	      And remanejamento_processamento.cd_filial					= ex.cd_filial
                         	      And remanejamento_processamento.cd_produto				= ex.cd_produto )
	Using SqlCa;
	
	ll_Linhas = SqlCa.SqlNRows
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_LogDbError( gvo_Aplicacao.ivi_Log )
		SqlCa.of_RollBack( )
		Return False
	End If

	SqlCa.of_Commit( )
	
	// Delete as filais e produtos de planograma da tabela tempor$$HEX1$$e100$$ENDHEX$$ria
	Delete
	 From remanejamento_exclusao
   Where cd_remanejamento = :il_cd_remanejamento
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_LogDbError( gvo_Aplicacao.ivi_Log )
		SqlCa.of_RollBack( )
		Return False
	End If

	SqlCa.of_Commit( )
	
//	gvo_Aplicacao.of_Grava_Log(	"Insert remanejamento_processamento id_Planograma = 'N' | In$$HEX1$$ed00$$ENDHEX$$cio: " + ls_Dh_Inicio_Comando + &
//										" | T$$HEX1$$e900$$ENDHEX$$rmino: " + String( DateTime( Today( ), Now( ) ), "dd/mm/yy hh:mm:ss" )  + " | Registros: " + String( ll_Linhas ) )
											
End If

/* Deleta produtos de estoque m$$HEX1$$ed00$$ENDHEX$$nimo */
If is_id_Promocao_Estoque_Minimo = 'N' Then
	w_Aguarde.Title = "Removendo produtos com estoque m$$HEX1$$ed00$$ENDHEX$$nimo de promo$$HEX2$$e700e300$$ENDHEX$$o ..."
	Yield( )

//	ls_Dh_Inicio_Comando = String( DateTime( Today( ), Now( ) ), "dd/mm/yy hh:mm:ss" ) // Para registro de tempo no log

	// Insere as filais e produtos de promocao estoque minimo em tabela tempor$$HEX1$$e100$$ENDHEX$$ria
	Insert
	   Into remanejamento_exclusao ( cd_remanejamento,
												cd_filial,
									   			cd_produto )
	Select distinct :il_cd_remanejamento,
			 pf.cd_filial,
			 pp.cd_produto
	 From promocao_sos as ps
			inner join promocao_sos_estoque_minimo as pp
				on pp.cd_promocao_sos = ps.cd_promocao_sos
			inner join promocao_sos_filial as pf
				on pf.cd_promocao_sos = ps.cd_promocao_sos
	 where ps.id_tipo_promocao	in ('G', 'N')
		and ps.id_situacao				= 'L'
		and ps.dh_inicio				<= :ldh_Movimentacao
		and ( ps.dh_termino			>= :ldh_Movimentacao
				Or ps.dh_termino is null )
		and pf.cd_filial in (select cd_filial from remanejamento_filial
								where cd_remanejamento = :il_cd_remanejamento)
	  Using SqlCa;
	  
	 If SqlCa.SqlCode = -1 Then
		SqlCa.of_LogDbError( gvo_Aplicacao.ivi_Log )
		SqlCa.of_RollBack( )
		Return False
	End If
	
	ll_Linhas = SqlCa.SqlNRows
	
	SqlCa.of_Commit( )

	// Deleta os produtos de promocao estoque minimo		
	Delete
	 From remanejamento_processamento
   Where cd_remanejamento = :il_cd_remanejamento
	  And Exists (	Select *
	  						From remanejamento_exclusao ex
						  Where remanejamento_processamento.cd_remanejamento	= ex.cd_remanejamento
                         	      And remanejamento_processamento.cd_filial					= ex.cd_filial
                         	      And remanejamento_processamento.cd_produto				= ex.cd_produto )
	Using SqlCa;
	
	ll_Linhas = SqlCa.SqlNRows

	If SqlCa.SqlCode = -1 Then
		SqlCa.of_LogDbError( gvo_Aplicacao.ivi_Log )
		SqlCa.of_RollBack( )
		Return False
	End If

	SqlCa.of_Commit( )
	
	// Delete as filais e produtos de  promocao estoque minimo da tabela tempor$$HEX1$$e100$$ENDHEX$$ria
	Delete
	 From remanejamento_exclusao
   Where cd_remanejamento = :il_cd_remanejamento
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_LogDbError( gvo_Aplicacao.ivi_Log )
		SqlCa.of_RollBack( )
		Return False
	End If

	SqlCa.of_Commit( )

//	gvo_Aplicacao.of_Grava_Log(	"Insert remanejamento_processamento id_Promocao_Estoque_Minimo = 'N' | In$$HEX1$$ed00$$ENDHEX$$cio: " + ls_Dh_Inicio_Comando + &
//											" | T$$HEX1$$e900$$ENDHEX$$rmino: " + String( DateTime( Today( ), Now( ) ), "dd/mm/yy hh:mm:ss" )  + " | Registros: " + String( ll_Linhas ) )
End If



//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
w_Aguarde.Title = "Diminui o saldo para que permane$$HEX1$$e700$$ENDHEX$$a uma unidade na filial ..."
Yield( )
	
// Delete a tabela tempor$$HEX1$$e100$$ENDHEX$$ria para garantir que vai estar limpa
Delete From remanejamento_exclusao
Where cd_remanejamento = :il_cd_remanejamento
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_LogDbError( gvo_Aplicacao.ivi_Log )
	SqlCa.of_RollBack( )
	Return False
End If

SqlCa.of_Commit( )

// Insere as filais e produtos de planograma em tabela tempor$$HEX1$$e100$$ENDHEX$$ria
Insert Into remanejamento_exclusao ( cd_remanejamento, cd_filial, cd_produto )
Select distinct :il_cd_remanejamento, v.cd_filial, v.cd_produto
From	vw_promocao_estoque_minimo v
Where v.id_tipo_promocao	= 'P'
	and v.id_situacao			= 'L'
	and v.qt_estoque_minimo > 0 
	and v.cd_filial in (select cd_filial from remanejamento_filial
								where cd_remanejamento = :il_cd_remanejamento)
Using SqlCa;
  
 If SqlCa.SqlCode = -1 Then
	SqlCa.of_LogDbError( gvo_Aplicacao.ivi_Log )
	SqlCa.of_RollBack( )
	Return False
End If

ll_Linhas = SqlCa.SqlNRows

SqlCa.of_Commit( )

//Diminui o saldo para que permane$$HEX1$$e700$$ENDHEX$$a uma unidade na filial. Para planograma retira tudo.
Update remanejamento_processamento
Set qt_saldo = qt_saldo - 1
Where qt_saldo > 0
And not exists (select *
					from remanejamento_exclusao x
					where x.cd_remanejamento = :il_cd_remanejamento
					and x.cd_filial = remanejamento_processamento.cd_filial
					and x.cd_produto = remanejamento_processamento.cd_produto)
Using SqlCa;

 If SqlCa.SqlCode = -1 Then
	SqlCa.of_LogDbError( gvo_Aplicacao.ivi_Log )
	SqlCa.of_RollBack( )
	Return False
End If

SqlCa.of_Commit( )

// Delete a tabela tempor$$HEX1$$e100$$ENDHEX$$ria
Delete From remanejamento_exclusao
Where cd_remanejamento = :il_cd_remanejamento
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_LogDbError( gvo_Aplicacao.ivi_Log )
	SqlCa.of_RollBack( )
	Return False
End If

SqlCa.of_Commit( )

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Return True
end function

public function boolean of_calcula_ultimo_mvto (date pdt_parametro);Date ldt_Ultimo_Calculo
Date ldt_Controle
Date ldt_Saldo
Date ldt_Movto_Inicial

String ls_Dh_Inicio_Comando

ldt_Controle = RelativeDate( pdt_Parametro,  - ii_qt_dias_retirada )

ldt_Saldo = gf_Primeiro_Dia_Mes(pdt_parametro)

Select cast( max( dh_calculo ) as date )
   Into :ldt_Ultimo_Calculo
  From remanejamento
  Using SqlCa;
  
Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.of_LogDbError( gvo_Aplicacao.ivi_Log )
		Return False
		
	Case 0
		If IsNull( ldt_Ultimo_Calculo ) Then
			ldt_Ultimo_Calculo = RelativeDate( pdt_Parametro,  - 10 )
		End If
		
End Choose

ls_Dh_Inicio_Comando = String( DateTime( Today( ), Now( ) ), "dd/mm/yy hh:mm:ss" ) // Para registro de tempo no log

Delete From remanejamento_movimento
		 from remanejamento_filial rf
		where rf.cd_remanejamento = :il_cd_remanejamento
		  and rf.cd_filial = remanejamento_movimento.cd_filial
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_LogDbError( gvo_Aplicacao.ivi_Log )
	SqlCa.of_RollBack( )
	Return False
End If

SqlCa.of_Commit( )

// Se for remanejamento via arquivo n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio incluir registros na REMANEJAMENTO_MOVIMENTO
If is_id_remanejamento_via_arquivo = 'S' and is_id_montagem_filial = 'S' Then Return True
		
// Data que a trigger come$$HEX1$$e700$$ENDHEX$$ou a gravar a data do ultimo movimento.
If ldt_Controle >= Date('01/06/2016') Then
	
	ldt_Movto_Inicial = Date('01/05/2016')	
	//ldt_Movto_Inicial = Date('14/04/2016')
	
	If is_id_remanejamento_via_prestes = 'S' then
		If not of_calcula_ultimo_mvto_prestes (il_cd_remanejamento, ldt_Movto_Inicial, ldt_Saldo) then
			SQLCA.of_LogDbError (gvo_Aplicacao.ivi_Log)
			SQLCA.of_rollback ()
			Return False
		End if
	else
		Insert
		  Into remanejamento_movimento( cd_filial, cd_produto, dh_ultimo_movimento )
		select s.cd_filial, s.cd_produto, coalesce(s.dh_ultimo_movimento, :ldt_Movto_Inicial)
		from saldo_produto s
		where s.cd_filial in (select cd_filial from remanejamento_filial where cd_remanejamento = :il_cd_remanejamento)
		  and s.dh_saldo = :ldt_Saldo
		  and exists (select * from resumo_reposicao_estoque r
						  where r.cd_filial = s.cd_filial
							  and r.cd_produto = s.cd_produto)
		Using Sqlca;
	End if
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_LogDbError( gvo_Aplicacao.ivi_Log )
		SqlCa.of_RollBack( )
		Return False
	End If	
	
	If is_id_remanejamento_via_prestes = 'N' then
		Insert
		  Into remanejamento_movimento( cd_filial, cd_produto, dh_ultimo_movimento )
		select s.cd_filial, s.cd_produto, coalesce(s.dh_ultimo_movimento, :ldt_Movto_Inicial) 
		from saldo_produto s
		where s.cd_filial in (select cd_filial from remanejamento_filial where cd_remanejamento = :il_cd_remanejamento)
		  and s.dh_saldo = :ldt_Saldo
		  and s.qt_saldo_final > 0
		  and not exists (select * from resumo_reposicao_estoque r
						  where r.cd_filial = s.cd_filial
							  and r.cd_produto = s.cd_produto)
		Using Sqlca;
	End if
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_LogDbError( gvo_Aplicacao.ivi_Log )
		SqlCa.of_RollBack( )
		Return False
	End If		
	
Else
	Insert
	  Into remanejamento_movimento( cd_filial, cd_produto, dh_ultimo_movimento )
	Select cd_filial, cd_produto, max( dh_resumo )
	From resumo_movto_estq_prd
	Where dh_resumo <= :pdt_Parametro
	Group by cd_filial, cd_produto
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_LogDbError( gvo_Aplicacao.ivi_Log )
		SqlCa.of_RollBack( )
		Return False
	End If
End If

SqlCa.of_Commit( )

gvo_Aplicacao.of_Grava_Log(	"Inclus$$HEX1$$e300$$ENDHEX$$o dos movimentos. | In$$HEX1$$ed00$$ENDHEX$$cio: " + ls_Dh_Inicio_Comando + &
									" | T$$HEX1$$e900$$ENDHEX$$rmino: " + String( DateTime( Today( ), Now( ) ), "dd/mm/yy hh:mm:ss" )  + " | Registros: " + String( SqlCa.SqlNRows ) )

Return True
end function

public function boolean of_fechamento_filial ();Boolean lb_Sucesso = True
Boolean lb_Recebe

Long ll_Retrieve_Vendas, ll_Retrieve_Saldo, ll_Linha_Saldo, ll_qt_saldo, ll_Produto
Long ll_Filial_Destino, ll_Saldo_Destino, ll_qt_Vendida

Decimal ldc_Custo

String ls

Delete
  From remanejamento_resultado
Where cd_remanejamento = :il_cd_remanejamento
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	Return False
Else
	SqlCa.of_Commit( )
End If

Try
	
	SetPointer( HourGlass! )

	dc_uo_ds_base lds_Saldo
	dc_uo_ds_base lds_Vendas
	
	lds_Vendas	= Create dc_uo_ds_base
	lds_Saldo		= Create dc_uo_ds_base
	
	lds_Vendas.of_ChangeDataObject( 'ds_ge115_relacao_maior_venda' )
		
	lds_Saldo.of_ChangeDataObject( 'ds_ge115_saldo_filial_fechamento' )
	ll_Retrieve_Saldo	= lds_Saldo.Retrieve( il_filial_fechamento )
	
	w_Aguarde.uo_Progress.of_SetMax( ll_Retrieve_Saldo )
	
	For ll_Linha_Saldo = 1 To ll_Retrieve_Saldo		
		ll_Produto			= lds_Saldo.Object.cd_Produto			[ ll_Linha_Saldo ]
		ll_qt_saldo			= lds_Saldo.Object.qt_saldo_final		[ ll_Linha_Saldo ]
		ldc_Custo			= lds_Saldo.Object.vl_custo_medio	[ ll_Linha_Saldo ]
		
		w_Aguarde.Title = "Calculando remanejamento. Registro " + String( ll_Linha_Saldo ) + " de " + String( ll_Retrieve_Saldo )
		w_Aguarde.uo_Progress.of_SetProgress( ll_Linha_Saldo )
		Yield( )
		SetPointer( HourGlass! )
		
		ll_Retrieve_Vendas	= lds_Vendas.Retrieve( ll_Produto )
		
		Choose Case ll_Retrieve_Vendas
			Case -1
				lb_Sucesso = False
				Exit
			Case 0 
				//N$$HEX1$$e300$$ENDHEX$$o encontrou filial p/ remanejanar
				
			Case is > 0 
				ll_Filial_Destino = lds_Vendas.Object.cd_filial [ 1 ]	//FIlial que mais vendeu - N$$HEX1$$e300$$ENDHEX$$o precisa ratear as qtdes.
				
				//Somente receber$$HEX1$$e100$$ENDHEX$$ mercadoria as filiais marcadas na dw_filiais
				If Not This.of_Verifica_Filial_Recebe(ll_Filial_Destino, Ref lb_Recebe) Then
					lb_Sucesso = False
					Exit
				End If
				
				If Not lb_Recebe Then Continue
				
				
				Insert
				 Into remanejamento_resultado
					( cd_remanejamento,
					  cd_filial_origem,
					  cd_filial_destino,
					  cd_produto,
					  qt_remanejamento,
					  vl_remanejamento,
					  id_situacao )
					Values
					 (	:il_cd_remanejamento,
						:il_Filial_Fechamento,
						:ll_Filial_Destino,
						:ll_Produto,
						:ll_qt_saldo,
						:ldc_Custo * :ll_qt_saldo,
						'P' )
					Using SqlCa;
					
				Choose Case SqlCa.SqlCode
					Case -1
						lb_Sucesso = False
						Exit
					Case Else
						SqlCa.of_Commit()
				End Choose
						
		End Choose	
	
	Next
	
Catch ( DWRuntimeError de )
	MessageBox (	"Erro", "Erro na fun$$HEX2$$e700e300$$ENDHEX$$o of_fechamento_filial. ~r~r"+ & 						
 						"Erro: "+ de.GetMessage( ), StopSign!)
	lb_Sucesso = False
	
Catch ( RuntimeError re )
	MessageBox (	"Erro", "Erro na fun$$HEX2$$e700e300$$ENDHEX$$o of_fechamento_filial. ~r~r"+ & 						
 						"Erro: "+ re.GetMessage( ), StopSign!)
	lb_Sucesso = False
		
Finally
	SetPointer( Arrow! )
	Destroy lds_Vendas
	Destroy lds_Saldo	
	Return lb_Sucesso
End Try
end function

public function boolean of_verifica_filial_retirada (long pl_filial, ref boolean pb_retirada);String ls_Retirada

select id_retirada
  Into	:ls_Retirada
from remanejamento_filial
where cd_remanejamento	= :il_cd_remanejamento
and 	cd_filial						= :pl_Filial
using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_msgDbError("Erro ao localizar a coluna id_retirada. Filial " + String( pl_Filial ) + ". " + SqlCa.SqlErrText )
	Return False
End If

pb_retirada = ( ls_Retirada = 'S' )

Return True


end function

public function boolean of_verifica_filial_recebe (long pl_filial, ref boolean pb_recebe);String ls_Recebe

select coalesce(id_recebe, 'S')
  Into	:ls_Recebe
from remanejamento_filial
where cd_remanejamento	= :il_cd_remanejamento
and 	cd_filial						= :pl_Filial
using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_msgDbError("Erro ao localizar a coluna id_recebe. Filial " + String( pl_Filial ) + ". " + SqlCa.SqlErrText )
	Return False
End If

pb_recebe = ( ls_Recebe = 'S' )

Return True


end function

public subroutine of_executa_remanejamento (string as_filiais_montagem);Boolean lb_Sucesso = False

DateTime ldh_Movimentacao

Open( w_Aguarde )
w_Aguarde.Title = "Aguarde, processando remanejamento..."


// Desenvolvimento
//ib_retirada_excesso_novo_calc_eb = True
//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o - CUIDADO!!!", "O sistema esta preparado para fazer a retirada de excesso de uma loja que entrou no novo modelo de calculo do EB.", Exclamation!)

If Trim(as_filiais_montagem) = "" Then
	SetNull( as_filiais_montagem )
End If

if is_id_remanejamento_via_prestes = 'S' then
	If This.of_Calcula_Remanejamento_Prestes () Then
		If This.of_Distribui_Excesso_Prestes () Then lb_Sucesso = True
	End If
else
	If This.of_Calcula_Remanejamento( ) Then
		If Not IsNull( il_filial_fechamento ) Then
			If This.of_Fechamento_Filial() Then lb_Sucesso = True
		Else
			If This.of_Distribui_Excesso( as_filiais_montagem ) Then lb_Sucesso = True
		End If
	End If
End if

If lb_Sucesso Then
	ldh_Movimentacao = gvo_Parametro.of_Dh_Movimentacao()	
	
	/* Grava a data de t$$HEX1$$e900$$ENDHEX$$rmino do processo */
	Update remanejamento
		 Set dh_termino_execucao	= getdate( ),
		 	  dh_calculo					= :ldh_Movimentacao
	 Where cd_remanejamento		= :il_cd_remanejamento
		Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		lb_Sucesso = False
	End If
End If

If Not lb_Sucesso Then
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_RollBack( )
		SqlCa.of_MsgDbError( )
	End If
Else
	SqlCa.of_Commit( )
End If

Close( w_Aguarde )
end subroutine

public function boolean of_distribui_excesso (string as_filiais_montagem);Boolean lb_Sucesso = True
Boolean lb_Retirada
Boolean lb_Recebe

Decimal ldc_Custo, &
		  ldc_pct_curva

Long ll_Retrieve_Excesso
Long ll_Retrieve_Vendas

Long ll_Linha_Excesso
Long ll_Find
Long ll_Produto
Long ll_Qtde_Excesso
Long ll_Qtde_Remanejamento
Long ll_Filial_Origem
Long ll_Filial_Destino
Long ll_Qtde_Remanejado
Long ll_Qtde_Eb
Long ll_Cidade
Long ll_Acrescimo_EB

String ls_Situacao
String ls_Grupo_Psico
String ls_Curva

Delete
  From remanejamento_resultado
Where cd_remanejamento = :il_cd_remanejamento
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	Return False
Else
	SqlCa.of_Commit( )
End If

dc_uo_ds_base lds_Excesso
dc_uo_ds_base lds_Vendas

lds_Excesso	= Create dc_uo_ds_base
lds_Vendas	= Create dc_uo_ds_base

If is_id_remanejamento_via_arquivo = "S" Then
	lds_Excesso.of_ChangeDataObject( 'ds_ge115_relacao_excesso_planilha' )
	ll_Retrieve_Excesso	= lds_Excesso.Retrieve( il_cd_remanejamento )
Else
	lds_Excesso.of_ChangeDataObject( 'ds_ge115_relacao_excesso' )
	ll_Retrieve_Excesso	= lds_Excesso.Retrieve( ii_qt_dias_retirada )
End If

If IsNull( as_filiais_montagem ) Then
	
	If ib_retirada_excesso_novo_calc_eb Then
		// Somente produtos sem fator de convers$$HEX1$$e300$$ENDHEX$$o
		// Considera todos os produtos idependente de ter ocorrido venda
		// $$HEX1$$c900$$ENDHEX$$ considerado o minimo e o EB, vale o maior
		lds_Vendas.of_ChangeDataObject( 'ds_ge115_relacao_vendas_excesso_novo_eb' )
	Else
		lds_Vendas.of_ChangeDataObject( 'ds_ge115_relacao_vendas' )
	End If
	
	ll_Retrieve_Vendas	= lds_Vendas.Retrieve( ii_qt_dias_remanejamento )
Else
	//Filial Montagem receber$$HEX1$$e100$$ENDHEX$$ o remanejamento conforme o EB
	lds_Vendas.of_ChangeDataObject( 'ds_ge115_relacao_filial_montagem' )
	lds_Vendas.of_AppendWhere("r.cd_filial in (" + as_filiais_montagem + ")")
	ll_Retrieve_Vendas = lds_Vendas.Retrieve()
End If

w_Aguarde.uo_Progress.of_SetMax( ll_Retrieve_Excesso )

For ll_Linha_Excesso = 1 To ll_Retrieve_Excesso	
	ll_Filial_Origem		= lds_Excesso.Object.Cd_Filial				[ ll_Linha_Excesso ]
	ll_Produto			= lds_Excesso.Object.Cd_Produto			[ ll_Linha_Excesso ]
	ll_Qtde_Excesso	= lds_Excesso.Object.Qt_Saldo				[ ll_Linha_Excesso ]
	ll_Qtde_Eb			= lds_Excesso.Object.Qt_Eb					[ ll_Linha_Excesso ]
	ldc_Custo			= lds_Excesso.Object.Vl_Custo_Medio	[ ll_Linha_Excesso ]
	
	ll_Acrescimo_EB	= 0
	
	w_Aguarde.Title = "Calculando remanejamento. Registro " + String( ll_Linha_Excesso ) + " de " + String( ll_Retrieve_Excesso )
	w_Aguarde.uo_Progress.of_SetProgress( ll_Linha_Excesso )
	Yield( )
	
	//Somente ter$$HEX1$$e100$$ENDHEX$$ retirada de mercadoria das filiais marcadas na dw_filiais
	If is_id_remanejamento_via_arquivo = "S" Then
		lb_Retirada = True
	Else
		If Not This.of_Verifica_Filial_Retirada(ll_Filial_Origem, Ref lb_Retirada) Then
			lb_Sucesso = False
			Exit
		End If
	End If
	
	If Not lb_Retirada Then Continue
	
	If IsNull ( as_filiais_montagem ) Then
					
		Choose Case is_id_Tratamento_Estoque_Base
			Case '0'	/* Ignora produtos de estoque base maior que zero */
				
				//Recalculo Pendente
				//N$$HEX1$$e300$$ENDHEX$$o retirar esta condi$$HEX2$$e700e300$$ENDHEX$$o
				If ll_Qtde_Eb > 0 Then Continue
				
			Case '1'	/* Atualiza o estoque base dos produtos para 0 */
				/*
				Update resumo_reposicao_estoque
					Set qt_estoque_base 	= 0
				Where r.cd_filial				= :ll_Filial_Origem
					and r.cd_produto		= :ll_Produto
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					lb_Sucesso = False
					Exit
				End If
				*/
		End Choose
	End If
	
	ll_Find = lds_Vendas.Find( "cd_produto = " + String( ll_Produto ), 1, ll_Retrieve_Vendas )
	
	Do While ll_Qtde_Excesso > 0
		ls_Situacao = 'P'
		
		If ll_Find = 0 Then
			ll_Qtde_Remanejamento	= ll_Qtde_Excesso
			ls_Situacao			= 'X'
			ll_Filial_Destino		= 1
			ll_Qtde_Excesso	= 0
		Else			
			
			If IsNull( as_filiais_montagem ) Then
				ll_Filial_Destino				= lds_Vendas.Object.Cd_Filial	[ ll_Find ]
				
				If (ll_Filial_Origem = ll_Filial_Destino) Then 
					If ll_Find < ll_Retrieve_Vendas Then //Controle para n$$HEX1$$e300$$ENDHEX$$o entrar em loop
						ll_Find = lds_Vendas.Find( "cd_produto = " + String( ll_Produto ), ll_Find + 1, ll_Retrieve_Vendas )
					Else
						ll_Find = 0
					End If
					
					Continue
				End If
				
				If is_id_remanejamento_via_arquivo = "S" Then
					Long ll_Saldo, ll_Eb, ll_Fat_Conv
					
					ll_Saldo		= lds_Vendas.Object.Qt_saldo				[ll_Find]
					ll_Eb			= lds_Vendas.Object.Qt_eb					[ll_Find]
					ll_Fat_Conv	= lds_Vendas.Object.vl_fator_conversao	[ll_Find]
					ls_Curva    = lds_Vendas.Object.Cd_Classe_Reposicao [ll_Find]
					ldc_pct_curva = of_pct_aumento_curva (ls_curva) / 100
					
					If ll_Fat_Conv	> 1 Then
						If ll_Saldo < ll_EB Then
							ll_Qtde_Remanejamento  = ll_Eb - ll_Saldo
							ll_Qtde_Remanejamento += Long (Ceiling (ll_Qtde_Remanejamento  * ldc_pct_curva))
						Else
							If ll_Find < ll_Retrieve_Vendas Then //Controle pra n$$HEX1$$e300$$ENDHEX$$o entrar em loop
								ll_Find = lds_Vendas.Find( "cd_produto = " + String( ll_Produto ), ll_Find + 1, ll_Retrieve_Vendas )
							Else
								ll_Find = 0
							End If
							
							Continue
						End If
					Else
						// O Default $$HEX1$$e900$$ENDHEX$$ 1, por$$HEX1$$e900$$ENDHEX$$m quando for para retirada devido a mudan$$HEX1$$e700$$ENDHEX$$a do novo calculo do EB altera para 30
						If ib_retirada_excesso_novo_calc_eb Then ll_Acrescimo_EB = 30
											
						//Chamado 279617
						If ((ll_Eb - ll_Saldo) + ll_Acrescimo_EB) > 0 Then
							ll_Qtde_Remanejamento = ((ll_Eb - ll_Saldo) + ll_Acrescimo_EB)
							ll_Qtde_Remanejamento += Long (Ceiling (ll_Qtde_Remanejamento  * ldc_pct_curva))
						Else
							If ll_Find < ll_Retrieve_Vendas Then //Controle pra n$$HEX1$$e300$$ENDHEX$$o entrar em loop
								ll_Find = lds_Vendas.Find( "cd_produto = " + String( ll_Produto ), ll_Find + 1, ll_Retrieve_Vendas )	
							Else
								ll_Find = 0
							End If
							
							Continue
						End If
					End If

				Else
					ll_Qtde_Remanejamento	= lds_Vendas.Object.Qt_Limite_Remanejamento	[ ll_Find ]
				End If
				
				//Somente receber$$HEX1$$e100$$ENDHEX$$ mercadoria as filiais marcadas na dw_filiais
				If Not This.of_Verifica_Filial_Recebe(ll_Filial_Destino, Ref lb_Recebe) Then
					lb_Sucesso = False
					Exit
				End If
				
				If Not lb_Recebe Then
					If ll_Find < ll_Retrieve_Vendas Then //Controle pra n$$HEX1$$e300$$ENDHEX$$o entrar em loop
						ll_Find = lds_Vendas.Find( "cd_produto = " + String( ll_Produto ), ll_Find + 1, ll_Retrieve_Vendas )
					Else
						ll_Find = 0
					End If
					
					Continue
				End If
				
				ls_Grupo_Psico	= lds_Vendas.Object.cd_grupo_psico	[ ll_Find ]
				ll_Cidade			= lds_Vendas.Object.cd_cidade		[ ll_Find ]
				
				// As cidades, S$$HEX1$$e300$$ENDHEX$$o jos$$HEX1$$e900$$ENDHEX$$ do rio preto e SP capital n$$HEX1$$e300$$ENDHEX$$o podem receber controlado
				// Chamado: 164137
				If (ll_Cidade = 479 or ll_Cidade = 22) and Not IsNull(ls_Grupo_Psico) Then
					If ll_Find < ll_Retrieve_Vendas Then //Controle pra n$$HEX1$$e300$$ENDHEX$$o entrar em loop
						ll_Find = lds_Vendas.Find( "cd_produto = " + String( ll_Produto ), ll_Find + 1, ll_Retrieve_Vendas )	
					Else
						ll_Find = 0
					End If
					
					Continue
				End If
			Else
				// Pode ter mais de uma filial
				ll_Filial_Destino				= lds_Vendas.Object.Cd_Filial	[ ll_Find ]
				ll_Qtde_Remanejamento	= lds_Vendas.Object.Qt_Estoque_Base					[ ll_Find ]					
			End If
			
			Select coalesce( sum( qt_remanejamento ), 0 )
			   Into :ll_qtde_remanejado
			 From remanejamento_resultado
		    Where cd_remanejamento	= :il_cd_remanejamento
			   And cd_filial_destino			= :ll_Filial_Destino
			   And cd_produto				= :ll_Produto
			Using SqlCa;
			
			Choose Case SqlCa.SqlCode
				Case -1 
					lb_Sucesso = False
					Exit
					
				Case 100 // N$$HEX1$$e300$$ENDHEX$$o encontrou
					
				Case 0
					ll_Qtde_Remanejamento -= ll_Qtde_Remanejado
					
			End Choose
			
			If ll_Qtde_Remanejamento > ll_Qtde_Excesso Then
				ll_Qtde_Remanejamento = ll_Qtde_Excesso
			End If
			
			ll_Qtde_Excesso = ll_Qtde_Excesso - ll_Qtde_Remanejamento
		End If
		
		If ll_Qtde_Remanejamento > 0 Then
		
			Insert
			 Into remanejamento_resultado
				( cd_remanejamento,
				  cd_filial_origem,
				  cd_filial_destino,
				  cd_produto,
				  qt_remanejamento,
				  vl_remanejamento,
				  id_situacao )
				Values
				 (	:il_cd_remanejamento,
					:ll_Filial_Origem,
					:ll_Filial_Destino,
					:ll_Produto,
					:ll_Qtde_Remanejamento,
					:ldc_Custo * :ll_Qtde_Remanejamento,
					:ls_Situacao )
				Using SqlCa;
				
			Choose Case SqlCa.SqlCode
				Case -1
					lb_Sucesso = False
					Exit
				Case Else
					SqlCa.of_Commit( )
			End Choose
			
		End If
		
		If ll_Qtde_Excesso = 0 Then
			Exit
		Else
			If ll_Find < ll_Retrieve_Vendas Then //Controle pra n$$HEX1$$e300$$ENDHEX$$o entrar em loop
				ll_Find = lds_Vendas.Find( "cd_produto = " + String( ll_Produto ), ll_Find + 1, ll_Retrieve_Vendas )
			Else
				ll_Find = 0
			End If
			
			If ll_Find > 0 and ll_Linha_Excesso = ll_Retrieve_Excesso Then
				// Quando $$HEX1$$e900$$ENDHEX$$ realizado remanejamento para uma loja nova o sistema esta entrando em loop
				ll_Find = 0 
			End If
		End If
	Loop
	
	If Not lb_Sucesso Then
		Exit
	End If
Next

Destroy lds_Excesso
Destroy lds_Vendas

Return lb_Sucesso
end function

public function boolean of_distribui_excesso_old ();String ls_Null

SetNull( ls_Null )

Return This.of_distribui_excesso( ls_Null )
end function

public function boolean of_calcula_remanejamento_prestes ();// Declara$$HEX2$$e700f500$$ENDHEX$$es

DateTime			ldh_Movimentacao
Long				ll_for
Long				ll_cd_filial

// Procedimentos

If not of_carrega_parametros_prestes () then
	Return False
End if

Select cd_remanejamento,
		 dh_calculo,
		 id_selecao_produto,
		 id_psico,
		 id_beauty_club,
		 id_geladeira,
		 id_planograma,
		 id_tratamento_estoque_base,
		 id_promocao_estoque_minimo,
		 qt_dias_retirada,
		 qt_dias_remanejamento,
		 cd_filial_fechamento,
		 id_avulso,
		 coalesce(id_remanejamento_via_arquivo, 'N'),
		 coalesce(id_montagem_filial, 'N'),
		 COALESCE (id_remanejamento_via_prestes, 'N')
   Into	:il_cd_remanejamento,
		:idt_dh_calculo,
		:ii_id_selecao_produto,
 		:is_id_psico,
		:is_id_beauty_club,
		:is_id_geladeira,
		:is_id_planograma,
		:is_id_tratamento_estoque_base,
		:is_id_promocao_estoque_minimo,
		:ii_qt_dias_retirada,
		:ii_qt_dias_remanejamento,
		:il_filial_fechamento,
		:is_id_avulso,
		:is_id_remanejamento_via_arquivo,
		:is_id_montagem_filial,
		:is_id_remanejamento_via_prestes
 From remanejamento
 Where cd_remanejamento	= :il_cd_remanejamento
 Using SqlCa;
		
Choose Case SqlCa.SqlCode
	Case -1
		Return False
		
	Case 100
		gvo_Aplicacao.of_Grava_Log( 'Nenhum remanejamento encontrado para processar' )
		Return False
End Choose

If is_id_remanejamento_via_prestes = 'N' then
	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'O remanejamento ' + String (il_cd_remanejamento) + ' n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ do tipo prestes e n$$HEX1$$e300$$ENDHEX$$o pode ser calculado como prestes.', Exclamation!)
	Return False
End if

ldh_Movimentacao = gvo_Parametro.of_Dh_Movimentacao( )

/* Grava a data de in$$HEX1$$ed00$$ENDHEX$$cio do processo */
Update remanejamento
	 Set dh_inicio_execucao = getdate( )
 Where cd_remanejamento = :il_cd_remanejamento
   Using SqlCa;
	
If SqlCa.SqlCode = -1 Then
	SqlCa.of_RollBack( )
	Return False
End If

w_Aguarde.Title = "Atualizando $$HEX1$$fa00$$ENDHEX$$ltima movimenta$$HEX2$$e700e300$$ENDHEX$$o dos produtos..."
Yield( )

If Not of_Calcula_Ultimo_Mvto (Date (ldh_Movimentacao)) then
	Return False
End if

Delete from remanejamento_processamento
		 from remanejamento_filial rf
		where rf.cd_filial = remanejamento_processamento.cd_filial
		  and rf.cd_remanejamento = :il_cd_remanejamento
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_LogDbError( gvo_Aplicacao.ivi_Log )
	SqlCa.of_RollBack( )
	Return False
End If

SqlCa.of_Commit( )

w_Aguarde.Title = "Excluindo dados tempor$$HEX1$$e100$$ENDHEX$$rios do remanejamento anterior..."
Yield( )

Delete From remanejamento_exclusao
 Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_LogDbError( gvo_Aplicacao.ivi_Log )
	SqlCa.of_RollBack( )
	Return False
End If

SqlCa.of_Commit( )

ids_filiais.Reset ()
ids_filiais.of_changedataobject ('ds_ge115_lista_filial_remanejamento')

ids_filiais.Retrieve (il_cd_remanejamento)

w_Aguarde.uo_Progress.of_SetMax( ids_filiais.RowCount() )

for ll_for = 1 to ids_filiais.RowCount()
	ll_cd_filial	= ids_filiais.Object.cd_filial[ll_for]

	w_Aguarde.Title = "Inserindo produtos para c$$HEX1$$e100$$ENDHEX$$lculo da filial " + String(ll_cd_filial)
	w_Aguarde.uo_Progress.of_setprogress(ll_for)
	Yield( )

	INSERT INTO remanejamento_processamento
			(cd_remanejamento,
			 cd_filial,
			 cd_produto,
			 cd_grupo_psico,
			 id_geladeira,
			 id_beauty,
			 qt_saldo,
			 dh_ultimo_mvto,
			 qt_vendida,
			 qt_eb,
			 qt_saldo_filial_destino,
			 qt_media_venda)
	SELECT
			 il_cd_remanejamento,
			 cd_filial,
			 cd_produto,
			 cd_grupo_psico,
			 id_geladeira,
			 id_beauty,
			 qt_saldo,
			 dh_ultimo_movimento,
			 qt_vendida,
			 qt_estoque_base, 
			 qt_saldo_filial_destino,
			 qt_vendida / (:il_dias_media_venda / 30.0)
	  FROM (
				SELECT
						 :il_cd_remanejamento as il_cd_remanejamento,
						 f.cd_filial,
						 g.cd_produto,
						 g.cd_grupo_psico,
						 g.id_geladeira,
						 m.id_beauty,
						 s.qt_saldo_final AS qt_saldo,
						 mvto.dh_ultimo_movimento,
						 (select coalesce( sum( qt_venda ) - sum( qt_devolucao_venda ), 0 )
							 from resumo_produto_filial as m 
							where m.cd_produto	= g.cd_produto
							  and m.dh_resumo >= convert( char( 6 ), dateadd( day, -:il_dias_media_venda, :ldh_Movimentacao ), 112 ) + '01'  
							  and m.cd_filial		= f.cd_filial ) as qt_vendida,
						 (CASE WHEN coalesce(r.id_remanejamento_via_arquivo, 'N')  = 'N' 
										THEN rre.qt_estoque_base 
								 ELSE (CASE WHEN coalesce(mi.qt_estoque_minimo, 0) > rre.qt_estoque_base 
													  THEN mi.qt_estoque_minimo 
												ELSE rre.qt_estoque_base 
										END)
						  END) qt_estoque_base, 
						 s.qt_saldo_final AS qt_saldo_filial_destino
				  FROM remanejamento as r
						inner join remanejamento_filial as f
							on f.cd_remanejamento = r.cd_remanejamento
						inner join produto_geral as g
							on g.cd_produto > 0
						inner join (select distinct (cd_produto)
										  from remanejamento_filial_produto
										 where cd_remanejamento = :il_cd_remanejamento) as rfp
							on  rfp.cd_produto = g.cd_produto		
						inner join produto_central as c
							on c.cd_produto = g.cd_produto
						inner join mix_produto as m
							on m.cd_mix_produto = c.cd_mix_produto
						inner join filial f2 on f2.cd_filial  = f.cd_filial
						inner join saldo_produto as s
							on s.cd_filial					= f2.cd_filial
							and s.cd_produto			= g.cd_produto
							and s.dh_saldo   			= f2.dh_ultimo_saldo			
						inner join remanejamento_movimento as mvto
							 on mvto.cd_filial			= f.cd_filial
						  and mvto.cd_produto		= g.cd_produto
						inner join resumo_reposicao_estoque as rre
							on rre.cd_filial				= f.cd_filial
						 and rre.cd_produto			= g.cd_produto
						left outer join resumo_estoque_minimo_filial mi
							on mi.cd_filial 		= f.cd_filial
							and mi.cd_produto 	= g.cd_produto
				 where r.cd_remanejamento	= :il_cd_remanejamento
					and f.cd_filial			= :ll_cd_filial
				 
				 Union
				 
				 Select :il_cd_remanejamento,
							f.cd_filial,
							g.cd_produto,
							g.cd_grupo_psico,
							g.id_geladeira,
							m.id_beauty,
							s.qt_saldo_final,
							mvto.dh_ultimo_movimento,
							(	select coalesce( sum( qt_venda ) - sum( qt_devolucao_venda ), 0 )
								  from resumo_produto_filial as m 
								 where m.cd_produto	= g.cd_produto
									and m.dh_resumo >= convert( char( 6 ), dateadd( day, -:il_dias_media_venda, :ldh_Movimentacao ), 112 ) + '01'  
									and m.cd_filial		= f.cd_filial ),
							(CASE WHEN coalesce(r.id_remanejamento_via_arquivo, 'N')  = 'N' 
								THEN 0 
								ELSE coalesce(mi.qt_estoque_minimo, 0)
							 END) qt_estoque_base, 
							 s.qt_saldo_final
				 from remanejamento as r
						inner join remanejamento_filial as f
							on f.cd_remanejamento = r.cd_remanejamento
						inner join produto_geral as g
							on g.cd_produto > 0
						inner join (select distinct (cd_produto)
										  from remanejamento_filial_produto
										 where cd_remanejamento = :il_cd_remanejamento) as rfp
							on  rfp.cd_produto = g.cd_produto		
						inner join produto_central as c
							on c.cd_produto = g.cd_produto
						inner join mix_produto as m
							on m.cd_mix_produto = c.cd_mix_produto
						inner join filial f2 on f2.cd_filial  = f.cd_filial
						inner join saldo_produto as s
							on s.cd_filial					= f2.cd_filial
							and s.cd_produto			= g.cd_produto
							and s.dh_saldo   			= f2.dh_ultimo_saldo						
						inner join remanejamento_movimento as mvto
							 on mvto.cd_filial			= f.cd_filial
						  and mvto.cd_produto		= g.cd_produto
						left outer join resumo_estoque_minimo_filial mi
							on mi.cd_filial 		= f.cd_filial
							and mi.cd_produto 	= g.cd_produto
				 where r.cd_remanejamento	= :il_cd_remanejamento
					and f.cd_filial			= :ll_cd_filial
					and s.qt_saldo_final    > 0
					and not exists (select * from resumo_reposicao_estoque rre
												where rre.cd_filial = f.cd_filial
													and rre.cd_produto = g.cd_produto)
			 ) rmj
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_LogDbError( gvo_Aplicacao.ivi_Log )
		SqlCa.of_RollBack( )
		Return False
	End If
	
	SqlCa.of_Commit( )
Next

Return True
end function

public function boolean of_distribui_excesso_prestes ();//Declara$$HEX2$$e700f500$$ENDHEX$$es
Boolean lb_Sucesso = True
Boolean lb_Recebe

Date		ldt_Data_Ini
Date		ldt_Data_Fim

Decimal ldc_Custo
Decimal	ldc_Media_Venda

Long ll_Retrieve_Excesso
Long ll_Retrieve_Vendas

Long ll_Linha_Excesso
Long ll_Find
Long ll_Produto
Long ll_Qtde_Excesso
Long ll_Qtde_Orig
Long ll_Qtde_Remanejamento
Long ll_Filial_Origem
Long ll_Filial_Destino
Long ll_Qtde_Remanejado
Long ll_Qtde_Eb
Long ll_Cidade
Long ll_Saldo, ll_Eb, ll_Fat_Conv
Long	ll_Media
Long	ll_find_Prestes_Destino

String ls_Situacao
String ls_Grupo_Psico

dc_uo_ds_base lds_Excesso
dc_uo_ds_base lds_Vendas

//Procedimentos

DELETE
  FROM remanejamento_resultado
 WHERE cd_remanejamento = :il_cd_remanejamento
 USING SQLCA;

If SQLCA.SQLCode = -1 then
	SQLCA.of_msgDbError ('Erro ao excluir o resultado do remanejamento ' + String (il_cd_remanejamento) + ': ' + SQLCA.SQLErrText)
	Return False
else
	DELETE
	  FROM remanejamento_fil_prod_prestes
	 WHERE cd_remanejamento = :il_cd_remanejamento
	 USING SQLCA;
	
	If SQLCA.SQLCode = -1 then
		SQLCA.of_msgDbError ('Erro ao excluir o remanejamento ' + String (il_cd_remanejamento) + ' de etiquetas prestes: ' + SQLCA.SQLErrText)
		Return False
	else
		SQLCA.of_Commit ()
	End if
End If

lds_Excesso	= Create dc_uo_ds_base
lds_Vendas	= Create dc_uo_ds_base

ldt_Data_Fim = RelativeDate (Date (gf_GetServerDate ()), ii_qt_dias_remanejamento)
ldt_Data_Ini = RelativeDate (ldt_Data_Fim, -30)
	
lds_Excesso.of_ChangeDataObject ('ds_ge115_relacao_excesso_prestes')
ll_Retrieve_Excesso = lds_Excesso.Retrieve (il_cd_remanejamento, ldt_Data_Ini, ldt_Data_Fim, idt_ini_prestes)

lds_Vendas.of_ChangeDataObject ('ds_ge115_relacao_vendas_prestes')
ll_Retrieve_Vendas  = lds_Vendas.Retrieve (il_cd_remanejamento, il_dias_ultima_venda, il_qtd_media_vendas_superior)

w_Aguarde.uo_Progress.of_SetMax (ll_Retrieve_Excesso)

Try
	For ll_Linha_Excesso = 1 To ll_Retrieve_Excesso	
		ll_Filial_Origem	= lds_Excesso.Object.Cd_Filial      [ll_Linha_Excesso]
		ll_Produto			= lds_Excesso.Object.Cd_Produto     [ll_Linha_Excesso]
		ll_Qtde_Orig     = lds_Excesso.Object.Qt_Saldo       [ll_Linha_Excesso]
		ll_Qtde_Excesso	= lds_Excesso.Object.Qtd_Etiquetas  [ll_Linha_Excesso]
		ldc_Custo			= lds_Excesso.Object.Vl_Custo_Medio [ll_Linha_Excesso]
		
		w_Aguarde.Title = 'Calculando remanejamento. Registro ' + String (ll_Linha_Excesso) + ' de ' + String (ll_Retrieve_Excesso)
		w_Aguarde.uo_Progress.of_SetProgress (ll_Linha_Excesso)
		Yield ()
		
		If ll_Qtde_Excesso <> ll_Qtde_Orig then
			//Atualiza a quantidade original a ser remanejada pois ocorreu alguma baixa desde o in$$HEX1$$ed00$$ENDHEX$$cio do processamento deste remanejamento
			If not of_registra_baixa_na_distribuicao (ll_filial_origem, ll_produto, ll_Qtde_Excesso) then
				lb_Sucesso = False
				Return False
			End if
		End if
			
		ll_Find = lds_Vendas.Find ('cd_produto = ' + String (ll_Produto) + ' and cd_filial <> ' + String (ll_Filial_Origem), 1, ll_Retrieve_Vendas)
		
		Do While ll_Qtde_Excesso > 0
			ls_Situacao = 'P'
			
			If ll_Find = 0 then
				ll_Qtde_Remanejamento = ll_Qtde_Excesso
				ls_Situacao           = 'X'
				ll_Filial_Destino     = 1
				ll_Qtde_Excesso       = 0
			else			
				ll_Filial_Destino = lds_Vendas.Object.Cd_Filial	     [ll_Find]
				ldc_Media_Venda   = lds_Vendas.Object.qt_media_venda [ll_Find]
				
				If Not This.of_Verifica_Filial_Recebe (ll_Filial_Destino, Ref lb_Recebe) then
					lb_Sucesso = False
					Exit
				End if
				
				//Este find $$HEX1$$e900$$ENDHEX$$ para verificar se a filial de destino tamb$$HEX1$$e900$$ENDHEX$$m tem o mesmo produto com etiqueta de prestes. Se tiver, ela n$$HEX1$$e300$$ENDHEX$$o deve receber de outras filiais.
				ll_find_Prestes_Destino = lds_Excesso.Find ('cd_filial = ' + String (ll_Filial_Destino) + ' and cd_produto = ' + String (ll_Produto), 1, ll_Retrieve_Excesso)
				
				If ldc_Media_Venda         < il_qtd_media_vendas_superior or &
					Not lb_Recebe               or &
					ll_find_Prestes_Destino > 0 then
					
					If ll_Find < ll_Retrieve_Vendas then //Controle para n$$HEX1$$e300$$ENDHEX$$o entrar em loop
						ll_Find = lds_Vendas.Find ('cd_produto = ' + String (ll_Produto), ll_Find + 1, ll_Retrieve_Vendas)
					else
						ll_Find = 0
					End if
					
					Continue
				End if
					
				If ldc_Media_Venda <> Int (ldc_Media_Venda) then
					ll_Media = Ceiling (ldc_Media_Venda)
				else
					ll_Media = ldc_Media_Venda
				End if
				
				If ll_Media > 20 then
					ll_Media = 20
				End if
				
				If ll_Qtde_Excesso > ll_Media then
					ll_Qtde_Remanejamento = ll_Media
				else
					ll_Qtde_Remanejamento = ll_Qtde_Excesso
				End if
				
				Select coalesce (sum (qt_remanejamento), 0)
				  Into :ll_qtde_remanejado
				  From remanejamento_resultado
				 Where cd_remanejamento	 = :il_cd_remanejamento
					And cd_filial_destino = :ll_Filial_Destino
					And cd_produto        = :ll_Produto
				Using SQLCA;
				
				Choose Case SQLCA.SQLCode
					Case -1
						SQLCA.of_msgDbError ('Erro ao verificar a quantidade do produto ' + String (ll_Produto) + ' j$$HEX1$$e100$$ENDHEX$$ destinada $$HEX1$$e000$$ENDHEX$$ filial ' + String (ll_Filial_Destino) + ': ' + SQLCA.SQLErrText)
						lb_Sucesso = False
						Exit
						
					Case 100 // N$$HEX1$$e300$$ENDHEX$$o encontrou
						
					Case 0
						If ll_Qtde_Remanejado >= ll_Qtde_Remanejamento then
							ll_Qtde_Remanejamento  = 0
						else
							ll_Qtde_Remanejamento -= ll_Qtde_Remanejado
						End if
						
				End Choose
				
				If ll_Qtde_Remanejamento > ll_Qtde_Excesso then
					ll_Qtde_Remanejamento = ll_Qtde_Excesso
				End If
				
				ll_Qtde_Excesso = ll_Qtde_Excesso - ll_Qtde_Remanejamento
			End If
			
			If ll_Qtde_Remanejamento > 0 then
			
				Insert
				 Into remanejamento_resultado
					( cd_remanejamento,
					  cd_filial_origem,
					  cd_filial_destino,
					  cd_produto,
					  qt_remanejamento,
					  vl_remanejamento,
					  id_situacao )
					Values
					 (	:il_cd_remanejamento,
						:ll_Filial_Origem,
						:ll_Filial_Destino,
						:ll_Produto,
						:ll_Qtde_Remanejamento,
						:ldc_Custo * :ll_Qtde_Remanejamento,
						:ls_Situacao )
					Using SQLCA;
					
				If SQLCA.SQLCode = -1 then
					SQLCA.of_msgDbError ('Erro ao inserir o resultado do remanejamento do produto ' + String (ll_Produto) + &
												' da filial ' + String (ll_Filial_Origem) + ' para a filial ' + String (ll_Filial_Destino) + ': ' + SQLCA.SQLErrText)
					lb_Sucesso = False
					Exit
				End if
				
			End If
			
			If ll_Qtde_Excesso = 0 then
				Exit
			else
				If ll_Find < ll_Retrieve_Vendas then //Controle pra n$$HEX1$$e300$$ENDHEX$$o entrar em loop
					ll_Find = lds_Vendas.Find( 'cd_produto = ' + String( ll_Produto ), ll_Find + 1, ll_Retrieve_Vendas )
				else
					ll_Find = 0
				End If
				
				If ll_Find > 0 and ll_Linha_Excesso = ll_Retrieve_Excesso then
					// Quando $$HEX1$$e900$$ENDHEX$$ realizado remanejamento para uma loja nova o sistema esta entrando em loop
					ll_Find = 0 
				End If
			End If
		Loop
		
		If Not lb_Sucesso then
			Exit
		End If
	Next
	
	If lb_Sucesso then
		If not of_grava_remanejamento_etiqueta (il_cd_remanejamento) then
			lb_Sucesso = False
		End if
	End if

Finally
	If lb_Sucesso then
		SQLCA.of_Commit ()
	else
		SQLCA.of_RollBack ()
	End if
	
	Destroy lds_Excesso
	Destroy lds_Vendas

End try

Return lb_Sucesso
end function

public function boolean of_grava_remanejamento_etiqueta (long al_cd_remanejamento);// Declara$$HEX2$$e700f500$$ENDHEX$$es
Date				ldt_Referencia_Fin
Date				ldt_Referencia_Ini
DateTime			ldh_validade
DateTime			ldh_inclusao
dc_uo_ds_base	lds_a_remanejar
Long				ll_lin_remanejar, ll_lin_remanejados
Long				ll_qtd_remanejar, ll_qtd_remanejados, ll_qtd_etiquetas
Long				ll_filial_origem
Long				ll_filial_destino
Long				ll_produto
Long				ll_qt_remanejamento
String			ls_nr_etiqueta
String			ls_nr_lote

// Procedimentos
lds_a_remanejar = Create dc_uo_ds_base

ldt_Referencia_Fin = RelativeDate (Date (gf_GetServerDate ()), ii_qt_dias_remanejamento)
ldt_Referencia_Ini = RelativeDate (ldt_Referencia_Fin, -30)

Try
	lds_a_remanejar.of_ChangeDataObject ('ds_ge115_lista_prestes_a_remanejar')
	ll_qtd_remanejar = lds_a_remanejar.Retrieve (il_cd_remanejamento, ldt_Referencia_Ini, ldt_Referencia_Fin, idt_ini_prestes)
	
	ids_remanejados.Reset ()
	ids_remanejados.of_ChangeDataObject ('ds_ge115_lista_prestes_remanejados')
	ll_qtd_remanejados = ids_remanejados.Retrieve (il_cd_remanejamento)
	
	w_Aguarde.uo_Progress.of_SetMax (ll_qtd_remanejados)
	
	For ll_lin_remanejados = 1 to ll_qtd_remanejados
		
		w_Aguarde.Title = 'Registrando as etiquetas a remanejar. Registro ' + String (ll_lin_remanejados) + ' de ' + String (ll_qtd_remanejados)
		w_Aguarde.uo_Progress.of_SetProgress (ll_lin_remanejados)
		Yield ()

		ll_filial_origem    = ids_remanejados.Object.cd_filial_origem  [ll_lin_remanejados]
		ll_filial_destino   = ids_remanejados.Object.cd_filial_destino [ll_lin_remanejados]
		ll_produto          = ids_remanejados.Object.cd_produto        [ll_lin_remanejados]
		ll_qt_remanejamento = ids_remanejados.Object.qt_remanejamento  [ll_lin_remanejados]
		
		lds_a_remanejar.SetFilter ('cd_filial_inclusao = ' + String (ll_filial_origem) + ' and ' + &
											'cd_produto = '         + String (ll_produto) + ' and ' + &
											'id_remanejado = '      + "'N'")
		lds_a_remanejar.Filter ()
		ll_qtd_remanejar = lds_a_remanejar.RowCount ()
		
		If ll_qt_remanejamento > ll_qtd_remanejar then
			
			If not of_registra_baixa_na_marcacao (ll_filial_origem, ll_filial_destino, ll_produto, ll_qt_remanejamento, ll_qtd_remanejar) then
				Return False
			End if
			If ll_qtd_remanejar = 0 then
				ids_remanejados.DeleteRow (ll_lin_remanejados)
				ll_lin_remanejados --
				ll_qtd_remanejados --
				Continue
			else
				ids_remanejados.Object.qt_remanejamento [ll_lin_remanejados] = ll_qtd_remanejar
			End if
			
		End if
		
		For ll_lin_remanejar = 1 to ll_qtd_remanejar
			ls_nr_etiqueta = lds_a_remanejar.Object.nr_etiqueta [ll_lin_remanejar]
			ls_nr_lote     = lds_a_remanejar.Object.nr_lote     [ll_lin_remanejar]
			ldh_validade   = lds_a_remanejar.Object.dh_validade [ll_lin_remanejar]
			ldh_inclusao   = lds_a_remanejar.Object.dh_inclusao [ll_lin_remanejar]
			
			INSERT
			  INTO remanejamento_fil_prod_prestes
				  ( cd_remanejamento
				  , cd_filial_etiqueta
				  , cd_produto
				  , nr_lote
				  , dh_validade
				  , dh_inclusao_etiqueta
				  , nr_etiqueta
				  , cd_filial_destino
				  )
			VALUES
				  ( :il_cd_remanejamento
				  , :ll_Filial_Origem
				  , :ll_Produto
				  , :ls_nr_lote
				  , :ldh_validade
				  , :ldh_inclusao
				  , :ls_nr_etiqueta
				  , :ll_Filial_Destino
				  )
			USING SQLCA;
			
			If SQLCA.SQLCode = -1 then
				SqlCa.of_msgDbError ('Erro ao inserir o remanejamento de produto prestes ' + String (ll_Produto) + &
											' da filial ' + String (ll_Filial_Origem) + ' para a filial ' + String (ll_Filial_Destino) + ': ' + SqlCa.SqlErrText)
				Return False
			End if
	
			lds_a_remanejar.Object.id_remanejado [ll_lin_remanejar] = 'S'
		Next
	Next
	
Finally
	Destroy lds_a_remanejar
End try

Return True
end function

public function boolean of_carrega_parametros_prestes ();String	ls_par_med_venda = 'NR_DIAS_MEDIA_VENDA_REMANEJTO_PRESTE'
String	ls_par_ult_venda = 'NR_DIAS_ULTIMA_VENDA_REMANEJTO_PRESTE'
String	ls_par_ini_prst  = 'DT_IMPLANTACAO_ROTINA_REMANEJTO_PRESTE'
String ls_par_media_vendas = 'QTD_MEDIA_VENDAS_REMANEJTO_PRESTE'



//Per$$HEX1$$ed00$$ENDHEX$$odo para c$$HEX1$$e100$$ENDHEX$$lculo da m$$HEX1$$e900$$ENDHEX$$dia de vendas do produto preste na filial de destino
SELECT vl_parametro
  INTO :il_dias_media_venda
  FROM parametro_geral
 WHERE cd_parametro = :ls_par_med_venda
 USING SQLCA;

Choose case SQLCA.SQLCode
	case is < 0
		SQLCA.of_msgdberror ('Erro na obten$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro ' + ls_par_med_venda)
		Return False
	case 100
		MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Par$$HEX1$$e200$$ENDHEX$$metro ' + ls_par_med_venda + ' n$$HEX1$$e300$$ENDHEX$$o cadastrado', Exclamation!)
		Return False
End choose

//Per$$HEX1$$ed00$$ENDHEX$$odo em que deve ter havido vendas do produto preste na filial de destino
SELECT vl_parametro
  INTO :il_dias_ultima_venda
  FROM parametro_geral
 WHERE cd_parametro = :ls_par_ult_venda
 USING SQLCA;

Choose case SQLCA.SQLCode
	case is < 0
		SQLCA.of_msgdberror ('Erro na obten$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro ' + ls_par_ult_venda)
		Return False
	case 100
		MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Par$$HEX1$$e200$$ENDHEX$$metro ' + ls_par_ult_venda + ' n$$HEX1$$e300$$ENDHEX$$o cadastrado', Exclamation!)
		Return False
End choose

//Data de implanta$$HEX2$$e700e300$$ENDHEX$$o da rotina de remanejamento prestes. Etiquetas anteriores n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e300$$ENDHEX$$o tratadas pela rotina
SELECT CAST (vl_parametro AS DATE)
  INTO :idt_ini_prestes
  FROM parametro_geral
 WHERE cd_parametro = :ls_par_ini_prst
 USING SQLCA;

Choose case SQLCA.SQLCode
	case is < 0
		SQLCA.of_msgdberror ('Erro na obten$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro ' + ls_par_ini_prst)
		Return False
	case 100
		MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Par$$HEX1$$e200$$ENDHEX$$metro ' + ls_par_ini_prst + ' n$$HEX1$$e300$$ENDHEX$$o cadastrado', Exclamation!)
		Return False
End choose


//Media de Vendas: Superior
SELECT vl_parametro
  INTO :il_qtd_media_vendas_superior
  FROM parametro_geral
 WHERE cd_parametro = :ls_par_media_vendas
 USING SQLCA;

Choose case SQLCA.SQLCode
	case is < 0
		SQLCA.of_msgdberror ('Erro na obten$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro ' + ls_par_media_vendas)
		Return False
	case 100
		MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Par$$HEX1$$e200$$ENDHEX$$metro ' + ls_par_media_vendas + ' n$$HEX1$$e300$$ENDHEX$$o cadastrado', Exclamation!)
		Return False
End choose


Return True
end function

public function boolean of_carrega_parametros ();Integer	li_pct
String	ls_par_pct_curva_a = 'PC_AUMENTO_REMANEJ_CURVA_A'
String	ls_par_pct_curva_b = 'PC_AUMENTO_REMANEJ_CURVA_B'
String	ls_par_pct_curva_c = 'PC_AUMENTO_REMANEJ_CURVA_C'

//Per$$HEX1$$ed00$$ENDHEX$$odo para c$$HEX1$$e100$$ENDHEX$$lculo da m$$HEX1$$e900$$ENDHEX$$dia de vendas do produto preste na filial de destino
SELECT CAST (vl_parametro AS INTEGER)
  INTO :li_pct
  FROM parametro_geral
 WHERE cd_parametro = :ls_par_pct_curva_a
 USING SQLCA;

Choose case SQLCA.SQLCode
	case is < 0
		SQLCA.of_msgdberror ('Erro na obten$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro ' + ls_par_pct_curva_a)
		Return False
	case 100
		MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Par$$HEX1$$e200$$ENDHEX$$metro ' + ls_par_pct_curva_a + ' n$$HEX1$$e300$$ENDHEX$$o cadastrado', Exclamation!)
		Return False
	case else
		ist_pct_curva[1].id_curva    = 'A'
		ist_pct_curva[1].pct_aumento = li_pct
End choose

//Per$$HEX1$$ed00$$ENDHEX$$odo em que deve ter havido vendas do produto preste na filial de destino
SELECT CAST (vl_parametro AS INTEGER)
  INTO :li_pct
  FROM parametro_geral
 WHERE cd_parametro = :ls_par_pct_curva_b
 USING SQLCA;

Choose case SQLCA.SQLCode
	case is < 0
		SQLCA.of_msgdberror ('Erro na obten$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro ' + ls_par_pct_curva_b)
		Return False
	case 100
		MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Par$$HEX1$$e200$$ENDHEX$$metro ' + ls_par_pct_curva_b + ' n$$HEX1$$e300$$ENDHEX$$o cadastrado', Exclamation!)
		Return False
	case else
		ist_pct_curva[2].id_curva    = 'B'
		ist_pct_curva[2].pct_aumento = li_pct
End choose

//Data de implanta$$HEX2$$e700e300$$ENDHEX$$o da rotina de remanejamento prestes. Etiquetas anteriores n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e300$$ENDHEX$$o tratadas pela rotina
SELECT CAST (vl_parametro AS INTEGER)
  INTO :li_pct
  FROM parametro_geral
 WHERE cd_parametro = :ls_par_pct_curva_c
 USING SQLCA;

Choose case SQLCA.SQLCode
	case is < 0
		SQLCA.of_msgdberror ('Erro na obten$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro ' + ls_par_pct_curva_c)
		Return False
	case 100
		MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Par$$HEX1$$e200$$ENDHEX$$metro ' + ls_par_pct_curva_c + ' n$$HEX1$$e300$$ENDHEX$$o cadastrado', Exclamation!)
		Return False
	case else
		ist_pct_curva[3].id_curva    = 'C'
		ist_pct_curva[3].pct_aumento = li_pct
End choose

Return True
end function

public function integer of_pct_aumento_curva (string as_curva);Integer	li_lin, &
			li_totlin

li_totlin = UpperBound (ist_pct_curva [])

For li_lin = 1 to li_totlin
	If ist_pct_curva[li_lin].id_curva = as_curva then
		Return ist_pct_curva[li_lin].pct_aumento
	End if
Next

Return 0
end function

public function boolean of_calcula_ultimo_mvto_prestes (long al_cd_remanejamento, date adt_movto_inicial, date adt_dh_saldo);//DECLARA$$HEX2$$c700d500$$ENDHEX$$ES
Date				ldt_resumo
dc_uo_ds_base	lds_movto
dc_uo_ds_base	lds_remanej
Integer			li_loop
Integer			li_mes
Integer			li_meses
Integer			li_ano
Long				ll_linhas
Long				ll_linhas_mov

//PROCEDIMENTOS
lds_remanej = Create dc_uo_ds_base
lds_movto   = Create dc_uo_ds_base

If not lds_remanej.of_changedataobject ('ds_ge115_lista_ultimo_movto') then Return False
If not lds_movto.of_changedataobject ('ds_ge115_inclui_remanejamento_movimento') then Return False

ll_linhas = lds_remanej.Retrieve (al_cd_remanejamento, adt_movto_inicial, adt_dh_saldo, idt_ini_prestes)

If ll_linhas < 0 then
	Return False
End if

lds_remanej.RowsCopy (1, ll_linhas, Primary!, lds_movto, ll_linhas_mov + 1, Primary!)

If not lds_movto.of_update () then
	Return False
End if

Return True
end function

public function boolean of_registra_baixa_na_marcacao (long al_filial_origem, long al_filial_destino, long al_produto, long al_qt_remanejamento, long al_qtd_remanejar);Long	ll_qt_remanejar

//Atualiza$$HEX2$$e700e300$$ENDHEX$$o do remanejamento resultado do c$$HEX1$$e100$$ENDHEX$$lculo
If al_qtd_remanejar = 0 then
	DELETE
	  FROM remanejamento_resultado
	 WHERE cd_remanejamento  = :il_cd_remanejamento
	 	AND cd_filial_origem  = :al_filial_origem
	 	AND cd_filial_destino = :al_filial_destino
	 	AND cd_produto        = :al_produto
	 USING SQLCA;
	
	If SQLCA.SQLCode < 0 then
		SqlCa.of_msgDbError ('Erro ao excluir o resultado de produto prestes ' + String (al_Produto) + ' da filial ' + String (al_Filial_Origem) + &
									' para a filial ' + String (al_Filial_Destino) + ' devido a baixa de etiquetas: ' + SqlCa.SqlErrText)
		Return False
	End if
else
	UPDATE remanejamento_resultado
		SET qt_remanejamento = :al_qtd_remanejar
	 WHERE cd_remanejamento  = :il_cd_remanejamento
	 	AND cd_filial_origem  = :al_filial_origem
	 	AND cd_filial_destino = :al_filial_destino
	 	AND cd_produto        = :al_produto
	 USING SQLCA;
	
	If SQLCA.SQLCode < 0 then
		SqlCa.of_msgDbError ('Erro ao atualizar o resultado de produto prestes ' + String (al_Produto) + ' da filial ' + String (al_Filial_Origem) + &
									' para a filial ' + String (al_Filial_Destino) + ' devido a baixa de etiquetas: ' + SqlCa.SqlErrText)
		Return False
	End if
End if

//Atualiza$$HEX2$$e700e300$$ENDHEX$$o do remanejamento previsto originalmente
SELECT qt_remanejar
  INTO :ll_qt_remanejar
  FROM remanejamento_filial_produto
	 WHERE cd_remanejamento = :il_cd_remanejamento
	 	AND cd_filial        = :al_filial_origem
	 	AND cd_produto       = :al_produto
	 USING SQLCA;
	
If SQLCA.SQLCode <> 0 then
	SqlCa.of_msgDbError ('Erro na leitura da tabela remanejamento_filial_produto para registro de baixa de etiqueta. ' + &
								'Produto: ' + String (al_Produto) + ' / Filial ' + String (al_Filial_Origem) + ': ' + SqlCa.SqlErrText)
	Return False
End if

ll_qt_remanejar = ll_qt_remanejar - (al_qt_remanejamento - al_qtd_remanejar)

If not of_registra_baixa_na_distribuicao (al_filial_origem, al_produto, ll_qt_remanejar) then
	Return False
End if

Return True
end function

public function boolean of_registra_baixa_na_distribuicao (long al_filial_origem, long al_produto, long al_qtd_excesso);If al_qtd_excesso = 0 then
	DELETE 
	  FROM remanejamento_filial_produto
	 WHERE cd_remanejamento = :il_cd_remanejamento
		AND cd_filial        = :al_filial_origem
		AND cd_produto       = :al_produto
	 USING SQLCA;
else
	UPDATE remanejamento_filial_produto
		SET qt_remanejar = :al_qtd_excesso
	 WHERE cd_remanejamento = :il_cd_remanejamento
		AND cd_filial        = :al_filial_origem
		AND cd_produto       = :al_produto
	 USING SQLCA;
End if

If SQLCA.SQLCode <> 0 then
	SqlCa.of_msgDbError ('Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o da tabela remanejamento_filial_produto para registro de baixa de etiqueta. ' + &
								'Produto: ' + String (al_Produto) + ' / Filial ' + String (al_Filial_Origem) + ': ' + SqlCa.SqlErrText)
	Return False
End if

Return True
end function

on uo_ge115_remanejamento.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge115_remanejamento.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;This.of_Inicializa( )

ids_filiais     = Create dc_uo_ds_base
ids_remanejados = Create dc_uo_ds_base
end event

event destructor;If IsValid (ids_filiais)     then Destroy ids_filiais
If IsValid (ids_remanejados) then Destroy ids_remanejados
end event

