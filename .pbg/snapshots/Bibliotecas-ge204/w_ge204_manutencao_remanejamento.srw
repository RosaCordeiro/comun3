HA$PBExportHeader$w_ge204_manutencao_remanejamento.srw
forward
global type w_ge204_manutencao_remanejamento from dc_w_cadastro_freeform
end type
type dw_filiais from dc_uo_dw_base within w_ge204_manutencao_remanejamento
end type
type cb_filiais from commandbutton within w_ge204_manutencao_remanejamento
end type
type cb_1 from commandbutton within w_ge204_manutencao_remanejamento
end type
type cb_localizar_filiais from commandbutton within w_ge204_manutencao_remanejamento
end type
type cb_2 from commandbutton within w_ge204_manutencao_remanejamento
end type
type cb_3 from commandbutton within w_ge204_manutencao_remanejamento
end type
type cb_4 from commandbutton within w_ge204_manutencao_remanejamento
end type
type gb_2 from groupbox within w_ge204_manutencao_remanejamento
end type
type cb_imp_prod_prestes from commandbutton within w_ge204_manutencao_remanejamento
end type
end forward

global type w_ge204_manutencao_remanejamento from dc_w_cadastro_freeform
integer width = 4014
integer height = 1932
string title = "GE204 - Remanejamento de Produtos entre Filiais"
dw_filiais dw_filiais
cb_filiais cb_filiais
cb_1 cb_1
cb_localizar_filiais cb_localizar_filiais
cb_2 cb_2
cb_3 cb_3
cb_4 cb_4
gb_2 gb_2
cb_imp_prod_prestes cb_imp_prod_prestes
end type
global w_ge204_manutencao_remanejamento w_ge204_manutencao_remanejamento

type variables
Date							idt_ini_prestes

dc_uo_ds_base				ids_dados

uo_ge115_remanejamento	io_Selecao

uo_Filial					io_Filial

String						is_Responsavel, is_Montagem_filial

Long							il_dias_validade
end variables

forward prototypes
public function long wf_proximo_codigo ()
public subroutine wf_protege_campos (boolean pb_protege)
public subroutine wf_seleciona_filiais (boolean ab_recebe)
public function boolean wf_localiza_produto (long al_produto)
public function boolean wf_planilha_importada (long al_remanejamento)
public function boolean wf_valida_tipo_remanejamento (long al_remanejamento, string as_via_arquivo)
public function boolean wf_verifica_importacao_arquivo (long al_remanejamento)
public function boolean wf_valida_uf (long al_remanejamento)
public function boolean wf_dias_movimento (long al_filial)
public function boolean wf_valida_filial_receber (long al_remanejamento)
public function boolean wf_monta_lista_filiais ()
public subroutine wf_esconde_campos (boolean ab_esconde)
public subroutine wf_esconde_campos_dw (boolean ab_esconde)
public function boolean wf_localiza_filial (long al_filial, ref string as_recebe)
public function boolean wf_carrega_parametros ()
public subroutine wf_gera_planilhas_prestes (long al_cd_remanejamento)
public function boolean wf_salva_planilha (long al_qtd_linhas, string as_nome_planilha, dc_uo_ds_base ads_dados)
public function boolean wf_prestes_importados (long al_remanejamento, ref long al_qtde)
end prototypes

public function long wf_proximo_codigo ();Long ll_Proximo

  Select coalesce( max( cd_remanejamento ), 0 )
	Into :ll_Proximo
   From remanejamento
   Using SqlCa;
	
Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.of_MsgDbError( )
		
	Case 100
		ll_Proximo = 1
		
	Case 0
		ll_Proximo++
End Choose

Return ll_Proximo
end function

public subroutine wf_protege_campos (boolean pb_protege);Integer li_Protege = 0
Integer li_Total
Integer li_Contador

String ls_Objetos[]
String ls_Objeto
String ls_Tipo

If pb_Protege Then
	li_Protege = 1
End If

dw_1.of_Lista_Objetos( ref ls_Objetos[] )
li_Total = UpperBound( ls_Objetos )

For li_Contador = 1 To li_Total
	
	ls_Objeto	= ls_Objetos[ li_Contador ]	
	ls_Tipo		= dw_1.Describe( ls_Objeto + ".Type" )
	
	If Upper( ls_Tipo ) = "COLUMN" Then
		dw_1.Modify( ls_Objeto + ".Protect = " + String( li_Protege ) )
	End If
Next

dw_Filiais.Object.Id_Recebe.Protect = li_Protege
dw_Filiais.Object.Id_Recebe.Protect = li_Protege
cb_Filiais.Enabled				= Not pb_Protege
cb_Localizar_Filiais.Enabled	= Not pb_Protege

dw_1.Object.Localizacao.Protect = 0

//O t$$HEX1$$e900$$ENDHEX$$rmino da vig$$HEX1$$ea00$$ENDHEX$$ncia sempre fica liberado para altera$$HEX2$$e700e300$$ENDHEX$$o
dw_1.Object.Dh_Termino_Vigencia.Protect = 0
end subroutine

public subroutine wf_seleciona_filiais (boolean ab_recebe);Long ll_Lojas
Long ll_Loja

Long ll_Linha
Long ll_Linhas
Long ll_Linhas_Add = 0

String ls_Agrupamento_Selecionado
String ls_Agrupamento_Existente

Try

	uo_ge216_filiais lo_Filiais
	lo_Filiais = Create uo_ge216_filiais
	
	dc_uo_ds_base lds_1
	lds_1 = Create dc_uo_ds_base
	
	lds_1.of_ChangeDataObject( 'ds_ge204_lista_filiais' )
			
	OpenWithParm( w_ge216_selecao_filiais, lo_Filiais )
	
	ll_Lojas = Message.DoubleParm
	
	If ll_Lojas > 0 Then
		lds_1.of_AppendWhere( 'f.cd_filial in ( ' + lo_Filiais.ivs_Filiais + ' ) ' )
		
		ll_Lojas = lds_1.Retrieve( )
		
		If ll_Lojas < 1 Then
			Destroy lds_1
			Destroy lo_Filiais
			Return
		End If	
	
		For ll_Loja = 1 To lds_1.RowCount( )
			// Valida$$HEX2$$e700e300$$ENDHEX$$o para permitir somente filiais de mesma UF
			If dw_Filiais.RowCount( ) > 0 Then
				ls_Agrupamento_Selecionado	= lds_1.Object.Uf_Agrupamento		[ ll_Loja ]
				ls_Agrupamento_Existente		= dw_Filiais.Object.Uf_Agrupamento	[ 1 ]
				
				If ls_Agrupamento_Selecionado <> ls_Agrupamento_Existente Then
					MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Somente filiais do mesmo estado podem compor um remanejamento.", StopSign! )
					Destroy lds_1
					Destroy lo_Filiais				
					
					If ll_Linhas_Add > 0 Then
						// Apaga as linhas adicionadas
						ll_Linhas = dw_Filiais.RowCount( )
						For ll_Loja = ll_Linhas - ll_Linhas_Add To ll_Linhas
							dw_Filiais.DeleteRow( dw_Filiais.RowCount( ) )
						Next
					End If
					
					Return
				End If
			End If
			//
			
			ll_Linha = dw_Filiais.Find( "cd_filial = " + String( lds_1.Object.Cd_Filial[ ll_Loja ] ), 1, dw_Filiais.RowCount( ) )
			
			If ll_Linha > 0 Then
				Continue
			Else
				ll_Linha = dw_Filiais.InsertRow( 0 )
				ll_Linhas_Add++
			End If
			
			dw_Filiais.Object.Cd_Filial			[ ll_Linha ] = lds_1.Object.Cd_Filial			[ ll_Loja ]
			dw_Filiais.Object.Nm_Fantasia		[ ll_Linha ] = lds_1.Object.Nm_Fantasia		[ ll_Loja ]
			dw_Filiais.Object.Uf_Agrupamento	[ ll_Linha ] = lds_1.Object.Uf_Agrupamento	[ ll_Loja ]
			
			If ab_Recebe Then
				dw_Filiais.Object.Id_retirada			[ ll_Linha ] = 'S'
			Else
				dw_Filiais.Object.Id_Selecao			[ ll_Linha ] = 'S'
			End If
		Next
	End If
	
	If dw_Filiais.ModifiedCount() > 0 Then
		ivb_Valida_Salva = True
	End If

Catch ( runtimeerror  lo_rte )
	MessageBox (	"Erro", "Erro na sela$$HEX2$$e700e300$$ENDHEX$$o das filiais. ~r~r"+ & 						
 						"Erro: "+lo_rte.GetMessage( ), StopSign!)
	
Finally
	Destroy lds_1
	Destroy lo_Filiais
End Try
end subroutine

public function boolean wf_localiza_produto (long al_produto);String	ls_Produto

Select de_produto
Into :ls_Produto
From produto_geral
Where cd_produto	= :al_Produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.of_MsgDbError("Erro ao validar o produto "+String(al_Produto)+"." )
		Return False
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado o produto "+String(al_Produto)+". A planilha n$$HEX1$$e300$$ENDHEX$$o foi importada.")
		Return False
	Case 0

End Choose

Return True
end function

public function boolean wf_planilha_importada (long al_remanejamento);Long	ll_Qtde

String	ls_Erro

Select count(*)
Into :ll_Qtde
From remanejamento_filial_produto
Where cd_remanejamento = :al_Remanejamento
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Erro ao verificar se a planilha j$$HEX1$$e100$$ENDHEX$$ foi importada." )
	Return False
End If

If ll_Qtde > 0 Then
	//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "J$$HEX1$$e100$$ENDHEX$$ foi importado uma planilha para esse remanejamento.")
	//Return False		
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "J$$HEX1$$e100$$ENDHEX$$ foi importado uma planilha para esse remanejamento.~r~rDeseja excluir os dados atuais e importar uma nova planilha ?", Question!, YesNo!, 2) = 1 Then 
		Delete 
		From remanejamento_filial_produto
		Where cd_remanejamento = :al_Remanejamento
		Using SqlCa;

		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgDbError("Erro ao verificar se a planilha j$$HEX1$$e100$$ENDHEX$$ foi importada." )
			Return False
		End If
		
		SqlCa.of_Commit();
		Return True
	End If
	
	Return False
End If

Return True
end function

public function boolean wf_valida_tipo_remanejamento (long al_remanejamento, string as_via_arquivo);String	ls_Via_Arquivo,&
		ls_Erro

Select coalesce(id_remanejamento_via_arquivo, 'N')
Into :ls_Via_Arquivo
From remanejamento
Where cd_remanejamento = :al_Remanejamento
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.of_MsgDbError("Erro no select que verifica se o remanejamento $$HEX1$$e900$$ENDHEX$$ via arquivo.")
		Return False
		
	Case 0
		If (ls_Via_Arquivo = "S") and (as_Via_Arquivo = "N") Then
			If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o",	"Esse remanejamento $$HEX1$$e900$$ENDHEX$$ via arquivo, a op$$HEX2$$e700e300$$ENDHEX$$o 'Remanejamento via arquivo?' est$$HEX1$$e100$$ENDHEX$$ desmarcada. "+&
												"As informa$$HEX2$$e700f500$$ENDHEX$$es importadas do arquivo ser$$HEX1$$e300$$ENDHEX$$o excluidas.~rDeseja continuar?", Question!, YesNo!, 2) = 1 Then
				Delete from remanejamento_filial_produto
				Where cd_remanejamento = :al_Remanejamento
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					ls_Erro	= SqlCa.SqlErrText
					SqlCa.of_Rollback()
					MessageBox("Erro", "Erro no delete da tabela 'remanejamento_filial_produto': "+ls_Erro)
					Return False
				End If
			Else
				Return False
			End If
		End If
End Choose

Return True
end function

public function boolean wf_verifica_importacao_arquivo (long al_remanejamento);Long	ll_Qtde

Select count(*)
Into :ll_Qtde
From remanejamento_filial_produto
Where cd_remanejamento = :al_Remanejamento
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Erro ao verificar se o arquivo de remanejamento foi importado." )
	Return False
End If

If ll_Qtde = 0 Then
	If dw_1.Object.id_remanejamento_via_prestes [1] = 'S' then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Esse remanejamento $$HEX1$$e900$$ENDHEX$$ de produtos prestes a vencer mas n$$HEX1$$e300$$ENDHEX$$o foi localizado nenhum produto importado.", Exclamation!)
	else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Esse remanejamento $$HEX1$$e900$$ENDHEX$$ via importa$$HEX2$$e700e300$$ENDHEX$$o de planilha mas n$$HEX1$$e300$$ENDHEX$$o foi localizado nenhum produto importado.", Exclamation!)
	End if
	Return False
End If

Return True
end function

public function boolean wf_valida_uf (long al_remanejamento);Long	ll_Qtde

select count(*) 
Into :ll_Qtde
from remanejamento_filial_produto a
inner join filial b on b.cd_filial = a.cd_filial
inner join cidade c on c.cd_cidade = b.cd_cidade
where cd_remanejamento = :al_Remanejamento
and exists (select * from remanejamento_filial a1
				inner join filial b1 on b1.cd_filial = a1.cd_filial
				inner join cidade c1 on c1.cd_cidade = b1.cd_cidade
				where a1.cd_remanejamento = a.cd_remanejamento
				and c1.cd_unidade_federacao <> c.cd_unidade_federacao)
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.of_MsgDbError("Erro ao verificar se h$$HEX1$$e100$$ENDHEX$$ filiais com UF diferente na lista importada do remanejamento." )
		Return False
End Choose

If ll_Qtde > 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "H$$HEX1$$e100$$ENDHEX$$ filiais com UF diferente na lista importada com a lista do remanejamento.")
	Return False
End If
	
Return True
end function

public function boolean wf_dias_movimento (long al_filial);Date lvdt_Primeira_Venda, ldt_Movimento_Calc_EB

Long ll_Dias_Movimento

Select dh_inicio_movimento_calculo_eb
Into :ldt_Movimento_Calc_EB
From filial
where cd_filial = :al_filial
Using SqlCa;

Choose Case SqlCa.SqlCode 
	Case 0
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Filial '"+ String(al_filial) + "  n$$HEX1$$e300$$ENDHEX$$o localizada")
	Case -1
		SqlCa.of_MsgDbError("Erro ao localizar a filial.")
		Return False
End Choose

If IsNull(ldt_Movimento_Calc_EB) Then
	select min(dh_resumo)
	Into :lvdt_Primeira_Venda
	From resumo_movimento_estoque
	where	cd_filial 			= :al_Filial
		 and	vl_venda_avista > 0
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgDbError( "Localiza$$HEX2$$e700e300$$ENDHEX$$o da primeira venda da filial '" + String(al_Filial) + "'. ")
		Return False
	End If
Else
	lvdt_Primeira_Venda = ldt_Movimento_Calc_EB
End If

Select count(*)
Into :ll_Dias_Movimento
From resumo_movimento_estoque
where	cd_filial 				= :al_Filial
	and	vl_venda_avista 	> 0
	and 	dh_resumo 			>= :lvdt_Primeira_Venda
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do n$$HEX1$$fa00$$ENDHEX$$mero de dias de vendas da filial '" + String(al_Filial) + "'. ")
	Return False
End If

If ll_Dias_Movimento > 3 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Foi marcado a op$$HEX2$$e700e300$$ENDHEX$$o para montagem de filial nova, por$$HEX1$$e900$$ENDHEX$$m a filial selecionada para receber a mercadoria j$$HEX1$$e100$$ENDHEX$$ possui movimento [" + String(al_Filial) + "].", Exclamation!)
	Return False
End If

Return True
end function

public function boolean wf_valida_filial_receber (long al_remanejamento);String ls_Filial

select top 1 b.nm_fantasia
Into :ls_Filial
from remanejamento_filial_produto a
inner join filial b on b.cd_filial = a.cd_filial
where cd_remanejamento = :al_Remanejamento
and exists (select * from remanejamento_filial a1
				where a1.cd_remanejamento = a.cd_remanejamento
				and a1.cd_filial = a.cd_filial)
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If dw_1.Object.id_remanejamento_via_prestes [1] = 'S' then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A filial [" +ls_Filial +  "] est$$HEX1$$e100$$ENDHEX$$ na rela$$HEX2$$e700e300$$ENDHEX$$o de filiais com etiquetas prestes e tamb$$HEX1$$e900$$ENDHEX$$m est$$HEX1$$e100$$ENDHEX$$ na lista para receber.", Exclamation!)
		else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A filial [" +ls_Filial +  "] que esta na planilha para retirar o excesso e tamb$$HEX1$$e900$$ENDHEX$$m esta na lista para receber/retirar.", Exclamation!)
		End if
		Return False
	Case 100
	Case -1
		SqlCa.of_MsgDbError("Erro ao verificar se a loja da planilha esta na lista para receber/retirar." )
		Return False
End Choose

Return True
end function

public function boolean wf_monta_lista_filiais ();Long ll_Contador, ll_Linha_Filiais

// Inicializa
is_Montagem_filial = ""

For ll_Linha_Filiais = 1 To dw_Filiais.RowCount( )
	If dw_1.Object.id_montagem_filial[1] = 'S' and dw_Filiais.Object.Id_Recebe[ll_Linha_Filiais] = 'S' Then 
		ll_Contador++
			
		If ll_Contador = 1 Then
			is_Montagem_filial += String(dw_Filiais.Object.cd_filial[ ll_Linha_Filiais ])
		Else
			is_Montagem_filial += ',' + String(dw_Filiais.Object.cd_filial[ ll_Linha_Filiais ])
		End If
	End If
Next

Return True
end function

public subroutine wf_esconde_campos (boolean ab_esconde);
end subroutine

public subroutine wf_esconde_campos_dw (boolean ab_esconde);If ab_esconde Then
	
	If dw_1.Object.id_remanejamento_via_prestes [1] = 'S' then
		dw_1.Object.nr_dias_valid_remanejto_preste_t.Visible = 1
		dw_1.Object.nr_dias_valid_remanejto_preste.Visible   = 1
	End if

	// INFORMA$$HEX2$$c700d500$$ENDHEX$$ES QUE N$$HEX1$$c300$$ENDHEX$$O S$$HEX1$$c300$$ENDHEX$$O UTILIZADAS
	//dw_1.Object.gb_verificacao.Visible					= 0
	
	dw_1.Object.qt_dias_retirada_t.Visible				= 0
	dw_1.Object.qt_dias_retirada.Visible				= 0
	
	//dw_1.Object.qt_dias_remanejamento_t.Visible	= 0
	//dw_1.Object.qt_dias_remanejamento.Visible		= 0
	
	dw_1.Object.id_selecao_produto[1] 				= 0
	dw_1.Object.id_selecao_produto.Protect			= 1
	
	dw_1.Object.id_geladeira.Visible							= 0
	dw_1.Object.id_planograma.Visible							= 0
	dw_1.Object.id_avulso.Visible								= 0
	dw_1.Object.id_psico.Visible									= 0
	dw_1.Object.id_beauty_club.Visible							= 0
	dw_1.Object.id_promocao_estoque_minimo.Visible 	= 0
	dw_1.Object.gb_considerar.Visible 							= 0
				
	dw_filiais.Object.id_retirada.Visible 						= 0
	dw_filiais.Object.id_retirada_t.Visible 					= 0
	dw_filiais.Object.id_retirada_l.Visible 						= 0
		
Else
	
	
	dw_1.Object.qt_dias_retirada_t.Visible				= 1
	dw_1.Object.qt_dias_retirada.Visible				= 1
	
	//dw_1.Object.gb_verificacao.Visible					= 1
	//dw_1.Object.qt_dias_remanejamento_t.Visible	= 1
	//dw_1.Object.qt_dias_remanejamento.Visible		= 1
	
	dw_1.Object.id_selecao_produto[1] 				= 0
	dw_1.Object.id_selecao_produto.Protect			= 0
	
	dw_1.Object.id_geladeira.Visible							= 1
	dw_1.Object.id_planograma.Visible							= 1
	dw_1.Object.id_avulso.Visible								= 1
	dw_1.Object.id_psico.Visible									= 1
	dw_1.Object.id_beauty_club.Visible							= 1
	dw_1.Object.id_promocao_estoque_minimo.Visible 	= 1
	dw_1.Object.gb_considerar.Visible 							= 1
	
	dw_filiais.Object.id_retirada.Visible 						= 1
	dw_filiais.Object.id_retirada_t.Visible 					= 1
	dw_filiais.Object.id_retirada_l.Visible 						= 1
	
	// INFORMA$$HEX2$$c700d500$$ENDHEX$$ES QUE N$$HEX1$$c300$$ENDHEX$$O S$$HEX1$$c300$$ENDHEX$$O UTILIZADAS
	dw_1.Object.nr_dias_valid_remanejto_preste_t.Visible = 0
	dw_1.Object.nr_dias_valid_remanejto_preste.Visible   = 0

End If


end subroutine

public function boolean wf_localiza_filial (long al_filial, ref string as_recebe);String	ls_Nome_Fantasia

Select nm_fantasia  , id_receb_remanejto 
Into :ls_Nome_Fantasia, :as_recebe 
From filial
Where cd_filial	= :al_Filial
and id_situacao    = 'A'
Using SqlCa;


Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.of_MsgDbError("Erro ao validar a filial "+String(al_Filial)+"." )
		Return False
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado a filial "+String(al_Filial)+". A planilha n$$HEX1$$e300$$ENDHEX$$o foi importada.")
		Return False
	Case 0

End Choose

Return True
end function

public function boolean wf_carrega_parametros ();String	ls_par_validade = 'NR_DIAS_VALIDADE_REMANEJTO_PRESTE'
String	ls_par_ini_prst = 'DT_IMPLANTACAO_ROTINA_REMANEJTO_PRESTE'

//LImite do prazo de validade do produto preste para que possa ser remanejado
SELECT vl_parametro
  INTO :il_dias_validade
  FROM parametro_geral
 WHERE cd_parametro = :ls_par_validade
 USING SQLCA;

Choose case SQLCA.SQLCode
	case is < 0
		SQLCA.of_msgdberror ('Erro na obten$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro ' + ls_par_validade)
		Return False
	case 100
		MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Par$$HEX1$$e200$$ENDHEX$$metro ' + ls_par_validade + ' n$$HEX1$$e300$$ENDHEX$$o cadastrado', Exclamation!)
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

Return True
end function

public subroutine wf_gera_planilhas_prestes (long al_cd_remanejamento);///// Declara$$HEX2$$e700f500$$ENDHEX$$es /////
Date		ldt_Data_Ini
Date		ldt_Data_Fim
Long		ll_linhas
String	ls_diretorio
String	ls_arquivo
String	ls_dt_inicial
String	ls_dt_final
String	ls_dt_ini_prestes
String	ls_ds_1 = 'ds_ge204_valida_produtos_prestes'
String	ls_ds_2 = 'ds_ge115_lista_filial_remanejamento'
String	ls_ds_3 = 'ds_ge204_valida_remanejto_movto'
String	ls_ds_4 = 'ds_ge204_valida_remanejto_processamento'
String	ls_ds_5 = 'ds_ge115_lista_prestes_remanejados'
String	ls_ds_6 = 'ds_ge204_valida_remanejto_etiqueta'

///// Procedimento /////

If GetFolder ('Selecione a pasta de destino das planilhas', ls_diretorio) <> 1 then
	Return
End if

Open (w_Aguarde)
w_Aguarde.uo_Progress.of_SetMax (6)

ids_dados = Create dc_uo_ds_base

Try
	///////////////////////////////////////////////////////	
	w_Aguarde.Title = 'Exportando dados... Passo 1 de 6' //
	///////////////////////////////////////////////////////	
	
	If Not ids_dados.of_ChangeDataObject (ls_ds_1) then
		MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', "Erro no ChangeDataObject da '" + ls_ds_1 + "'")
		Return
	End if
	
	ldt_Data_Fim      = RelativeDate (Date (gf_GetServerDate ()), io_Selecao.ii_qt_dias_remanejamento)
	ldt_Data_Ini      = RelativeDate (ldt_Data_Fim, -30)
	ls_dt_final       = String (ldt_Data_Fim,  'DD-MM-YYYY')
	ls_dt_inicial     = String (ldt_Data_Ini,  'DD-MM-YYYY')
	ls_dt_ini_prestes = String (idt_ini_prestes, 'DD-MM-YYYY')
	ls_arquivo        = ls_diretorio + '\' + 'Remanejamento ' + String (io_Selecao.il_cd_remanejamento) + ' - 01-qtd etiquetas a remanejar por filial'
	ll_linhas         = ids_dados.Retrieve (io_Selecao.il_cd_remanejamento, ls_dt_inicial, ls_dt_final, ls_dt_ini_prestes)
	
	If ll_linhas < 0 then
		Messagebox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', "Erro ao ler a'" + ls_ds_1 + "': " + SQLCA.SQLErrText, Exclamation!)
		Return
	End if
	
	If not wf_salva_planilha (ll_linhas, ls_arquivo, ids_dados) then
		Return
	End if
	
	w_Aguarde.uo_Progress.of_SetProgress (1)
	
	///////////////////////////////////////////////////////	
	w_Aguarde.Title = 'Exportando dados... Passo 2 de 6' //
	///////////////////////////////////////////////////////	
	
	ls_arquivo = ls_diretorio + '\' + 'Remanejamento ' + String (io_Selecao.il_cd_remanejamento) + ' - 02-filiais selecionadas para destino'
	ll_linhas  = io_Selecao.ids_filiais.RowCount ()
	
	If ll_linhas < 0 then
		Messagebox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', "Erro ao ler a'" + ls_ds_2 + "': " + String (ll_linhas), Exclamation!)
		Return
	End if
	
	If not wf_salva_planilha (ll_linhas, ls_arquivo, io_Selecao.ids_filiais) then
		Return
	End if
	
	w_Aguarde.uo_Progress.of_SetProgress (2)
	
	///////////////////////////////////////////////////////	
	w_Aguarde.Title = 'Exportando dados... Passo 3 de 6' //
	///////////////////////////////////////////////////////	
	
	If Not ids_dados.of_ChangeDataObject (ls_ds_3) then
		MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', "Erro no ChangeDataObject da '" + ls_ds_3 + "'")
		Return
	End if
	
	ls_arquivo = ls_diretorio + '\' + 'Remanejamento ' + String (io_Selecao.il_cd_remanejamento) + ' - 03-$$HEX1$$fa00$$ENDHEX$$ltimo movto do produto nas filiais de destino'
	ll_linhas  = ids_dados.Retrieve (io_Selecao.il_cd_remanejamento)
	
	If ll_linhas < 0 then
		Messagebox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', "Erro ao ler a'" + ls_ds_3 + "': " + SQLCA.SQLErrText, Exclamation!)
		Return
	End if
	
	If not wf_salva_planilha (ll_linhas, ls_arquivo, ids_dados) then
		Return
	End if
	
	w_Aguarde.uo_Progress.of_SetProgress (3)
	
	///////////////////////////////////////////////////////	
	w_Aguarde.Title = 'Exportando dados... Passo 4 de 6' //
	///////////////////////////////////////////////////////	
	
	If Not ids_dados.of_ChangeDataObject (ls_ds_4) then
		MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', "Erro no ChangeDataObject da '" + ls_ds_4 + "'")
		Return
	End if
	
	ls_arquivo = ls_diretorio + '\' + 'Remanejamento ' + String (io_Selecao.il_cd_remanejamento) + ' - 04-m$$HEX1$$e900$$ENDHEX$$dia venda produtos filiais destino'
	ll_linhas  = ids_dados.Retrieve (io_Selecao.il_cd_remanejamento)
	
	If ll_linhas < 0 then
		Messagebox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', "Erro ao ler a'" + ls_ds_4 + "': " + SQLCA.SQLErrText, Exclamation!)
		Return
	End if
	
	If not wf_salva_planilha (ll_linhas, ls_arquivo, ids_dados) then
		Return
	End if
	
	w_Aguarde.uo_Progress.of_SetProgress (4)
	
	///////////////////////////////////////////////////////	
	w_Aguarde.Title = 'Exportando dados... Passo 5 de 6' //
	///////////////////////////////////////////////////////	
	
	ls_arquivo = ls_diretorio + '\' + 'Remanejamento ' + String (io_Selecao.il_cd_remanejamento) + ' - 05-qtde de remanejamentos'
	ll_linhas  = io_Selecao.ids_remanejados.RowCount ()
	
	If ll_linhas < 0 then
		Messagebox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', "Erro ao ler a'" + ls_ds_5 + "': " + SQLCA.SQLErrText, Exclamation!)
		Return
	End if
	
	If not wf_salva_planilha (ll_linhas, ls_arquivo, io_Selecao.ids_remanejados) then
		Return
	End if
	
	w_Aguarde.uo_Progress.of_SetProgress (5)
	
	///////////////////////////////////////////////////////	
	w_Aguarde.Title = 'Exportando dados... Passo 6 de 6' //
	///////////////////////////////////////////////////////	
	
	If Not ids_dados.of_ChangeDataObject (ls_ds_6) then
		MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', "Erro no ChangeDataObject da '" + ls_ds_6 + "'")
		Return
	End if
	
	ls_arquivo = ls_diretorio + '\' + 'Remanejamento ' + String (io_Selecao.il_cd_remanejamento) + ' - 06-etiquetas remanejadas'
	ll_linhas  = ids_dados.Retrieve (io_Selecao.il_cd_remanejamento)
	
	If ll_linhas < 0 then
		Messagebox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', "Erro ao ler a'" + ls_ds_6 + "': " + SQLCA.SQLErrText, Exclamation!)
		Return
	End if
	
	If not wf_salva_planilha (ll_linhas, ls_arquivo, ids_dados) then
		Return
	End if
	
	w_Aguarde.uo_Progress.of_SetProgress (6)
	
Finally
	Destroy ids_dados
	Close (w_Aguarde)
End try
	
Return
end subroutine

public function boolean wf_salva_planilha (long al_qtd_linhas, string as_nome_planilha, dc_uo_ds_base ads_dados);Choose case al_qtd_linhas
	case is > 65000
		If ads_dados.SaveAs (as_nome_planilha + '.txt', TEXT!, True) <> 1 then
			MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', "Erro ao salvar os dados da '" + ads_dados.DataObject + "'")
			Return False
		End if
	case is > 0
		If ads_dados.SaveAs (as_nome_planilha + '.xls', Excel8!, True) <> 1 then
			MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', "Erro ao salvar os dados da '" + ads_dados.DataObject + "'")
			Return False
		End if
End choose

Return True
end function

public function boolean wf_prestes_importados (long al_remanejamento, ref long al_qtde);String	ls_Erro

SELECT COUNT (*)
  INTO :al_Qtde
  FROM remanejamento_filial_produto
 WHERE cd_remanejamento = :al_Remanejamento
 USING SQLCA;

If SQLCA.SQLCode = -1 then
	SQLCA.of_MsgDbError ('Erro ao verificar se os produtos prestes j$$HEX1$$e100$$ENDHEX$$ foram importados')
	Return False
End if

Return True
end function

on w_ge204_manutencao_remanejamento.create
int iCurrent
call super::create
this.dw_filiais=create dw_filiais
this.cb_filiais=create cb_filiais
this.cb_1=create cb_1
this.cb_localizar_filiais=create cb_localizar_filiais
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_4=create cb_4
this.gb_2=create gb_2
this.cb_imp_prod_prestes=create cb_imp_prod_prestes
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_filiais
this.Control[iCurrent+2]=this.cb_filiais
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.cb_localizar_filiais
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.cb_3
this.Control[iCurrent+7]=this.cb_4
this.Control[iCurrent+8]=this.gb_2
this.Control[iCurrent+9]=this.cb_imp_prod_prestes
end on

on w_ge204_manutencao_remanejamento.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_filiais)
destroy(this.cb_filiais)
destroy(this.cb_1)
destroy(this.cb_localizar_filiais)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.gb_2)
destroy(this.cb_imp_prod_prestes)
end on

event ue_postopen;call super::ue_postopen;dc_uo_dw_Base lvo_Update[]
lvo_Update = { dw_1, dw_Filiais }
This.wf_SetUpdate_DW( lvo_Update )

DataWindowChild lvdwc

lvdwc = dw_1.of_InsertRow_DDDW( "id_selecao_produto" )			

lvdwc.SetItem( 1, "de_grupo_produto" , "TODOS" )
lvdwc.SetItem( 1, "cd_grupo_produto" , 0 )

dw_1.Object.Id_Selecao_Produto[ 1 ]	= 0
dw_1.ivm_Menu.ivb_Permite_Excluir	= False

dw_1.ivm_Menu.mf_Excluir( False )

SetNull( dw_Filiais.ivm_Menu )

If not wf_carrega_parametros () then
	Close (This)
End if

dw_1.Object.nr_dias_valid_remanejto_preste [1] = il_dias_validade

io_Selecao	= Create uo_ge115_remanejamento
io_Filial	= Create uo_Filial
end event

event close;call super::close;If IsValid (io_Selecao) Then Destroy io_Selecao
If IsValid (io_Filial ) Then Destroy io_Filial
end event

event ue_presave;call super::ue_presave;DateTime ldh_Calculo

Date ldt_Termino_Vigencia
Date ldt_Termino_Vig_Ant

Long ll_Codigo
Long ll_Linha_Filiais
Long ll_Linhas_Filiais
Long ll_Count
Long ll_Find
Long ll_Contador_Retirada
Long ll_Contador
Long ll_Filial
Long ll_Achou

String	ls_Via_Arquivo, ls_cd_remanejamento_sap

dw_1.AcceptText( )
dw_Filiais.AcceptText( )

ll_Codigo			= dw_1.Object.Cd_Remanejamento				[1]
ldh_Calculo		= dw_1.Object.Dh_Calculo							[1]
ls_Via_Arquivo	= dw_1.Object.id_remanejamento_via_arquivo	[1]

ldt_Termino_Vigencia	= Date(dw_1.Object.dh_termino_vigencia	[1])
ldt_Termino_Vig_Ant	= Date(dw_1.Object.dh_termino_vig_ant		[1])

ls_cd_remanejamento_sap = dw_1.Object.cd_remanejamento_sap[1]

if ls_cd_remanejamento_sap <> '' and not isnull(ls_cd_remanejamento_sap) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Remanejamento importado do SAP. N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel realizar altera$$HEX2$$e700f500$$ENDHEX$$es.")
	Return False
end if

If IsNull(ldt_Termino_Vigencia) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o prazo final para a realiza$$HEX2$$e700e300$$ENDHEX$$o das transfer$$HEX1$$ea00$$ENDHEX$$ncias.")
	dw_1.Event ue_Pos(1, "dh_termino_vigencia")
	Return False
End If

If Not IsNull(ll_Codigo) Then
	If ldt_Termino_Vig_Ant <> ldt_Termino_Vigencia Then
		If ldt_Termino_Vigencia < Date(gf_GetServerDate()) Then
			If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data Prazo Final p/ Transf. $$HEX1$$e900$$ENDHEX$$ menor que a data corrente.~rO remanejamento ser$$HEX1$$e100$$ENDHEX$$ INATIVADO." + &
				"~rDeseja continuar?", Question!, YesNo!, 2) = 2 Then
				dw_1.Event ue_Pos(1, "dh_termino_vigencia")
				Return False
			End If
		End If
	End If
	
Else
	
	If ldt_Termino_Vigencia < Date(gf_GetServerDate()) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data Prazo Final p/ Transf. n$$HEX1$$e300$$ENDHEX$$o pode ser menor que a data atual.", Exclamation!)
		dw_1.Event ue_Pos(1, "dh_termino_vigencia")
		Return False
	End If
End If

If IsNull( dw_1.Object.De_Remanejamento[ 1 ] ) Or Trim( dw_1.Object.De_Remanejamento[ 1 ] ) = "" Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Preencha a descri$$HEX2$$e700e300$$ENDHEX$$o do remanejamento." )
	dw_1.Event ue_Pos( 1, 'de_remanejamento' )
	Return False
End If

If IsNull( dw_1.Object.Qt_Dias_Retirada[ 1 ] ) Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Preencha a quantidade de dias para c$$HEX1$$e100$$ENDHEX$$lculo da retirada." )
	dw_1.Event ue_Pos( 1, 'qt_dias_retirada' )
	Return False
End If

If dw_1.Object.Qt_Dias_Retirada[ 1 ] < 120 Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "A quantidade de dias para c$$HEX1$$e100$$ENDHEX$$lculo da retirada deve ser igual ou superior a 120." )
	dw_1.Event ue_Pos( 1, 'qt_dias_retirada' )
	Return False
End If

If IsNull( dw_1.Object.Qt_Dias_Remanejamento[ 1 ] ) Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Preencha a quantidade de dias para c$$HEX1$$e100$$ENDHEX$$lculo do remanejamento." )
	dw_1.Event ue_Pos( 1, 'qt_dias_remanejamento' )
	Return False
End If

//If dw_1.Object.id_filial_montagem[ 1 ] = 'S' And dw_1.Object.id_filial_fechamento[ 1 ] = 'S' Then
//	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione apenas uma op$$HEX2$$e700e300$$ENDHEX$$o: Remanejamento para montagem de~rfilial / Remanejamento para fechamento de filial." )
//	dw_1.Event ue_Pos( 1, 'cd_filial_montagem' )
//	Return False
//End If

If dw_1.Object.id_montagem_filial[ 1 ] = 'S' And dw_1.Object.id_filial_fechamento[ 1 ] = 'S' Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione apenas uma op$$HEX2$$e700e300$$ENDHEX$$o: Remanejamento para montagem de~rfilial / Remanejamento para fechamento de filial." )
	//dw_1.Event ue_Pos( 1, 'cd_filial_montagem' )
	Return False
End If

//Valida Filial Montagem
//If dw_1.Object.id_filial_montagem[ 1 ] = 'S' And ( IsNull( dw_1.Object.cd_filial_montagem[ 1 ]) Or dw_1.Object.cd_filial_montagem[ 1 ] = 0 ) Then
//	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o c$$HEX1$$f300$$ENDHEX$$digo da filial." )
//	dw_1.Event ue_Pos( 1, 'cd_filial_montagem' )
//	Return False
//End If

//If Not IsNull( dw_1.Object.cd_filial_montagem[ 1 ]) And dw_1.Object.cd_filial_montagem[ 1 ] <> 0 Then
//	io_Filial.of_Localiza_Codigo( dw_1.Object.cd_filial_montagem[ 1 ] )
//	
//	If Not io_Filial.Localizada Then
//		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "C$$HEX1$$f300$$ENDHEX$$digo da filial informado $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido." )
//		dw_1.Event ue_Pos( 1, 'cd_filial_montagem' )
//		Return False
//	End If
//	
//End If

//Valida Filial Fechamento
If dw_1.Object.id_filial_fechamento[ 1 ] = 'S' And ( IsNull( dw_1.Object.cd_filial_fechamento[ 1 ]) Or dw_1.Object.cd_filial_fechamento[ 1 ] = 0 ) Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o c$$HEX1$$f300$$ENDHEX$$digo da filial." )
	dw_1.Event ue_Pos( 1, 'cd_filial_fechamento' )
	Return False
End If

If Not IsNull( dw_1.Object.cd_filial_fechamento[ 1 ]) And dw_1.Object.cd_filial_fechamento[ 1 ] <> 0 Then
	io_Filial.of_Localiza_Codigo( dw_1.Object.cd_filial_fechamento[ 1 ] )
	
	If Not io_Filial.Localizada Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "C$$HEX1$$f300$$ENDHEX$$digo da filial informado $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido." )
		dw_1.Event ue_Pos( 1, 'cd_filial_fechamento' )
		Return False
	End If
	
End If

// Inicializa
is_Montagem_filial = ""

For ll_Linha_Filiais = 1 To dw_Filiais.RowCount( )
	If dw_Filiais.Object.Id_Recebe	[ ll_Linha_Filiais ] = 'S' Then ll_Contador++
	If dw_Filiais.Object.Id_Retirada	[ ll_Linha_Filiais ] = 'S' Then ll_Contador_Retirada++
	
	If dw_1.Object.id_montagem_filial[1] = 'S' and dw_Filiais.Object.Id_Recebe[ll_Linha_Filiais] = 'S' Then 
		
		ll_Filial = dw_Filiais.Object.cd_filial[ll_Linha_Filiais]
		
		Select count(*)
		Into :ll_Achou
		From parametro_odbc
		Where cd_filial = :ll_Filial
		Using SqlCa;
		
		If SqlCa.Sqlcode = -1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar par$$HEX1$$e200$$ENDHEX$$metro odbc. " + SqlCa.SqlErrText, StopSign!)
			Return False
		End If
		
		If ll_Achou = 0 Then
			If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Filial(is) selecionada(s) n$$HEX1$$e300$$ENDHEX$$o tem par$$HEX1$$e200$$ENDHEX$$metro odbc cadastrado. ~rDeseja continuar mesmo assim?", Question!, YesNo!, 2) = 2 Then Return False			
		End If
			
		If Not wf_dias_movimento(dw_Filiais.Object.cd_filial[ll_Linha_Filiais]) Then Return False
				
		If ll_Contador = 1 Then
			is_Montagem_filial += String(dw_Filiais.Object.cd_filial[ ll_Linha_Filiais ])
		Else
			is_Montagem_filial += ',' + String(dw_Filiais.Object.cd_filial[ ll_Linha_Filiais ])
		End If
	End If
Next

If ll_Contador < 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Selecione pelo menos uma filial para c$$HEX1$$e100$$ENDHEX$$lculo do remanejamento (RECEBER).")
	Return False
End if

If dw_1.Object.id_montagem_filial[1] = 'S' Then
	If ll_Contador > 3 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Montagem de filial~r~r" + "Selecione no m$$HEX1$$e100$$ENDHEX$$ximo 3 lojas para receber a quantidade de excesso.", Exclamation!)
	End If
End If

If dw_1.Object.id_remanejamento_via_prestes [1] = 'N' then
	If dw_1.Object.id_filial_fechamento[ 1 ] = 'N' And ll_Contador_Retirada < 1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Selecione pelo menos uma filial para a retirada de mercadoria.")
		Return False
	End if
End if

If IsNull( ll_Codigo ) Or ll_Codigo = 0 Then
	ll_Codigo = wf_Proximo_Codigo( )
	dw_1.Object.Cd_Remanejamento[ 1 ] = ll_Codigo
Else
	ll_Codigo = dw_1.Object.Cd_Remanejamento[ 1 ]
End If	

ll_Linhas_Filiais = dw_Filiais.RowCount( )

This.SetRedraw( False )

For ll_Linha_Filiais = 1 To ll_Linhas_Filiais
	dw_Filiais.Object.Cd_Remanejamento[ ll_Linha_Filiais ] = ll_Codigo
	
	If (dw_Filiais.Object.Id_Recebe[ ll_Linha_Filiais ] = 'N') and (dw_Filiais.Object.Id_Retirada[ ll_Linha_Filiais ] = 'N') Then
		dw_Filiais.DeleteRow( ll_Linha_Filiais )
		ll_Linhas_Filiais --
		ll_Linha_Filiais --
	End If	
Next

If dw_1.Object.id_remanejamento_via_prestes [1] = 'S' and dw_filiais.FilteredCount () > 0 then
	dw_filiais.SetFilter ("id_sistema_novo = 'N'")
	dw_filiais.Filter ()
	ll_Linhas_Filiais = dw_Filiais.RowCount ()
	For ll_Linha_Filiais = 1 To ll_Linhas_Filiais
		dw_Filiais.DeleteRow (ll_Linha_Filiais)
		ll_Linhas_Filiais --
		ll_Linha_Filiais --
	Next
	dw_filiais.SetFilter ("id_sistema_novo = 'S'")
	dw_filiais.Filter ()
End if

This.SetRedraw( True )

dw_1.Object.Nr_Matricula_Responsavel[ 1 ] = is_Responsavel

//Se o remanejamento era via arquivo e n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ mais, deleta as informa$$HEX2$$e700f500$$ENDHEX$$es da tabela remanejamento_filial_produto
If not wf_Valida_Tipo_Remanejamento(ll_Codigo, ls_Via_Arquivo)	Then
	Return False
End If

Return True
end event

event ue_save;call super::ue_save;If AncestorReturnValue = -1 Then 
	This.ivb_Valida_Salva = True
	Return AncestorReturnValue
End If

//Atualiza o t$$HEX1$$e900$$ENDHEX$$rmino anterior
dw_1.Object.Dh_Termino_Vig_Ant[1] = dw_1.Object.Dh_Termino_Vigencia[1]
end event

event open;call super::open;SetNull( is_Responsavel )

If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("GE204_LIBERACAO_PROCEDIMENTO", ref is_Responsavel) Then 
	Return Close( This )
End If

//If Not wf_perfil_liberado( is_Responsavel ) Then
//	Return Close( This )
//End If
end event

type dw_visual from dc_w_cadastro_freeform`dw_visual within w_ge204_manutencao_remanejamento
end type

type gb_aux_visual from dc_w_cadastro_freeform`gb_aux_visual within w_ge204_manutencao_remanejamento
end type

type dw_1 from dc_w_cadastro_freeform`dw_1 within w_ge204_manutencao_remanejamento
integer x = 50
integer y = 60
integer width = 1842
integer height = 1528
string dataobject = "dw_ge204_cadastro"
boolean vscrollbar = false
end type

event dw_1::ue_key;call super::ue_key;This.AcceptText( )

Choose Case Key		
	Case KeyEnter!
		
		Choose Case This.GetColumnName( )
			Case 'localizacao'
				This.Event ue_Retrieve( )
				
		End Choose
		
End Choose
end event

event dw_1::ue_postretrieve;call super::ue_postretrieve;Long ll_Cidade, ll_Qtde
string ls_cd_remanejamento_sap, ls_remanejamento_prestes

This.AcceptText( )

This.SetRedraw( False )

dw_Filiais.Event ue_Retrieve( )

If pl_Linhas > 0 Then
	
	ls_remanejamento_prestes =  This.Object.id_remanejamento_via_prestes [1]
	
	If IsNull (ls_remanejamento_prestes) or ls_remanejamento_prestes = 'N' then
		ls_cd_remanejamento_sap = this.Object.cd_remanejamento_sap[1]
		
		if ls_cd_remanejamento_sap <> '' and not isnull(ls_cd_remanejamento_sap) Then
		
			This.of_set_somente_leitura( false )
			
			dw_filiais.of_set_somente_leitura( false )
		
			cb_1.enabled = false
			cb_3.enabled = false
			cb_3.Visible = True
			cb_imp_prod_prestes.Visible = False
			cb_localizar_filiais.enabled = false
			cb_filiais.enabled = false
			cb_2.enabled = false
			
		else
		
			cb_1.enabled = True
			cb_3.enabled = True
			cb_3.Visible = True
			cb_imp_prod_prestes.Visible = False
			cb_localizar_filiais.enabled = True
			cb_filiais.enabled = True
			cb_2.enabled = True
		
			If Not IsNull( This.Object.Dh_Calculo[ 1 ] ) Then
				wf_Protege_Campos( True )
			Else
				wf_Protege_Campos( False )
			End If
			
		//	If Not IsNull( This.Object.cd_filial_montagem[ 1 ] ) Then
		//		This.Object.filial_montagem_t.Visible		= 1
		//		This.Object.cd_filial_montagem.Visible	= 1	
		//	Else
		//		This.Object.filial_montagem_t.Visible		= 0
		//		This.Object.cd_filial_montagem.Visible	= 0	
		//	End If
			
			If Not IsNull( This.Object.cd_filial_fechamento[ 1 ] ) Then
				This.Object.filial_fechamento_t.Visible	= 1
				This.Object.cd_filial_fechamento.Visible	= 1
			Else
				This.Object.filial_fechamento_t.Visible	= 0
				This.Object.cd_filial_fechamento.Visible	= 0
			End If
			
			If This.Object.id_remanejamento_via_arquivo[1] = "S" Then
				wf_esconde_campos_dw(True)
			Else
				wf_esconde_campos_dw(False)
			End If
			
			If This.Object.id_montagem_filial[1] = "S" and This.Object.id_remanejamento_via_arquivo[1] = "S" Then
				dw_1.Object.gb_verificacao.Visible					= 0
				dw_1.Object.qt_dias_remanejamento_t.Visible		= 0
				dw_1.Object.qt_dias_remanejamento.Visible		= 0
			End If
			
			If This.Object.id_montagem_filial[1] = "N" and This.Object.id_remanejamento_via_arquivo[1] = "S" Then
				dw_1.Object.gb_verificacao.Visible					= 1
				dw_1.Object.qt_dias_remanejamento_t.Visible		= 1
				dw_1.Object.qt_dias_remanejamento.Visible		= 1
			End If
			
			This.SetRedraw( True )
	
		end if
	else
		//Remanejamento prestes
		cb_1.Enabled                 = True
		cb_3.Visible                 = False
		cb_imp_prod_prestes.Visible  = True
		cb_localizar_filiais.Enabled = True
		cb_filiais.Enabled           = True
		cb_2.Enabled                 = True
		
		This.Object.nr_dias_valid_remanejto_preste [1] = This.Object.qt_dias_remanejamento [1]
		
		If Not IsNull (This.Object.Dh_Calculo [1]) then
			wf_Protege_Campos (True)
		else
			wf_Protege_Campos (False)
		End if
		
		This.Object.gb_verificacao.Visible          = False
		This.Object.qt_dias_remanejamento_t.Visible = False
		This.Object.qt_dias_remanejamento.Visible   = False
		wf_esconde_campos_dw (True)
		
		If Not wf_prestes_importados (this.Object.cd_remanejamento [1], Ref ll_Qtde)	then
			Return -1
		End If
		
		If ll_Qtde > 0 then
			dw_1.Object.nr_dias_valid_remanejto_preste.Protect = 1
		End if
		
		This.SetRedraw (True)
		
	End if
End If

Return AncestorReturnValue
end event

event dw_1::ue_recuperar;// OverRide
Long ll_Codigo

dw_1.AcceptText( )

io_Selecao.of_Localiza( dw_1.Object.Localizacao[ 1 ] )

If io_Selecao.ib_Localizado Then
	Return This.Retrieve( io_Selecao.il_Cd_Remanejamento )
Else
	Return -1
End If
end event

event dw_1::constructor;call super::constructor;This.ivs_Coluna_Sem_Validacao_Salva = {"localizacao"}
end event

event dw_1::ue_preinsertrow;//OverRide

If Parent.wf_Valida_Salva() > 0 Then
	This.Reset()
	dw_Filiais.Event ue_Reset()
	
	This.Object.gb_verificacao.Visible					= 1
	This.Object.qt_dias_retirada_t.Visible				= 1
	This.Object.qt_dias_retirada.Visible				= 1
	This.Object.qt_dias_remanejamento_t.Visible	= 1
	This.Object.qt_dias_remanejamento.Visible		= 1
	
	This.Object.id_selecao_produto[1] 				= 0
	This.Object.id_selecao_produto.Protect			= 0
	
	This.Object.id_geladeira.Visible							= 1
	This.Object.id_planograma.Visible							= 1
	This.Object.id_avulso.Visible								= 1
	This.Object.id_psico.Visible									= 1
	This.Object.id_beauty_club.Visible							= 1
	This.Object.id_promocao_estoque_minimo.Visible 	= 1
	This.Object.gb_considerar.Visible 							= 1
	
	dw_filiais.Object.id_retirada.Visible 						= 1
	dw_filiais.Object.id_retirada_t.Visible 					= 1
	dw_filiais.Object.id_retirada_l.Visible 						= 1
		
	Return 1
Else
	Return -1
End If
end event

event dw_1::ue_addrow;call super::ue_addrow;wf_Protege_Campos( False )

This.Object.id_selecao_produto[ 1 ] = 0

dw_1.Event ue_Pos( 1, 'de_remanejamento' )

//This.Object.filial_montagem_t.Visible		= 0
//This.Object.cd_filial_montagem.Visible	= 0
//This.Object.id_filial_montagem[ 1 ]		= 'N'

This.Object.filial_fechamento_t.Visible	= 0
This.Object.cd_filial_fechamento.Visible	= 0
This.Object.id_filial_fechamento[ 1 ]		= 'N'
This.Object.nr_dias_valid_remanejto_preste_t.Visible	= 0
This.Object.nr_dias_valid_remanejto_preste.Visible	   = 0
This.Object.nr_dias_valid_remanejto_preste [1]        = il_dias_validade

Return AncestorReturnValue
end event

event dw_1::itemchanged;call super::itemchanged;Long ll_null

//Date ldt_Termino_Vigencia

SetNull( ll_Null )

This.AcceptText()

Choose Case dwo.Name
		
	Case "id_filial_montagem"
//		If Data = 'S' Then
//			This.Object.filial_montagem_t.Visible		= 1
//			This.Object.cd_filial_montagem.Visible	= 1
//			This.Event ue_Pos(1, 'cd_filial_montagem')
//		Else
//			This.Object.cd_filial_montagem[1]			= ll_Null
//			This.Object.filial_montagem_t.Visible		= 0
//			This.Object.cd_filial_montagem.Visible	= 0
//		End If
	
	Case "id_filial_fechamento"
		If Data = 'S' Then
			This.Object.filial_fechamento_t.Visible	= 1
			This.Object.cd_filial_fechamento.Visible	= 1
			This.Event ue_Pos(1, 'cd_filial_fechamento')
		Else
			This.Object.cd_filial_fechamento[1]		= ll_Null
			This.Object.filial_fechamento_t.Visible	= 0
			This.Object.cd_filial_fechamento.Visible	= 0
		End If
	
	Case "id_remanejamento_via_arquivo"
		If Data = 'S' Then
			wf_esconde_campos_dw(True)
		Else
			wf_esconde_campos_dw(False)
		End If
		
		If This.Object.id_montagem_filial[1] = 'S' Then
			dw_1.Object.gb_verificacao.Visible					= 0
			dw_1.Object.qt_dias_remanejamento_t.Visible		= 0
			dw_1.Object.qt_dias_remanejamento.Visible		= 0
		End If
	
	Case "id_montagem_filial"
		
		If This.Object.id_remanejamento_via_arquivo[1] = 'S' Then
			If Data = 'S' Then
				dw_1.Object.gb_verificacao.Visible					= 0
				dw_1.Object.qt_dias_remanejamento_t.Visible		= 0
				dw_1.Object.qt_dias_remanejamento.Visible		= 0
			Else
				dw_1.Object.gb_verificacao.Visible					= 1
				dw_1.Object.qt_dias_remanejamento_t.Visible		= 1
				dw_1.Object.qt_dias_remanejamento.Visible		= 1
			End If
		End If
	
	case 'id_remanejamento_via_prestes'
		
		If dw_filiais.RowCount () > 0 then
			MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', &
							'N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel alterar o tipo de remanejamento depois de selecionadas as filiais de destino.~r~n' + &
							'Neste caso, abandone este remanejamento e crie outro.')
			Return 2
		End if
		
		If data = 'S' then
			dw_1.Object.qt_dias_retirada             [1] = 180
			dw_1.Object.qt_dias_remanejamento        [1] = dw_1.Object.nr_dias_valid_remanejto_preste [1]
			dw_1.Object.id_montagem_filial           [1] = 'N'
			dw_1.Object.id_psico                     [1] = 'N'
			dw_1.Object.id_beauty_club               [1] = 'N'
			dw_1.Object.id_remanejamento_via_arquivo [1] = 'S'
			dw_1.Object.gb_verificacao.Visible				= False
			dw_1.Object.qt_dias_remanejamento_t.Visible	= False
			dw_1.Object.qt_dias_remanejamento.Visible		= False
			dw_filiais.Object.id_retirada.Visible        = False
			dw_filiais.Object.id_retirada_t.Visible      = False
			dw_filiais.Object.id_retirada_l.Visible      = False
			cb_3.Visible                                 = False
			cb_imp_prod_prestes.Visible                  = True
			Post wf_esconde_campos_dw (True)
		else
			dw_1.Object.qt_dias_retirada             [1] = 180
			dw_1.Object.qt_dias_remanejamento        [1] =  60
			dw_1.Object.id_remanejamento_via_arquivo [1] = 'N'
			dw_1.Object.gb_verificacao.Visible				= True
			dw_1.Object.qt_dias_remanejamento_t.Visible	= True
			dw_1.Object.qt_dias_remanejamento.Visible		= True
			dw_filiais.Object.id_retirada.Visible        = True
			dw_filiais.Object.id_retirada_t.Visible      = True
			dw_filiais.Object.id_retirada_l.Visible      = True
			cb_3.Visible                                 = True
			cb_imp_prod_prestes.Visible                  = False
			Post wf_esconde_campos_dw(False)
		End if
		
	case 'nr_dias_valid_remanejto_preste'
		If IsNull (data) or Long (data) = 0 then
			Messagebox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Informe o prazo m$$HEX1$$e100$$ENDHEX$$ximo de validade em dias')
			Return 1
		else
			dw_1.Object.qt_dias_remanejamento [1] = Long (data)
		End if
End Choose
end event

event dw_1::ue_preupdate;call super::ue_preupdate;Long		ll_filial, &
			ll_qtd, &
			ll_remanejamento
String	ls_uf

If This.Object.id_remanejamento_via_prestes [1] = 'S' then
	
	If dw_filiais.RowCount () > 0 then
		
		//Obt$$HEX1$$e900$$ENDHEX$$m a UF da primeira filial, j$$HEX1$$e100$$ENDHEX$$ que todas est$$HEX1$$e300$$ENDHEX$$o na mesma UF
		ls_uf            = dw_filiais.Object.uf_agrupamento [1]
		ll_remanejamento = This.Object.cd_remanejamento [1]
		
		//Verifica se h$$HEX1$$e100$$ENDHEX$$ outros remanejamentos de prestes pendentes para a mesma UF.
		SELECT COUNT (DISTINCT r.cd_remanejamento)
		  INTO :ll_qtd
		  FROM remanejamento r
		       INNER JOIN remanejamento_filial rf
				         ON rf.cd_remanejamento = r.cd_remanejamento
		       INNER JOIN filial f
				         ON f.cd_filial         = rf.cd_filial
		       INNER JOIN cidade c
				         ON c.cd_cidade         = f.cd_cidade
		 WHERE r.id_remanejamento_via_prestes =  'S'
		   AND r.dh_calculo                   IS NULL
		   AND r.cd_remanejamento             <> :ll_remanejamento
			AND c.cd_unidade_federacao         = :ls_uf
		 USING SQLCA;
		
		If SQLCA.SQLCode < 0 then
			SQLCA.of_Msgdberror ('Erro ao verificar se existe remanejamento de prestes em aberto para esta mesma UF!')
			Return -1
		End if
		
		If ll_qtd > 0 then
			If MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', &
								'H$$HEX1$$e100$$ENDHEX$$ ' + String (ll_qtd) + ' remanejamento(s) de prestes ainda n$$HEX1$$e300$$ENDHEX$$o calculado(s) para esta mesma UF!~n~nDeseja continuar mesmo assim?', &
								Question!, YesNo!, 2) = 2 then
				Return -1
			End if
		End if
	End if		
End if

Return 1
end event

type gb_1 from dc_w_cadastro_freeform`gb_1 within w_ge204_manutencao_remanejamento
integer x = 27
integer width = 1897
integer height = 1716
integer taborder = 20
end type

type dw_filiais from dc_uo_dw_base within w_ge204_manutencao_remanejamento
integer x = 1966
integer y = 56
integer width = 1947
integer height = 1528
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge204_filiais"
boolean vscrollbar = true
boolean livescroll = false
end type

event constructor;call super::constructor;This.of_SetRowSelection( )
end event

event ue_recuperar;// OverRide
Long ll_Codigo

dw_1.AcceptText( )

ll_Codigo = dw_1.Object.Cd_Remanejamento[ 1]

Return This.Retrieve( ll_Codigo )
end event

event ue_preinsertrow;// OverRide

Return -1
end event

event itemchanged;call super::itemchanged;Parent.ivm_Menu.mf_Confirmar( True )
Parent.ivm_Menu.mf_Cancelar( True )

Parent.ivb_Valida_Salva = True

//Choose Case dwo.Name
//	Case 'id_selecao'
//		If Data = 'N' Then This.Object.id_retirada [ row ] = 'N'
//		
//	Case 'id_retirada'
//		If Data = 'S' Then This.Object.id_selecao [ row ] = 'S'			
//End Choose
end event

event doubleclicked;call super::doubleclicked;If dw_filiais.Event ue_DeleteRow() then
	Parent.ivm_Menu.mf_Confirmar (True)
	Parent.ivm_Menu.mf_Cancelar  (True)
	ivb_Valida_Salva = True
End if
end event

type cb_filiais from commandbutton within w_ge204_manutencao_remanejamento
integer x = 2487
integer y = 1604
integer width = 517
integer height = 104
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Marcar Todas"
end type

event clicked;Long ll_Linha

String ls_Marcar = 'S'

If This.Text = "Marcar Todas" Then
	This.Text = "Desmarcar Todas"
Else
	ls_Marcar = 'N'
	This.Text = "Marcar Todas"
End If

For ll_Linha = 1 To dw_Filiais.RowCount( )
	dw_Filiais.Object.id_recebe[ ll_Linha ] = ls_Marcar
Next
end event

type cb_1 from commandbutton within w_ge204_manutencao_remanejamento
integer x = 69
integer y = 1604
integer width = 759
integer height = 104
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Processar Remanejamento"
end type

event clicked;Boolean	lb_Sucesso = False

Long ll_Remanejamento
Long ll_Filial_Montagem

String	ls_Remanejamento_Via_Arquivo
String	ls_Remanejamento_Prestes

SetPointer (Hourglass!)

Try
	gvo_Aplicacao.ivb_Usa_Timer_Out = False

	dw_1.AcceptText( )
	
	ll_Remanejamento 					= dw_1.Object.Cd_Remanejamento					[ 1 ]
	ls_Remanejamento_Via_Arquivo	= dw_1.Object.id_remanejamento_via_arquivo	[ 1 ]
	ls_Remanejamento_Prestes      	= dw_1.Object.id_remanejamento_via_prestes	[ 1 ]
	
	If IsNull( ll_Remanejamento ) Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione ou cadastre um remanejamento para processar.", StopSign! )
		Return -1
	End If
	
	io_Selecao.of_Localiza_Codigo( ll_Remanejamento  )
	
	If Not io_Selecao.ib_Localizado Then
		Return -1
	End If
	
	If Not IsNull( io_Selecao.idt_Dh_Calculo ) Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "O remanejamento selecionado j$$HEX1$$e100$$ENDHEX$$ foi processado.", StopSign! )
		Return -1
	End If
	
	If Parent.ivb_Valida_Salva Then
		If Parent.Event ue_Save( ) = -1 Then Return
	End If
	
	If ls_Remanejamento_Via_Arquivo = "S" Then
		If Not wf_Verifica_Importacao_Arquivo(ll_Remanejamento) Then Return -1
		If Not wf_Valida_UF(ll_Remanejamento) Then	Return -1
		
		If ls_Remanejamento_Prestes = 'N' then
			If dw_1.Object.id_montagem_filial[ 1 ] = 'S' Then
				If Not wf_valida_filial_receber(ll_Remanejamento) Then Return -1
			End If
			wf_monta_lista_filiais()
		End if
		
	End If
	
	io_Selecao.of_Executa_Remanejamento(is_Montagem_filial )
	
	io_Selecao.of_Localiza_Codigo( ll_Remanejamento  )
	dw_1.Object.Dh_Calculo[ 1 ] = io_Selecao.idt_Dh_Calculo
	
	wf_Protege_Campos( True )
	lb_Sucesso = True
	
	If ls_Remanejamento_Prestes = 'S' then
		If MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', &
							'Deseja gerar planilhas com os dados usados no c$$HEX1$$e100$$ENDHEX$$lculo para confer$$HEX1$$ea00$$ENDHEX$$ncia?', &
							Question!, YesNo!, 2) = 1 then
			wf_gera_planilhas_prestes (ll_Remanejamento)
		End if
	End if

Finally
	gvo_Aplicacao.ivb_Usa_Timer_Out = True
	If lb_Sucesso then
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Processo realizado com sucesso.')
	End if
End Try

SetPointer (Arrow!)
end event

type cb_localizar_filiais from commandbutton within w_ge204_manutencao_remanejamento
integer x = 1975
integer y = 1604
integer width = 494
integer height = 104
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Localizar Filiais"
end type

event clicked;Long ll_Lojas
Long ll_Loja

Long ll_Linha
Long ll_Linhas
Long ll_Linhas_Add = 0

String ls_Agrupamento_Selecionado
String ls_Agrupamento_Existente
String ls_Recebe
String ls_remanejamento_prestes

Try

	uo_ge216_filiais lo_Filiais
	lo_Filiais = Create uo_ge216_filiais
	
	dc_uo_ds_base lds_1
	lds_1 = Create dc_uo_ds_base
	
	lds_1.of_ChangeDataObject( 'ds_ge204_lista_filiais' )
			
	OpenWithParm( w_ge216_selecao_filiais, lo_Filiais )
	
	ll_Lojas = Message.DoubleParm
	
	If ll_Lojas > 0 Then
		lds_1.of_AppendWhere( 'f.cd_filial in ( ' + lo_Filiais.ivs_Filiais + ' ) ' )
		
		ll_Lojas = lds_1.Retrieve( )
		
		If ll_Lojas < 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel recuperar os dados da ds_ge204_lista_filiais.", StopSign!)
			Return
		End If	
		
		If ll_Lojas = 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Filial n$$HEX1$$e300$$ENDHEX$$o localizada ou N$$HEX1$$c300$$ENDHEX$$O recebe remanejamento. Verifique se est$$HEX1$$e100$$ENDHEX$$ ativa ou configura$$HEX2$$e700e300$$ENDHEX$$o recebe remanejamento!.", Exclamation!)
			Return
		End If	
		
		For ll_Loja = 1 To lds_1.RowCount( )
			// Valida$$HEX2$$e700e300$$ENDHEX$$o para permitir somente filiais de mesma UF
			If dw_Filiais.RowCount( ) > 0 Then
				ls_Agrupamento_Selecionado	= lds_1.Object.Uf_Agrupamento		[ ll_Loja ]
				ls_Agrupamento_Existente		= dw_Filiais.Object.Uf_Agrupamento	[ 1 ]
				
				If ls_Agrupamento_Selecionado <> ls_Agrupamento_Existente Then
					MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Somente filiais do mesmo estado podem compor um remanejamento.", StopSign! )
					Destroy lds_1
					Destroy lo_Filiais				
					
					If ll_Linhas_Add > 0 Then
						// Apaga as linhas adicionadas
						ll_Linhas = dw_Filiais.RowCount( )
						For ll_Loja = ll_Linhas - ll_Linhas_Add To ll_Linhas
							dw_Filiais.DeleteRow( dw_Filiais.RowCount( ) )
						Next
					End If
					
					Return
				End If
			End If
			//
			
			ll_Linha = dw_Filiais.Find( "cd_filial = " + String( lds_1.Object.Cd_Filial[ ll_Loja ] ), 1, dw_Filiais.RowCount( ) )
				
			
			If ll_Linha > 0 Then
				Continue
			Else
				ls_remanejamento_prestes = dw_1.Object.id_remanejamento_via_prestes [1]
				
				If  ls_remanejamento_prestes = 'N' or &
					(ls_remanejamento_prestes = 'S' and lds_1.Object.Id_Sistema_Novo [ll_Loja] = 'S' and lds_1.Object.Id_Usa_Remanej_Prestes [ll_Loja] = 'S') then
					ll_Linha = dw_Filiais.InsertRow( 0 )
					ll_Linhas_Add++
				else
					Continue
				End if
			End If
			
			dw_Filiais.Object.Cd_Filial       [ ll_Linha ] = lds_1.Object.Cd_Filial       [ ll_Loja ]
			dw_Filiais.Object.Nm_Fantasia     [ ll_Linha ] = lds_1.Object.Nm_Fantasia     [ ll_Loja ]
			dw_Filiais.Object.Uf_Agrupamento  [ ll_Linha ] = lds_1.Object.Uf_Agrupamento  [ ll_Loja ]
			dw_Filiais.Object.Id_Recebe       [ ll_Linha ] = 'S'
			dw_Filiais.Object.Id_retirada     [ ll_Linha ] = 'S'
			dw_Filiais.Object.Id_Sistema_Novo [ ll_Linha ] = lds_1.Object.Id_Sistema_Novo [ ll_Loja ]
		Next
	End If
	
	If dw_Filiais.ModifiedCount() > 0 Then
		ivm_Menu.mf_Confirmar( True )
		ivm_Menu.mf_Cancelar( True )
		ivb_Valida_Salva = True
		dw_Filiais.setSort("nm_fantasia")
		dw_Filiais.Sort()
	End If

Catch ( runtimeerror  lo_rte )
	MessageBox (	"Erro", "Erro na sela$$HEX2$$e700e300$$ENDHEX$$o das filiais. ~r~r"+ & 						
 						"Erro: "+lo_rte.GetMessage( ), StopSign!)
	
Finally
	Destroy lds_1
	Destroy lo_Filiais	
End Try
end event

type cb_2 from commandbutton within w_ge204_manutencao_remanejamento
integer x = 3109
integer y = 1604
integer width = 731
integer height = 104
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Localizar Filial p/ Semana"
end type

event clicked;String	ls_Retorno,&
		ls_Uf,&
		ls_Agrupamento_Selecionado,&
		ls_Agrupamento_Existente, &
		ls_remanejamento_prestes
		
Long 	ll_Semana,&
		ll_Lojas,&
		ll_Loja,&
		ll_Linha,&
		ll_Linhas,&
		ll_Linhas_Add = 0,&
		ll_Qtde,&
		ll_Filial

uo_ge216_filiais lo_Filiais

dc_uo_ds_base lds_1

Open(w_ge204_sel_filial_grupo_semana)

ls_Retorno = Message.StringParm

If ls_Retorno = "" Then
	Return 1
End If

ls_Uf			= Mid(Ls_Retorno, 1, 2)
ll_Semana	= Long(Mid(Ls_Retorno, 3))

Try
	Try
		lo_Filiais = Create uo_ge216_filiais
		
		lds_1 = Create dc_uo_ds_base
		
		lds_1.of_ChangeDataObject( 'ds_ge204_lista_filiais' )
				
		lds_1.of_AppendWhere( "c.cd_unidade_federacao =  '"+ ls_Uf +"'")
		
		ll_Lojas = lds_1.Retrieve( )
		
		If ll_Lojas < 1 Then
			Return 1
		End If	
		
		ls_remanejamento_prestes = dw_1.Object.id_remanejamento_via_prestes [1]
		
		For ll_Loja = 1 To lds_1.RowCount( )
			// Valida$$HEX2$$e700e300$$ENDHEX$$o para permitir somente filiais de mesma UF
			If dw_Filiais.RowCount( ) > 0 Then
				ls_Agrupamento_Selecionado	= lds_1.Object.Uf_Agrupamento		[ ll_Loja ]
				ls_Agrupamento_Existente		= dw_Filiais.Object.Uf_Agrupamento	[ 1 ]
				
				If ls_Agrupamento_Selecionado <> ls_Agrupamento_Existente Then
					MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Somente filiais do mesmo estado podem compor um remanejamento.", StopSign! )			
					
					If ll_Linhas_Add > 0 Then
						// Apaga as linhas adicionadas
						ll_Linhas = dw_Filiais.RowCount( )
						For ll_Loja = ll_Linhas - ll_Linhas_Add To ll_Linhas
							dw_Filiais.DeleteRow( dw_Filiais.RowCount( ) )
						Next
					End If
					
					Return
				End If
			End If
			//
			
			ll_Linha = dw_Filiais.Find( "cd_filial = " + String( lds_1.Object.Cd_Filial[ ll_Loja ] ), 1, dw_Filiais.RowCount( ) )
			
			If ll_Linha > 0 Then
				Continue
			Else
				If  ls_remanejamento_prestes = 'N' or &
					(ls_remanejamento_prestes = 'S' and lds_1.Object.Id_Sistema_Novo [ll_Loja] = 'S') then
					ll_Linha = dw_Filiais.InsertRow( 0 )
					ll_Linhas_Add++
				else
					Continue
				End if
			End If
			
			dw_Filiais.Object.Cd_Filial				[ ll_Linha ] = lds_1.Object.Cd_Filial				[ ll_Loja ]
			dw_Filiais.Object.Nm_Fantasia			[ ll_Linha ] = lds_1.Object.Nm_Fantasia			[ ll_Loja ]
			dw_Filiais.Object.Uf_Agrupamento		[ ll_Linha ] = lds_1.Object.Uf_Agrupamento		[ ll_Loja ]
			dw_Filiais.Object.Id_Recebe				[ ll_Linha ] = 'S'
			dw_Filiais.Object.Id_Sistema_Novo	[ ll_Linha ] = lds_1.Object.Id_Sistema_Novo	[ ll_Loja ]
			
			ll_Filial = dw_Filiais.Object.Cd_Filial [ ll_Linha ]
			
			select count(*)
			Into :ll_Qtde
			from remanejamento_filial_semana a
			where cd_filial 		= :ll_Filial
				and id_semana = :ll_Semana
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				MessageBox("Erro", "Erro ao verificar se a filial est$$HEX1$$e100$$ENDHEX$$ na semana selecionada: "+SqlCa.SqlErrText)
				Return 1
			End If
			
			If ll_Qtde > 0 Then
				dw_Filiais.Object.Id_retirada			[ ll_Linha ] = 'S'
			Else
				dw_Filiais.Object.Id_retirada			[ ll_Linha ] = 'N'
			End If
		Next
		
		If dw_Filiais.ModifiedCount() > 0 Then
			ivm_Menu.mf_Confirmar( True )
			ivm_Menu.mf_Cancelar( True )
			ivb_Valida_Salva = True
			dw_Filiais.setSort("nm_fantasia")
			dw_Filiais.Sort()
		End If

	Catch ( runtimeerror  lo_rte )
		MessageBox (	"Erro", "Erro na sela$$HEX2$$e700e300$$ENDHEX$$o das filiais. ~r~r"+ & 						
							"Erro: "+lo_rte.GetMessage( ), StopSign!)
	End Try		
Finally
	Destroy lds_1
	Destroy lo_Filiais	
End Try
end event

type cb_3 from commandbutton within w_ge204_manutencao_remanejamento
integer x = 928
integer y = 1604
integer width = 923
integer height = 104
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Importar de Planilha de Excesso"
end type

event clicked;Long	ll_Retorno,&
		ll_Linhas,&
		ll_Linha,&
		ll_Filial,&
		ll_Produto,&
		ll_Find,&
		ll_Qtde,&
		ll_Remanejamento,&
		ll_Row,&
		ll_filial_erro [],&
		lvl_Parte

String	ls_Arquivo,&
		ls_Nome,&
		ls_Nome_Fantasia,&
		ls_UF,&
		ls_Erro,&
		ls_Via_Arquivo,&
		ls_Recebe
		
Boolean lb_achou
		
                               
dc_uo_excel lo_Excel                   

Any        la_Dado,&
			la_Dado_b,&
			la_Dado_c

dc_uo_ds_base lds_Produtos

ll_Remanejamento	= dw_1.Object.cd_remanejamento					[1]
ls_Via_Arquivo		= dw_1.Object.id_remanejamento_via_arquivo		[1]


If IsNull(ll_Remanejamento) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um remanejamento.")
	Return 1
End If

If (ls_Via_Arquivo <> "S") or (IsNUll(ls_Via_Arquivo)) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Esse remanejamento n$$HEX1$$e300$$ENDHEX$$o via  Planilha de Excesso.")
	Return 1
End If

If Not wf_Planilha_Importada(ll_Remanejamento)	Then
	Return 1
End If

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o",	"Os dados devem estar da seguinte forma:" + &
								"~rColuna A = C$$HEX1$$f300$$ENDHEX$$digo da filial" + &
								"~rColuna B = C$$HEX1$$f300$$ENDHEX$$digo do produto" + &
								"~rColuna C = Quantidade")
                                                               
ll_Retorno = GetFileOpenName("Selecione o arquivo", + ls_Arquivo, ls_Nome, "XLSX", "Excel 2007 (*.XLSX),*.XLSX, Excel (*.XLS), *.XLS")

If ll_Retorno = 1 Then
	Try
		Try
			lds_Produtos = Create dc_uo_ds_base
		
			lds_Produtos.of_ChangeDataObject( 'ds_ge204_produtos_planilha' )
		
			lo_Excel = Create dc_uo_excel
			 
			Open(w_Aguarde)
			w_Aguarde.Title = "Importando dados..."
			 
			SetRedraw(False)
			 
			// Refer$$HEX1$$ea00$$ENDHEX$$ncia o arquivo 
			If ( lo_Excel.uo_Referencia_Objeto_Excel(ls_Arquivo) ) Then
								  
				ll_Linhas = lo_Excel.uo_Verifica_Tamanho_Arquivo("A")
				
				If	ll_Linhas	<	1	Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ nenhuma linha na planilha.", Exclamation!)
					Return 1
				End If
				
				
				
				If ll_Linhas > 0 Then
					w_Aguarde.uo_Progress.of_SetMax(ll_Linhas)
					
					lvl_Parte = ll_Linhas / 5
					
					For ll_Linha = 1 To ll_Linhas
						
						If lvl_Parte = 0 then
							w_Aguarde.Title = "Importando dados... " +String(ll_Linha) + " de "+ string(ll_Linhas)
							w_Aguarde.uo_Progress.of_SetProgress(ll_Linha)
						else
							If Mod (ll_Linha - 1, lvl_Parte) = 0 or ll_Linha = ll_Linhas then
								w_Aguarde.Title = "Importando dados... " +String(ll_Linha) + " de "+ string(ll_Linhas)
								w_Aguarde.uo_Progress.of_SetProgress(ll_Linha)
								Yield ( )
							End if
						End if
						
						Yield ( )
						
						// C$$HEX1$$f300$$ENDHEX$$digo da filial
						la_Dado = lo_Excel.uo_Lendo_Dados(ll_Linha, "A")
						
						//C$$HEX1$$f300$$ENDHEX$$digo do produto
						la_Dado_b = lo_Excel.uo_Lendo_Dados(ll_Linha, "B")
						
						//Quantidade pedida
						la_Dado_c = lo_Excel.uo_Lendo_Dados(ll_Linha, "C")
						
						If Not IsNumber(String(la_Dado)) Or IsNull(String(la_Dado)) Then
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "C$$HEX1$$f300$$ENDHEX$$digo da filial '"+String(la_Dado)+"' na linha '" + String(ll_Linha) + "' $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido. ~rN$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ inclu$$HEX1$$ed00$$ENDHEX$$do no remanejamento.", Exclamation!)
							Continue
						End If
						
						ll_Filial = Long(la_Dado)
						
						//Localiza Filial 						
						ll_Find = lds_Produtos.Find("cd_filial = " + String(ll_Filial) , 1,ll_Row)
						
						If ll_Find < 0 Then
							MessageBox("Erro", "Erro ao verificar se a Filial j$$HEX1$$e100$$ENDHEX$$ consta na planilha.", StopSign!)
							Return 1
						End If
						
						If ll_Find  = 0 Then
							If Not wf_Localiza_Filial(ll_Filial, Ref ls_Recebe) Then Return 1
							
							// Valida Configura$$HEX2$$e700e300$$ENDHEX$$o: Ignora e Continua o processo
							If ls_Recebe = 'N' Then 
								lb_achou = false
								For ll_Find = 1 to UpperBound(ll_filial_erro[])
									If ll_filial_erro[ll_Find] = ll_Filial then
										lb_achou = true
										exit
									End if
								Next
								If not lb_achou Then
									ll_Find = UpperBound (ll_filial_erro []) + 1
									ll_filial_erro [ll_Find] = ll_Filial				
									MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "C$$HEX1$$f300$$ENDHEX$$digo da filial '"+String(la_Dado)+"' na linha '" + String(ll_Linha) + "' n$$HEX1$$e300$$ENDHEX$$o recebe remanejamento!. N$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ incluido no remanejamento!.", StopSign!)							
								End If
								Continue
							End If 
						End If
						
						If Not IsNumber(String(la_Dado_b)) Or IsNull(String(la_Dado_b)) Then
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "C$$HEX1$$f300$$ENDHEX$$digo do produto '"+String(la_Dado)+"' na linha '" + String(ll_Linha) + "'  $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido.~rN$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ inclu$$HEX1$$ed00$$ENDHEX$$do no remanejamento.", Exclamation!)
							Continue
						End If
						
						ll_Produto = Long(la_Dado_b)
						
						//Localiza produto e filial
						ll_Find = lds_Produtos.Find("cd_produto = " + String(ll_Produto) + " and cd_filial = " + String(ll_Filial), 1, ll_Row)
						
						If ll_Find < 0 Then
							MessageBox("Erro", "Erro ao verificar se a filial e o produto est$$HEX1$$e300$$ENDHEX$$o mais de uma vez na planilha.", StopSign!)
							Return 1
						End If
						
						If ll_Find > 0 Then
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto '" + String(ll_Produto) + "' foi informado mais de uma vez na planilha para a filial '" + String(ll_Filial) + "'." + &
																										 "~rSomente o primeiro registro ser$$HEX1$$e100$$ENDHEX$$ considerado.", Exclamation!)
							Continue
						End If
						
						//Localiza produto						
						ll_Find = lds_Produtos.Find("cd_produto = " + String(ll_Produto) , 1,ll_Row)
						
						If ll_Find < 0 Then
							MessageBox("Erro", "Erro ao verificar se o  produto j$$HEX1$$e100$$ENDHEX$$ consta na planilha.", StopSign!)
							Return 1
						End If
						
						If ll_Find  = 0 Then
							If Not wf_Localiza_Produto(ll_Produto) Then Return 1
						End If
						
						//Quantidade
						If Not IsNumber(String(la_Dado_c)) Then
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Quantidade pedida do produto $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lida na linha '" + String(ll_Linha) + "'. ~rA planilha n$$HEX1$$e300$$ENDHEX$$o foi importada.")
							Return 1
						End If
											 
						ll_Qtde = Long(la_Dado_c)
	
						ll_Row  = lds_Produtos.InsertRow(0)
						
						lds_Produtos.Object.Cd_Filial			[ll_Row] = ll_Filial
						lds_Produtos.Object.cd_produto		[ll_Row] = ll_Produto
						lds_Produtos.Object.qt_remanejar	[ll_Row] = ll_Qtde	
						
					Next 	
					
					Destroy(lo_Excel)
							
					//Insere os registros no banco de dados
					lds_Produtos.Sort( )
					
					w_Aguarde.Title = "Gravando no banco de dados..."
					w_Aguarde.uo_Progress.of_SetMax(ll_Row)
					lvl_Parte = ll_Row / 8

					For ll_Linha = 1 To ll_Row
						
						If lvl_Parte = 0 then
							w_Aguarde.Title = "Gravando no banco de dados... " +String(ll_Linha) + " de "+ string(ll_Row)
							w_Aguarde.uo_Progress.of_SetProgress(ll_Linha)
						else
							If Mod (ll_Linha - 1, lvl_Parte) = 0 or ll_Linha = ll_Row then
								w_Aguarde.Title = "Gravando no banco de dados... " +String(ll_Linha) + " de "+ string(ll_Row)
								w_Aguarde.uo_Progress.of_SetProgress(ll_Linha)
							End if
						End if
						
						ll_Filial		= lds_Produtos.Object.Cd_Filial			[ll_Linha]
						ll_Produto	= lds_Produtos.Object.cd_produto		[ll_Linha]
						ll_Qtde		= lds_Produtos.Object.qt_remanejar		[ll_Linha]
						
						Insert Into remanejamento_filial_produto(
									cd_remanejamento,
									cd_filial,
									cd_produto,
									qt_remanejar)
						Values(	:ll_Remanejamento,
									:ll_Filial,
									:ll_Produto,
									:ll_Qtde)
						Using SqlCa;
						
						If SqlCa.SqlCode = -1 Then
							ls_Erro = SqlCa.SqlErrText
							SqlCa.of_Rollback()
							MessageBox("Erro", "Erro ao gravar os dados da palnilha: "+ls_Erro+".~rA planilha n$$HEX1$$e300$$ENDHEX$$o foi importada.")
							Return 1
						End If					
					Next
					
					SqlCa.of_Commit()
					w_Aguarde.Title = "Finalizando a grava$$HEX2$$e700e300$$ENDHEX$$o no banco de dados..."
					Sleep(60)
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Planilha importada com sucesso.")
					
				End If
			End If
		Catch ( runtimeerror  lo_rte )
			MessageBox (   "Erro",	"Erro ao importar as informa$$HEX2$$e700f500$$ENDHEX$$es do arquivo. ~r~r"+ &                                                                                               
											"Erro: "+lo_rte.GetMessage( ), StopSign!)
		End Try
	Finally
		Close(w_Aguarde)
		If IsValid(lo_Excel) Then Destroy(lo_Excel)
		SetRedraw(True)
		Destroy(lds_Produtos)
	End Try
End If
end event

type cb_4 from commandbutton within w_ge204_manutencao_remanejamento
boolean visible = false
integer x = 1783
integer y = 1252
integer width = 402
integer height = 112
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "none"
end type

event clicked;// OverRide
Long ll_Codigo

String ls_Teste

dw_1.AcceptText( )

ls_Teste = ""

uo_ge115_remanejamento uo
uo = Create uo_ge115_remanejamento

uo.ib_selecionar_varios_remanej = True

uo.of_Localiza(ls_Teste)

If uo.ib_Localizado Then
	messagebox("Teste", uo.is_cd_remanejamentos_selecionados)
End If

Destroy uo
end event

type gb_2 from groupbox within w_ge204_manutencao_remanejamento
integer x = 1938
integer y = 12
integer width = 1998
integer height = 1716
integer taborder = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Filiais"
borderstyle borderstyle = styleraised!
end type

type cb_imp_prod_prestes from commandbutton within w_ge204_manutencao_remanejamento
integer x = 928
integer y = 1604
integer width = 923
integer height = 104
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Importar Produtos Prestes"
end type

event clicked;///// Declara$$HEX2$$e700f500$$ENDHEX$$es /////
Date				ldt_Data_Ini, &
					ldt_Data_Fim

Long				ll_Retorno,&
					ll_Linhas,&
					ll_Linha,&
					ll_Filial,&
					ll_Produto,&
					ll_Find,&
					ll_Qtde,&
					ll_Remanejamento,&
					ll_Row

String			ls_Arquivo,&
					ls_Nome,&
					ls_Nome_Fantasia,&
					ls_UF,&
					ls_Erro,&
					ls_Prod_Prestes,&
					ls_Recebe
		
dc_uo_ds_base	lds_Produtos

///// Procedimento /////

dw_1.AcceptText ()

ll_Remanejamento = dw_1.Object.cd_remanejamento             [1]
ls_Prod_Prestes  = dw_1.Object.id_remanejamento_via_prestes [1]

If IsNull (ll_Remanejamento) then
	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Selecione um remanejamento.')
	Return 1
End if

If ls_Prod_Prestes <> 'S' or IsNUll (ls_Prod_Prestes) then
	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Esse remanejamento n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ de produtos prestes.')
	Return 1
End if

If Not IsNull (dw_1.Object.dh_calculo [1]) then
	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'O remanejamento selecionado j$$HEX1$$e100$$ENDHEX$$ foi processado.', StopSign!)
	Return 1
End if

If Not wf_prestes_importados (ll_Remanejamento, Ref ll_Qtde)	then
	Return 1
End If

If ll_Qtde > 0 then
	If MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', &
						'A lista de produtos prestes para esse remanejamento j$$HEX1$$e100$$ENDHEX$$ foi importada.~r~rDeseja excluir os dados atuais e fazer uma nova carga?', &
						Question!, YesNo!, 2) = 1 then
		DELETE
		  FROM remanejamento_filial_produto
		 WHERE cd_remanejamento = :ll_Remanejamento
		 USING SQLCA;

		If SQLCA.SQLCode = -1 then
			SQLCA.of_MsgDbError ('Erro ao excluir os produtos prestes j$$HEX1$$e100$$ENDHEX$$ importados.')
			Return 1
		End if
		
		SQLCA.of_Commit ();
	else
		Return 1
	End if
End if

lds_Produtos = Create dc_uo_ds_base

If Not lds_Produtos.of_ChangeDataObject ('ds_ge204_produtos_prestes') then
	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', "'Erro no ChangeDataObject da 'ds_ge204_produtos_prestes'")
	Return 1
End if

Open (w_Aguarde)
w_Aguarde.Title = 'Importando dados...'
 
SetRedraw (False)

Try

	ldt_Data_Fim = RelativeDate (Date (gf_GetServerDate ()), dw_1.Object.qt_dias_remanejamento [1])
	ldt_Data_Ini = RelativeDate (ldt_Data_Fim, -30)
	ll_linhas      = lds_Produtos.Retrieve (ldt_Data_Ini, ldt_Data_Fim, ll_Remanejamento, idt_ini_prestes)
	
	Choose case ll_Linhas
		case is > 0
			w_Aguarde.uo_Progress.of_SetMax (ll_Linhas)
			
			For ll_Linha = 1 To ll_Linhas
				
				w_Aguarde.uo_Progress.of_SetProgress (ll_Linha)
				
				ll_Filial  = lds_Produtos.Object.filial_origem [ll_Linha]
				ll_Produto = lds_Produtos.Object.produto       [ll_Linha]
				ll_Qtde    = lds_Produtos.Object.qtd_etiquetas [ll_Linha]
				
				INSERT
				  INTO remanejamento_filial_produto (
							cd_remanejamento,
							cd_filial,
							cd_produto,
							qt_remanejar)
				VALUES (	:ll_Remanejamento,
							:ll_Filial,
							:ll_Produto,
							:ll_Qtde)
				 USING SQLCA;
				
				If SQLCA.SQLCode = -1 then
					ls_Erro = SqlCa.SqlErrText
					SQLCA.of_Rollback ()
					MessageBox ('Erro', 'Erro ao gravar os dados de produtos prestes: '+ ls_Erro + '.~rOs produtos n$$HEX1$$e300$$ENDHEX$$o foram importados.')
					Return 1
				End if
			Next
			
			SQLCA.of_Commit ()
			dw_1.Object.nr_dias_valid_remanejto_preste.Protect = 1
			MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Foram selecionadas ' + String (ll_Linhas) + ' linhas para o Remanejamento de Prestes')
			
		case 0
			MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'N$$HEX1$$e300$$ENDHEX$$o foram encontrados produtos para o Remanejamento de Prestes')
			
		case is < 0
			MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro na pesquisa de produtos para o Remanejamento de Prestes')
	End choose
	
Catch (runtimeerror lo_rte)
	MessageBox ('Erro', &
					'Erro ao importar as informa$$HEX2$$e700f500$$ENDHEX$$es de produtos prestes:~r~r' + lo_rte.GetMessage (), &
					StopSign!)
Finally
	Destroy (lds_Produtos)
	SetRedraw (True)
	Close (w_Aguarde)
End Try
end event

