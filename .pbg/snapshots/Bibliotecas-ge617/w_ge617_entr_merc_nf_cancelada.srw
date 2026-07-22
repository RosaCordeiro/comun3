HA$PBExportHeader$w_ge617_entr_merc_nf_cancelada.srw
$PBExportComments$Reentrada de produtos de NFs canceladas.
forward
global type w_ge617_entr_merc_nf_cancelada from dc_w_2tab_consulta_selecao_lista_2det
end type
type cb_entrar from commandbutton within tabpage_1
end type
end forward

global type w_ge617_entr_merc_nf_cancelada from dc_w_2tab_consulta_selecao_lista_2det
integer x = 215
integer y = 220
integer width = 4901
integer height = 1844
string title = "GE617 - Entrada de Mercadoria de NFs Canceladas"
end type
global w_ge617_entr_merc_nf_cancelada w_ge617_entr_merc_nf_cancelada

type variables
Boolean						ib_Check

dc_uo_ds_base				ids_Produtos

Long							il_Filial_CD = 534
Long							il_Filial_Origem

String						is_Endereco_Avaria
String						is_Endereco_Falta
String						is_Endereco_Destino
String						is_Endereco_Rec_Lib
String						is_Tipo_Nota
String						is_DS_det
String						is_DS_itens
String						is_DS
String						is_tab_item
String						is_Desc_Tipo_Nota

uo_filial					ivo_filial
uo_fornecedor				ivo_fornecedor
uo_produto					ivo_produto
end variables

forward prototypes
public function boolean wf_obtem_enderecos ()
public function boolean wf_abate_quantidade_cancelada (long al_filial_origem, long al_nf_origem, string as_especie_origem, string as_serie_origem, string as_fornecedor, long al_qtd_cancelada, long al_cd_produto, string as_nr_lote, date adt_validade, ref string as_erro)
public function boolean wf_nr_movimentacao (string as_endereco_origem, long al_produto, string as_lote, long al_cx_padrao, datetime adt_validade, string as_matricula, string as_tipo_movimento, ref long al_nr_movimentacao, ref string as_erro)
public function boolean wf_obtem_endereco_segregado (string as_parametro, ref string as_endereco)
public function boolean wf_processa_entrada_mercadoria (long al_filial, long al_nf, string as_especie, string as_serie, string as_operador, long al_nf_origem, string as_especie_origem, string as_serie_origem, string as_fornecedor, string as_endereco_dest)
public function boolean wf_movimenta_mercadoria (long al_cd_produto, long al_qtd_caixa, string as_nr_lote, date adt_validade, long al_qtd_movimento, long al_filial, long al_nf, string as_especie, string as_serie, string as_operador, string as_fornecedor, string as_endereco_destino, ref string as_erro)
public function boolean wf_insere_segregado_recebimento (string as_endereco, long al_nf_origem, string as_especie_origem, string as_serie_origem, long al_cd_produto, string as_nr_lote, date adt_validade, long al_qtd_movimento, string as_fornecedor, ref string as_erro)
public function boolean wf_grava_ajuste_estoque_wms (long al_produto, string as_endereco_entrada, string as_lote, date adt_validade, long al_qtde_movimento, long al_caixa_padrao, long al_filial, long al_nr_nf, string as_especie, string as_serie, string as_operador, ref string as_erro)
end prototypes

public function boolean wf_obtem_enderecos ();String	ls_param_end_dest

Choose case is_Tipo_Nota
	case 'D'
		ls_param_end_dest = 'CD_ENDERECO_SEGREG_NF_DEV_COMPRA_CANC'
	case 'T'
		ls_param_end_dest = 'CD_ENDERECO_SEGREG_NF_TRANSF_CANC'
//	case 'I'
//		ls_param_end_dest   = '..'
End choose

If not wf_obtem_endereco_segregado (ls_param_end_dest,                          	Ref is_Endereco_Destino) then Return False
If not wf_obtem_endereco_segregado ('CD_ENDERECO_SEGREGADO_RECEBIMENTO_AVARIA', 	Ref is_Endereco_Avaria)  then Return False
If not wf_obtem_endereco_segregado ('CD_ENDERECO_SEGREGADO_RECEBIMENTO_FALTA',  	Ref is_Endereco_Falta)   then Return False
If not wf_obtem_endereco_segregado ('CD_ENDERECO_RECEBIMENTO_LIBERADO',  			Ref is_Endereco_Rec_Lib)   then Return False

Return True
end function

public function boolean wf_abate_quantidade_cancelada (long al_filial_origem, long al_nf_origem, string as_especie_origem, string as_serie_origem, string as_fornecedor, long al_qtd_cancelada, long al_cd_produto, string as_nr_lote, date adt_validade, ref string as_erro);Long	ll_qt_devolvida

//// [NF DEV.COMPRA] Abate a quantidade cancelada da quantidade devolvida
SELECT qt_devolvida
  INTO :ll_qt_devolvida
  FROM item_nf_compra_lote
 WHERE cd_produto		= :al_cd_produto
	AND nr_lote			= :as_Nr_Lote
	AND dh_validade	= :adt_validade
	AND cd_filial		= :al_filial_origem
	AND cd_fornecedor	= :as_fornecedor
	AND nr_nf			= :al_nf_origem
	AND de_especie		= :as_especie_origem
	AND de_serie		= :as_serie_origem
 USING SQLCA;

Choose case SQLCA.SQLCode
	case is < 0
		as_Erro = 'Erro na leitura da tabela item_nf_compra_lote: ' + SQLCA.SQLErrText
		Return False
	case 100
		as_Erro = 'Produto ' + String (al_cd_produto) + ' n$$HEX1$$e300$$ENDHEX$$o encontrado para atualiza$$HEX2$$e700e300$$ENDHEX$$o da quantidade devolvida na tabela item_nf_compra_lote'
		Return False
End choose

Choose case True
	case IsNull (ll_qt_devolvida)
		ll_qt_devolvida = 0
	case ll_qt_devolvida >= al_qtd_cancelada
		ll_qt_devolvida = ll_qt_devolvida - al_qtd_cancelada
	case ll_qt_devolvida = 0
		Return True
	case else
		ll_qt_devolvida = 0
End choose

UPDATE item_nf_compra_lote
	SET qt_devolvida  = :ll_qt_devolvida
 WHERE cd_produto		= :al_cd_produto
	AND nr_lote			= :as_Nr_Lote
	AND dh_validade	= :adt_validade
	AND cd_filial		= :al_filial_origem
	AND cd_fornecedor	= :as_fornecedor
	AND nr_nf			= :al_nf_origem
	AND de_especie		= :as_especie_origem
	AND de_serie		= :as_serie_origem
 USING SQLCA;

If SQLCA.SQLCode = -1 then
	as_Erro = 'Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o da quantidade devolvida na tabela item_nf_compra_lote: ' + SQLCA.SQLErrText
	Return False
End if

as_Erro = ''

Return True
end function

public function boolean wf_nr_movimentacao (string as_endereco_origem, long al_produto, string as_lote, long al_cx_padrao, datetime adt_validade, string as_matricula, string as_tipo_movimento, ref long al_nr_movimentacao, ref string as_erro);//Pega o n$$HEX1$$fa00$$ENDHEX$$mero da movimenta$$HEX2$$e700e300$$ENDHEX$$o
SELECT nr_movimentacao
  INTO :al_Nr_Movimentacao
  FROM wms_movimentacao
 WHERE cd_produto               = :al_produto
	AND nr_matricula_responsavel = :as_matricula
	AND cd_endereco_saida        = :as_endereco_Origem
	AND nr_lote                  = :as_lote
	AND qt_caixa_padrao          = :al_cx_padrao
	AND dh_validade              = :adt_Validade
	AND id_tipo_movimento        = :as_Tipo_Movimento
 USING SQLCA;

Choose Case SQLCA.SQLCode
	Case -1
		as_erro = 'Erro ao obter o n$$HEX1$$fa00$$ENDHEX$$mero da movimenta$$HEX2$$e700e300$$ENDHEX$$o do produto ' + String (al_produto) + ': ' + SQLCA.SQLErrText
		Return False
		
	Case 100
		as_erro = 'O n$$HEX1$$fa00$$ENDHEX$$mero da movimenta$$HEX2$$e700e300$$ENDHEX$$o do produto ' + String (al_produto) + ' n$$HEX1$$e300$$ENDHEX$$o foi encontrado'
		Return False
End Choose

Return True
end function

public function boolean wf_obtem_endereco_segregado (string as_parametro, ref string as_endereco);String	ls_Achou
String	ls_erro


SELECT vl_parametro
  INTO :as_endereco
  FROM wms_parametro
 WHERE cd_parametro = :as_parametro
 USING SQLCA;

Choose Case SQLCA.SQLCode
	Case 0
		
		SELECT cd_endereco
		  INTO :ls_Achou
		  FROM wms_endereco
		 WHERE cd_endereco =: as_endereco
		 USING SQLCA;
		
		Choose Case SQLCA.SQLCode
			Case 0
				Return True
			Case 100
				ls_erro = "Endere$$HEX1$$e700$$ENDHEX$$o '" + as_endereco + "' n$$HEX1$$e300$$ENDHEX$$o localizado"
			Case -1
				ls_erro = "Erro ao localizar o endere$$HEX1$$e700$$ENDHEX$$o '" + as_endereco + "' do segregado na tabela [WMS_ENDERECO]:~n~n~r" + SQLCA.SQLErrText
		End choose
		
	Case 100
		ls_erro = "Par$$HEX1$$e200$$ENDHEX$$metro '" + as_parametro + "' com o endere$$HEX1$$e700$$ENDHEX$$o do segregado n$$HEX1$$e300$$ENDHEX$$o foi localizado."
		
	Case -1
		ls_erro = "Erro ao localizar o par$$HEX1$$e200$$ENDHEX$$metro '" + as_parametro + "' do endere$$HEX1$$e700$$ENDHEX$$o do segregado:~n~n~r" + SQLCA.SQLErrText
		
End Choose

MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_erro, Exclamation!)

Return False
end function

public function boolean wf_processa_entrada_mercadoria (long al_filial, long al_nf, string as_especie, string as_serie, string as_operador, long al_nf_origem, string as_especie_origem, string as_serie_origem, string as_fornecedor, string as_endereco_dest);//Declara$$HEX2$$e700f500$$ENDHEX$$es

Boolean	lb_Sucesso
Date		ldt_validade
Date		ldt_valid_movto
Long		ll_cd_produto
Long		ll_qt_movimento
Long		lqt_caixa
Long		ll_Linha
Long		ll_Linhas
String	ls_Nr_Lote
String	ls_Erro
String 	ls_cd_bairro

//Procedimentos

Try
	ll_linhas = ids_Produtos.Retrieve (al_filial, &
												  al_nf, &
												  as_especie, &
												  as_serie)
	
	w_Aguarde.uo_Progress.of_SetMax (ll_Linhas)
	
	For ll_Linha = 1 To ll_Linhas
		
		ll_cd_produto   = ids_Produtos.Object.cd_produto   [ll_Linha]
		ll_qt_movimento = ids_Produtos.Object.qt_movimento [ll_Linha]
		ls_Nr_Lote      = ids_Produtos.Object.nr_lote      [ll_Linha]
		ldt_validade    = ids_Produtos.Object.dh_validade  [ll_Linha]
		lqt_caixa       = 1
	
		w_Aguarde.Title = 'Aguarde... Movimentando o produto '+ String (ll_cd_produto) + ' para o endere$$HEX1$$e700$$ENDHEX$$o ' + is_endereco_destino + '...'
		w_Aguarde.uo_Progress.of_SetProgress (ll_Linha)
		
		If ll_qt_movimento > 0 then
			
			If IsNull (ls_Nr_Lote) or ls_Nr_Lote = '' then
				ls_Nr_Lote = 'SEM LOTE'
			End if
			
			If IsNull (ldt_validade) then
				ldt_valid_movto = Date ('2099/12/31')
			else
				ldt_valid_movto = Date (String (ldt_validade, '01/mm/yyyy'))
			End if
			
			//// Regista a movimenta$$HEX2$$e700e300$$ENDHEX$$o da mercadoria
			If not wf_movimenta_mercadoria (ll_cd_Produto,    &
													  lqt_caixa,        &
													  ls_Nr_Lote,       &
													  ldt_valid_movto,  &
													  ll_qt_movimento,  &
													  al_filial,        &
													  al_nf,            &
													  as_especie,       &
													  as_serie,         &
													  as_operador,      &
													  as_fornecedor,    &
													  as_endereco_dest, &
													  Ref ls_Erro) then
				lb_Sucesso = False
				Return False
			End if
			
			select we.cd_bairro
			  into :ls_cd_bairro
			  from wms_endereco we
			 where we.cd_endereco = :as_endereco_dest;
			 
			Choose Case SQLCA.SQLCode
				Case -1
					ls_Erro	= 'Problema ao consultar o bairro do endere$$HEX1$$e700$$ENDHEX$$o movimentado. ~r~rErro: ' + SQLCA.SQLErrText
					lb_Sucesso = False
					Return False
				Case 100
					ls_Erro	= 'N$$HEX1$$e300$$ENDHEX$$o foi encontrado registro na tabela wms_endereco para o endere$$HEX1$$e700$$ENDHEX$$o: ' + as_endereco_dest
					lb_Sucesso = False
					Return False
				Case 0
					if ls_cd_bairro = 'A' then
						// Insere no SEGREGADO RECEBIMENTO
						If not wf_insere_segregado_recebimento (as_endereco_dest,  &
																			 al_nf_origem,      &
																			 as_especie_origem, &
																			 as_serie_origem,   &
																			 ll_cd_Produto,     &
																			 ls_Nr_Lote,        &
																			 ldt_valid_movto,   &
																			 ll_qt_movimento,   &
																			 as_fornecedor,     &
																			 Ref ls_Erro) then
							lb_Sucesso = False
							Return False
						End If
					end if
			End Choose
			
			If is_Tipo_Nota = 'D' then
				//// Abate a quantidade cancelada da quantidade devolvida na NF original
				If not wf_abate_quantidade_cancelada (il_Filial_CD,      &
																  al_nf_origem,      &
																  as_especie_origem, &
																  as_serie_origem,   &
																  as_fornecedor,     &
																  ll_qt_movimento,   &
																  ll_cd_produto,     &
																  ls_Nr_Lote,        &
																  ldt_valid_movto,   &
																  Ref ls_Erro) then
					lb_Sucesso = False
					Return False
				End if
				
				If not wf_grava_ajuste_estoque_wms (ll_cd_produto,    &
																as_endereco_dest, &
																ls_Nr_Lote,       &
																ldt_valid_movto,  &
																ll_qt_movimento,  &
																lqt_caixa,        &
																al_filial,        &
																al_nf,            &
																as_especie,       &
																as_serie,         &
																as_operador,      &
																Ref ls_erro) then
					lb_Sucesso = False
					Return False
				End if
			End if
			
		End if
		
	Next
	
	lb_Sucesso = True
	
Finally
	If not lb_Sucesso then
		SQLCA.of_Rollback ()
		If ls_Erro <> '' then
			MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_Erro, Exclamation!)
		End if
	End if
End try

Return True
end function

public function boolean wf_movimenta_mercadoria (long al_cd_produto, long al_qtd_caixa, string as_nr_lote, date adt_validade, long al_qtd_movimento, long al_filial, long al_nf, string as_especie, string as_serie, string as_operador, string as_fornecedor, string as_endereco_destino, ref string as_erro);//Declara$$HEX2$$e700f500$$ENDHEX$$es
Long							ll_Nr_Movimentacao
Long							ll_Nulo
String						ls_Nulo

uo_ge258_movimentacao	lds_Movimentacao


SetNull (ll_Nulo)
SetNUll (ls_Nulo)

lds_Movimentacao = Create uo_ge258_movimentacao

lds_Movimentacao.ivb_Commit             = False
lds_Movimentacao.ivb_endereco_bloqueado = False
lds_Movimentacao.ivb_valida_inventario  = False

Try
	////	Registra entrada e sa$$HEX1$$ed00$$ENDHEX$$da no RECEBIMENTO LIBERADO
	If Not lds_Movimentacao.of_insere_movimentacao (is_Endereco_Rec_Lib, &
																	ls_Nulo,             &
																	al_cd_Produto,       &
																	al_qtd_caixa,        &
																	as_Nr_Lote,          &
																	adt_validade,        &
																	al_qtd_movimento,    &
																	'E',                 &
																	al_filial,           &
																	as_fornecedor,       &
																	al_nf,               &
																	as_especie,          &
																	as_serie,            &
																	as_operador,         &
																	ll_Nulo) then
		Return False
	End if
	
	If Not lds_Movimentacao.of_insere_movimentacao (ls_Nulo,             &
																	is_Endereco_Rec_Lib, &
																	al_cd_Produto,       &
																	al_qtd_caixa,        &
																	as_Nr_Lote,          &
																	adt_validade,        &
																	al_qtd_movimento,    &
																	'S',                 &
																	al_filial,           &
																	ls_Nulo,             &
																	al_nf,               &
																	as_especie,          &
																	as_serie,            &
																	as_operador,         &
																	ll_Nulo) then
		Return False
	End if
	
	If Not wf_Nr_Movimentacao (is_Endereco_Rec_Lib,     &
										al_cd_Produto,           &
										as_Nr_Lote,              &
										al_qtd_caixa,            &
										DateTime (adt_validade), &
										as_operador,             &
										'S',                     &
										Ref ll_Nr_Movimentacao,  &
										Ref as_erro) then
		Return False
	End if
	
	////	Faz movimento de Entrada no endere$$HEX1$$e700$$ENDHEX$$o SEGREGADO
	If Not lds_Movimentacao.of_Atualiza_Movimentacao  (is_Endereco_Destino,     &
																		al_cd_Produto,           &
																		ll_Nr_Movimentacao,      &
																		al_qtd_movimento,        &
																		as_Nr_Lote,              &
																		1,                       &
																		DateTime (adt_validade), &
																		as_operador) then
		Return False
	End If
	
Finally
	Destroy lds_Movimentacao
End try

Return True
end function

public function boolean wf_insere_segregado_recebimento (string as_endereco, long al_nf_origem, string as_especie_origem, string as_serie_origem, long al_cd_produto, string as_nr_lote, date adt_validade, long al_qtd_movimento, string as_fornecedor, ref string as_erro);//// Insere no SEGREGADO RECEBIMENTO

INSERT INTO wms_segregado_recebimento
			 ( cd_endereco
			 , cd_fornecedor
			 , nr_nf
			 , de_especie
			 , de_serie
			 , cd_produto
			 , nr_lote
			 , dh_validade
			 , qt_lote)
VALUES   ( :as_endereco
			, :as_fornecedor
			, :al_nf_origem
			, :as_especie_origem
			, :as_serie_origem
			, :al_cd_Produto
			, :as_Nr_Lote
			, :adt_validade
			, :al_qtd_movimento)
 USING SQLCA;

If SQLCA.SQLCode = -1 then
	as_Erro = 'Erro na inclus$$HEX1$$e300$$ENDHEX$$o do lote na tabela wms_segregado_recebimento: ' + SQLCA.SQLErrText
	Return False
End If

as_Erro = ''

Return True
end function

public function boolean wf_grava_ajuste_estoque_wms (long al_produto, string as_endereco_entrada, string as_lote, date adt_validade, long al_qtde_movimento, long al_caixa_padrao, long al_filial, long al_nr_nf, string as_especie, string as_serie, string as_operador, ref string as_erro);Date		ldh_Movimento
Long		ll_nr_ajuste_estoque
String	ls_Comentario

ldh_Movimento = Date (gf_GetServerDate ())

SELECT COALESCE (MAX (nr_ajuste), 0) + 1 
  INTO :ll_nr_ajuste_estoque
  FROM wms_ajuste_estoque
 USING SQLCA;

If SQLCA.SQLCode = -1 Then
	as_Erro = "Erro ao inserir dados na tabela 'wms_ajuste_estoque': " + SQLCA.SQLErrText
	Return False
End if

Choose case is_Tipo_nota
	case 'D'
		ls_Comentario = 'NOTA DE DEVOLU$$HEX2$$c700c300$$ENDHEX$$O DE COMPRA CANCELADA: '
	case 'T'
		ls_Comentario = 'NOTA DE TRANSFER$$HEX1$$ca00$$ENDHEX$$NCIA CANCELADA: '
End choose

ls_Comentario += String (al_filial) + '/' + String (al_nr_nf) + '/' + as_serie + '/' + as_especie

INSERT INTO wms_ajuste_estoque
			(	nr_ajuste,   
				cd_produto,   
				cd_endereco,   
				nr_lote,   
				dh_validade,   
				qt_caixa_padrao,   
				qt_ajuste,   
				id_entrada_saida,   
				dh_ajuste,   
				dh_movimentacao_caixa,   
				de_comentario_ajuste,   
				nr_matricula_responsavel,
				cd_motivo_ajuste
			)
	VALUES
			(	:ll_nr_ajuste_estoque, 	//nr_ajuste,   
				:al_produto,				//cd_produto,   
				:as_endereco_entrada,	//cd_endereco,   
				:as_lote,					//nr_lote,   
				:adt_validade,				//dh_validade,   
				:al_caixa_padrao,			//qt_caixa_padrao
				:al_qtde_movimento, 		//qt_ajuste,   
				'E', 							//id_entrada_saida,   
				GetDate (),					//dh_ajuste,   
				:ldh_Movimento,			//dh_movimentacao_caixa,   
				:ls_Comentario, 			//de_comentario_ajuste,   
				:as_operador,				//nr_matricula_responsavel
				61 							//cd_motivo_ajuste - ESTORNO/CANC. NOTA (FISCAL)
			)
 USING SQLCA;

If SQLCA.SQLCode = -1 Then
	as_Erro = "Erro ao inserir na tabela 'wms_ajuste_estoque':~n~n~r" + SQLCA.SQLErrText
	Return False
End if

Return True
end function

on w_ge617_entr_merc_nf_cancelada.create
int iCurrent
call super::create
end on

on w_ge617_entr_merc_nf_cancelada.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;Destroy ivo_filial
Destroy ivo_Fornecedor
Destroy ivo_produto


end event

event open;call super::open;ivo_filial     = Create uo_filial
ivo_Fornecedor = Create uo_Fornecedor
ivo_produto    = Create uo_produto
end event

event ue_postopen;call super::ue_postopen;SELECT cd_filial
  INTO :il_Filial_Origem
  FROM parametro
 WHERE id_parametro = '1'
 USING SQLCA;

Choose case SQLCA.SQLCode
	case is < 0
		MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao buscar a filial de origem no par$$HEX1$$e200$$ENDHEX$$metro 1:~n~n~r' + SQLCA.SQLErrText, StopSign!)
		Close (This)
	case 100
		MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'O par$$HEX1$$e200$$ENDHEX$$metro 1 com a filial de origem n$$HEX1$$e300$$ENDHEX$$o foi encontrado', Exclamation!)
		Close (This)
End choose
end event

event ue_preopen;call super::ue_preopen;// Determina as dimens$$HEX1$$f500$$ENDHEX$$es dos folders
// Sele$$HEX2$$e700e300$$ENDHEX$$o
ivl_Largura_1 = 3561
ivl_Altura_1  = 1785

// Detalhes
ivl_Largura_2 = ivl_Largura_1
ivl_Altura_2  	= ivl_Altura_1

MaxHeight = 9999

SetNull (is_Endereco_Destino)
end event

event resize;call super::resize;Long lvl_Diferenca

lvl_Diferenca = (This.Height - 180) - Tab_1.Height
Tab_1.Height                += lvl_Diferenca
Tab_1.TabPage_1.gb_2.Height += lvl_Diferenca - 15
Tab_1.TabPage_1.dw_2.Height += lvl_Diferenca - 15
Tab_1.TabPage_2.gb_4.Height += lvl_Diferenca
Tab_1.TabPage_2.dw_4.Height += lvl_Diferenca
end event

type dw_visual from dc_w_2tab_consulta_selecao_lista_2det`dw_visual within w_ge617_entr_merc_nf_cancelada
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_2det`gb_aux_visual within w_ge617_entr_merc_nf_cancelada
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_2det`tab_1 within w_ge617_entr_merc_nf_cancelada
integer x = 9
integer width = 4846
integer height = 1652
long backcolor = 79741120
end type

event tab_1::selectionchanged;//override
end event

event tab_1::selectionchanging;// override

//String	ls_DS_det, ls_DS_itens

If newindex = 2 then
	
	If not This.tabpage_2.dw_3.of_ChangeDataObject (is_DS_det) then
		MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro no ChangeDataObject do detalhe da nota', StopSign!)
		Return - 1
	End if
	
	If not This.tabpage_2.dw_4.of_ChangeDataObject (is_DS_itens) then
		MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro no ChangeDataObject dos itens da nota', StopSign!)
		Return - 1
	End if
	
	This.tabpage_2.dw_4.of_SetRowSelection ()
End if

Super::Event SelectionChanging (oldindex, newindex)
end event

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_2det`tabpage_1 within tab_1
event create ( )
event destroy ( )
integer width = 4809
integer height = 1536
cb_entrar cb_entrar
end type

on tabpage_1.create
this.cb_entrar=create cb_entrar
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_entrar
end on

on tabpage_1.destroy
call super::destroy
destroy(this.cb_entrar)
end on

type gb_2 from dc_w_2tab_consulta_selecao_lista_2det`gb_2 within tabpage_1
integer x = 27
integer y = 504
integer width = 4763
integer height = 1032
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_2det`gb_1 within tabpage_1
integer x = 27
integer y = 0
integer width = 4763
integer height = 408
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_2det`dw_1 within tabpage_1
integer x = 46
integer y = 68
integer width = 4434
integer height = 320
string dataobject = "dw_ge617_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;dw_2.Reset ()

Choose Case dwo.Name
	Case "de_filial"
		If Trim(Data) <> "" and Not IsNull(Data) Then
			If Data <> ivo_Filial.Nm_Fantasia Then				
				Return 1
			End If
		Else
			ivo_Filial.of_Inicializa()
			
			This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
			This.Object.de_Filial[1] = ivo_Filial.Nm_Fantasia			
		End If	
		
	Case "de_produto"
		If Trim(Data) <> "" Then
			If Data <> ivo_Produto.de_produto+': '+ivo_produto.de_apresentacao_estoque Then				
				Return 1
			End If
		Else
			ivo_Produto.of_Inicializa()
			
			This.Object.cd_produto	[1] = ivo_Produto.cd_produto
			This.Object.de_produto	[1] = ivo_Produto.de_produto			
		End If
		
	Case "nm_fornecedor"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Fornecedor.Nm_Razao_Social Then
				Return 1
			End If
		Else
			ivo_Fornecedor.of_Inicializa()
			
			This.Object.Cd_Fornecedor[1] = ivo_Fornecedor.Cd_Fornecedor
			This.Object.Nm_Fornecedor[1] = ivo_Fornecedor.Nm_Razao_Social			
		End If
	
	case 'id_tipo_nota'
		is_Tipo_Nota = data
		
		Choose case is_Tipo_Nota
			case 'D'
				is_DS_det           = 'dw_ge617_detalhe_nf_dev_compra'
				is_DS_itens         = 'dw_ge617_detalhe_item_dev_compra'
				is_DS               = 'dw_ge617_lista_nf_dev_compra'
				is_tab_item         = ''
				is_Desc_Tipo_Nota   = 'Nota de Devolu$$HEX2$$e700e300$$ENDHEX$$o de Compra'
			case 'T'
				is_DS_det           = 'dw_ge617_detalhe_nf_transferencia'
				is_DS_itens         = 'dw_ge617_detalhe_item_transferencia'
				is_DS               = 'dw_ge617_lista_nf_transferencia'
				is_tab_item         = 'item_nf_transferencia'
				is_Desc_Tipo_Nota   = 'Nota de Transfer$$HEX1$$ea00$$ENDHEX$$ncia'
//		case 'I'
//				is_DS_det           = 'dw_ge617_detalhe_nf_diversa'
//				is_DS_itens         = 'dw_ge617_detalhe_item_diversa'
//				is_DS               = 'dw_ge617_lista_nf_diversa'
//				is_tab_item         = 'item_nf_diversa'
//				is_Desc_Tipo_Nota   = 'Nota Diversa'
		End choose
		
		SetNull (is_Endereco_Destino)
		
End Choose
end event

event dw_1::ue_key;call super::ue_key;dw_2.Reset ()

If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "de_filial"
			ivo_filial.Of_Localiza_Filial( This.GetText() )
	
			If ivo_filial.Localizada Then
		
				This.Object.cd_filial[1] = ivo_filial.cd_filial
				This.Object.de_filial[1] = ivo_filial.nm_fantasia	
			Else
				ivo_filial.Of_inicializa( )
				
				This.Object.cd_filial[1] = ivo_filial.cd_filial
				This.Object.de_filial[1] = ivo_filial.nm_fantasia	
			End If
			
		Case "de_produto"
			ivo_Produto.Of_Localiza_produto(This.GetText())
	
			If ivo_Produto.Localizado Then
		
				This.Object.cd_produto	[1] = ivo_Produto.cd_produto
				This.Object.de_produto 	[1] = ivo_Produto.de_produto+': '+ivo_Produto.de_apresentacao_estoque	
			Else
				ivo_Produto.Of_inicializa( )
				
				This.Object.cd_produto	[1] = ivo_Produto.cd_produto
				This.Object.de_produto 	[1] = ivo_Produto.de_produto
			End If
		
	Case "nm_fornecedor"
		ivo_Fornecedor.of_Localiza_Fornecedor(This.GetText())
		
		If ivo_Fornecedor.Localizado Then
			This.Object.Cd_Fornecedor[1] = ivo_Fornecedor.Cd_Fornecedor
			This.Object.Nm_Fornecedor[1] = ivo_Fornecedor.Nm_Razao_Social
		End If
		
	End Choose
End If
end event

event dw_1::ue_addrow;call super::ue_addrow;Date lvdt_Movimento

lvdt_Movimento = Date(gvo_Parametro.of_dh_movimentacao())

This.Object.dt_inicio [1] = lvdt_Movimento
This.Object.dt_termino[1] = lvdt_Movimento

Return AncestorReturnValue


end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Produto) Then
	If ivo_Produto.Localizado Then
		This.Object.de_produto	[1] = ivo_Produto.de_produto+': '+ivo_produto.de_apresentacao_estoque
	Else
		This.Object.de_produto	[1] = ''
	End if
End If

If IsValid(ivo_Fornecedor) Then
	This.Object.Cd_Fornecedor[1] = ivo_Fornecedor.Cd_Fornecedor
	This.Object.Nm_Fornecedor[1] = ivo_Fornecedor.Nm_Razao_Social	
End If
end event

event dw_1::editchanged;call super::editchanged;dw_2.Reset ()
end event

type dw_2 from dc_w_2tab_consulta_selecao_lista_2det`dw_2 within tabpage_1
integer x = 41
integer y = 560
integer width = 4745
integer height = 960
string dataobject = "dw_ge617_lista_nf_transferencia"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String		lvs_Especie
String		lvs_Serie
String		lvs_Chv_Acesso
String		lvs_Chv_NF_Ori
String		lvs_Fornecedor

Long			lvl_Filial
Long			lvl_NF
Long			lvl_Produto

DateTime		lvdh_Inicio
DateTime 	lvdh_Termino
DateTime		lvdh_Ini_Canc
DateTime 	lvdh_Fim_Canc
		
// Verifica quais os par$$HEX1$$e200$$ENDHEX$$metros informados
dw_1.AcceptText()

If IsNull (dw_1.Object.Id_Tipo_Nota [1]) then
	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Selecione o tipo de nota!', Exclamation!)
	Return -1
End if

lvl_Filial     = dw_1.Object.Cd_Filial       [1]
lvl_NF         = dw_1.Object.Nr_NF           [1]
lvs_Especie    = dw_1.Object.De_Especie      [1]
lvs_Serie      = dw_1.Object.De_Serie        [1]
lvs_Chv_Acesso = dw_1.Object.De_Chave_Acesso [1]
lvdh_Inicio    = dw_1.Object.Dt_Inicio       [1]
lvdh_Termino   = dw_1.Object.Dt_Termino      [1]
lvl_Produto    = dw_1.Object.cd_produto      [1]
lvs_Fornecedor = dw_1.Object.Cd_Fornecedor   [1]
lvdh_Ini_Canc  = DateTime (dw_1.Object.dt_Ini_Canc [1])
lvdh_Fim_Canc  = DateTime (dw_1.Object.dt_Fim_Canc [1])
lvs_Chv_NF_Ori = dw_1.Object.De_Chave_NF_Ori [1]

// Formula a cl$$HEX1$$e100$$ENDHEX$$usula where correspondente

If not This.of_ChangeDataObject (is_DS) then
	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro no ChangeDataObject da lista de notas', StopSign!)
	Return - 1
End if

If Not IsNull(lvdh_Inicio) then
	This.of_AppendWhere ("nf.dh_movimentacao_caixa >= '" + String(lvdh_Inicio, 'yyyymmdd') + "'")
End If

If Not IsNull(lvdh_Termino) then
	This.of_AppendWhere ("nf.dh_movimentacao_caixa <= '" + String(lvdh_Termino, 'yyyymmdd') + "'")
End If

If Not IsNull(lvl_NF) and lvl_NF > 0 then
	This.of_AppendWhere ('nf.nr_nf = ' + String (lvl_NF))
End If

If Not IsNull(lvs_Especie) and lvs_Especie <> '' then
	This.of_AppendWhere ("nf.de_especie = '" + lvs_Especie + "'")
End If

If Not IsNull(lvs_Serie) and lvs_Serie <> '' then
	This.of_AppendWhere ("nf.de_serie = '" + lvs_Serie + "'")
End If

If Not IsNull(lvs_Chv_Acesso) and lvs_Chv_Acesso <> '' then
	This.of_AppendWhere ("nfe.de_chave_acesso = '" + lvs_Chv_Acesso + "'")
End If

Choose case is_Tipo_Nota
	case 'D'
		This.of_AppendWhere ('nf.cd_filial = ' + String (il_Filial_CD))
		
		If Not IsNull(lvdh_Ini_Canc) then
			This.of_AppendWhere ("CAST (nf.dh_cancelamento AS DATE) >= '" + String(lvdh_Ini_Canc, 'yyyymmdd') + "'" )
		End If
		
		If Not IsNull(lvdh_Fim_Canc) then
			This.of_AppendWhere ("CAST (nf.dh_cancelamento AS DATE) <= '" + String(lvdh_Fim_Canc, 'yyyymmdd') + "'" )
		End If
		
		If Not IsNull(lvs_Fornecedor) and lvs_Fornecedor <> '' then
			This.of_AppendWhere ("nf.cd_fornecedor = '" + lvs_Fornecedor + "'")
		End If
		
		If Not IsNull(lvs_Chv_NF_Ori) and lvs_Chv_NF_Ori <> '' then
			This.of_AppendWhere ("nfc.de_chave_acesso = '" + lvs_Chv_NF_Ori + "'")
		End If
		
		If Not IsNull (lvl_Produto) and lvl_Produto > 0 then
			This.of_AppendWhere ('(EXISTS (SELECT 1 ' + &
													  'FROM item_nf_devolucao_compra indc ' + &
													 'WHERE indc.cd_filial   = nf.cd_filial ' + &
														'AND indc.nr_nf       = nf.nr_nf ' + &
														'AND indc.de_especie  = nf.de_especie ' + &
														'AND indc.de_serie    = nf.de_serie ' + &
														'AND indc.cd_produto  = ' + String (lvl_Produto) + ') ' + &
										 'OR ' + &
										 'EXISTS (SELECT 1 ' + &
													  'FROM nf_devolucao_compra_produto ndcp ' + &
													 'WHERE ndcp.cd_filial   = nf.cd_filial ' + &
														'AND ndcp.nr_nf       = nf.nr_nf ' + &
														'AND ndcp.de_especie  = nf.de_especie ' + &
														'AND ndcp.de_serie    = nf.de_serie ' + &
														'AND ndcp.cd_produto  = ' + String (lvl_Produto) + '))')
		End If
		
	case 'T'
		This.of_AppendWhere ('nf.cd_filial_origem = ' + String (il_filial_origem))
		
		If Not IsNull(lvl_Filial) and lvl_Filial > 0 then
			This.of_AppendWhere ('nf.cd_filial_destino = ' + String (lvl_Filial))
		End If
		
		If Not IsNull (lvl_Produto) and lvl_Produto > 0 then
			This.of_AppendWhere ('EXISTS (SELECT 1 FROM ' + is_tab_item + ' inf ' + &
													'WHERE inf.cd_filial_origem = nf.cd_filial_origem' + &
													'  AND inf.nr_nf            = nf.nr_nf' + &
													'  AND inf.de_especie       = nf.de_especie' + &
													'  AND inf.de_serie         = nf.de_serie' + &
													'  AND inf.cd_produto       = ' + String (lvl_Produto) + ')')
		End If
		
End choose

This.of_SetRowSelection ()
This.of_SetRowSelection ('If ((Not IsNull (dh_reentrada_mercadoria)), RGB (255, 0, 0), ' + This.ivs_Cor_Linha_Padrao + ')', '', False)

Return 1
end event

event dw_2::ue_recuperar;//Override

Return This.Retrieve ()
end event

event dw_2::constructor;call super::constructor;This.ivb_ordena_colunas = True
end event

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_2det`tabpage_2 within tab_1
integer width = 4809
integer height = 1536
end type

type gb_4 from dc_w_2tab_consulta_selecao_lista_2det`gb_4 within tabpage_2
integer x = 27
integer y = 728
integer width = 4174
integer height = 792
long backcolor = 79741120
string text = "Itens"
end type

type gb_3 from dc_w_2tab_consulta_selecao_lista_2det`gb_3 within tabpage_2
integer x = 27
integer y = 20
integer width = 3461
integer height = 704
long backcolor = 79741120
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_2det`dw_3 within tabpage_2
integer x = 46
integer y = 96
integer width = 3410
integer height = 592
string dataobject = "dw_ge617_detalhe_nf_transferencia"
end type

event dw_3::ue_recuperar;// OverRide

Long		lvl_Nr_NF, &
			lvl_Filial
	  
String	lvs_De_Especie, &
			lvs_De_Serie
		 
Integer	lvi_Linha_Ativa, &
			lvi_Linhas

lvi_Linha_Ativa = Tab_1.TabPage_1.dw_2.GetRow()

lvl_Nr_NF       = Tab_1.TabPage_1.dw_2.Object.Nr_NF      [lvi_Linha_Ativa]
lvs_De_Especie  = Tab_1.TabPage_1.dw_2.Object.De_Especie [lvi_Linha_Ativa]
lvs_De_Serie    = Tab_1.TabPage_1.dw_2.Object.De_Serie   [lvi_Linha_Ativa]

Choose case is_Tipo_Nota
	case 'D'
		lvl_Filial = Tab_1.TabPage_1.dw_2.Object.cd_filial        [lvi_Linha_Ativa]
	case 'T'
		lvl_Filial = Tab_1.TabPage_1.dw_2.Object.cd_filial_origem [lvi_Linha_Ativa]
End choose

lvi_Linhas = This.Retrieve (lvl_Filial, &
									 lvl_Nr_NF, &
									 lvs_De_Especie, &
									 lvs_De_Serie)

Return lvi_Linhas
end event

type dw_4 from dc_w_2tab_consulta_selecao_lista_2det`dw_4 within tabpage_2
integer x = 41
integer y = 780
integer width = 4155
integer height = 720
string dataobject = "dw_ge617_detalhe_item_transferencia"
boolean vscrollbar = true
end type

event dw_4::ue_recuperar;// OverRide

Long		lvl_Nr_NF, &
			lvl_Filial
	  
String	lvs_De_Especie, &
			lvs_De_Serie
		 
Integer	lvi_Linha_Ativa, &
			lvi_Linhas
		  
lvi_Linha_Ativa = Tab_1.TabPage_1.dw_2.GetRow()

lvl_Nr_NF       = Tab_1.TabPage_1.dw_2.Object.Nr_NF      [lvi_Linha_Ativa]
lvs_De_Especie  = Tab_1.TabPage_1.dw_2.Object.De_Especie [lvi_Linha_Ativa]
lvs_De_Serie    = Tab_1.TabPage_1.dw_2.Object.De_Serie   [lvi_Linha_Ativa]

Choose case is_Tipo_Nota
	case 'D'
		lvl_Filial = Tab_1.TabPage_1.dw_2.Object.cd_filial        [lvi_Linha_Ativa]
	case 'T'
		lvl_Filial = Tab_1.TabPage_1.dw_2.Object.cd_filial_origem [lvi_Linha_Ativa]
End choose

lvi_Linhas = This.Retrieve (lvl_Filial, &
									 lvl_Nr_NF, &
									 lvs_De_Especie, &
									 lvs_De_Serie)

Return lvi_Linhas

end event

event dw_4::constructor;call super::constructor;This.ivb_ordena_colunas = True
end event

type cb_entrar from commandbutton within tabpage_1
integer x = 4197
integer y = 420
integer width = 594
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Entrar Mercadoria"
end type

event clicked;//DECLARA$$HEX2$$c700d500$$ENDHEX$$ES
DateTime	ldh_nulo

Long		ll_NF, &
			ll_NF_origem, &
			ll_Linha, &
			ll_Filial

String	ls_Operador, &
			ls_Especie, &
			ls_Especie_origem, &
			ls_Serie, &
			ls_Serie_origem, &
			ls_fornecedor, &
			ls_Endereco_Dest, &
			ls_Erro

//PROCEDIMENTO
SetNull (ldh_nulo)

dw_2.AcceptText ()

ll_Linha = dw_2.GetRow ()

If ll_Linha <= 0 then
	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Selecione uma nota para processar a entrada de mercadoria', Exclamation!)
	Return
End if

Choose case is_Tipo_Nota
	case 'D'
		If not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento ('GE617_ENTR_MERC_DEV', ref ls_Operador) then Return
		ll_Filial = dw_2.Object.cd_filial [ll_Linha]
	case 'T'
		If not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento ('GE617_ENTRADA_DE_MERCADORIA', ref ls_Operador) then Return
		ll_Filial = dw_2.Object.cd_filial_origem [ll_Linha]
//	case 'I'
//		If not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento ('GE617_ENTRADA_DE_MERCADORIA', ref ls_Operador) then Return
End choose

If MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Confirma a reentrada das mercadorias da nota selecionada?', Question!, YesNo!, 2) = 2 then Return

If Not wf_obtem_enderecos () then Return

Open (w_Aguarde)

Try
	ids_Produtos = Create dc_uo_ds_Base
	
	If not ids_Produtos.of_ChangeDataObject (is_DS_itens) then
		Return
	End if
	
	ll_NF      = dw_2.Object.nr_nf                 [ll_Linha]
	ls_Especie = dw_2.Object.de_especie            [ll_Linha]
	ls_Serie   = dw_2.Object.de_serie              [ll_Linha]
	
	If IsNull (dw_2.Object.dh_reentrada_mercadoria [ll_Linha]) then
	
		Choose case is_Tipo_Nota
			case 'D'
				ll_NF_origem      = dw_2.Object.nr_nf_compra      [ll_Linha]
				ls_Especie_origem = dw_2.Object.de_especie_compra [ll_Linha]
				ls_Serie_origem   = dw_2.Object.de_serie_compra   [ll_Linha]
				ls_fornecedor     = dw_2.Object.cd_fornecedor     [ll_Linha]
				
				Choose case dw_2.Object.cd_motivo_devolucao [ll_Linha]
					case 1 //AVARIA
						ls_Endereco_Dest = is_Endereco_Avaria
					case 5 //FALTA
						ls_Endereco_Dest = is_Endereco_Falta
					case else //outros tipos de devolu$$HEX2$$e700e300$$ENDHEX$$o v$$HEX1$$e300$$ENDHEX$$o para o endere$$HEX1$$e700$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rico
						ls_Endereco_Dest = is_Endereco_Destino
				End choose
				
			case 'T'
				SetNull (ll_NF_origem)
				SetNull (ls_Especie_origem)
				SetNull (ls_Serie_origem)
				SetNull (ls_fornecedor)
				ls_Endereco_Dest = is_Endereco_Destino
		End choose
		
		If wf_processa_entrada_mercadoria (ll_Filial,         &
													  ll_NF,             &
													  ls_Especie,        &
													  ls_Serie,          &
													  ls_Operador,       &
													  ll_NF_origem,      &
													  ls_Especie_origem, &
													  ls_Serie_origem,   &
													  ls_fornecedor,     &
													  ls_Endereco_Dest) then
			dw_2.Object.dh_reentrada_mercadoria [ll_linha] = gf_GetServerDate ()
			If dw_2.Update () = 1 then
				SQLCA.of_Commit ()
			else
				ls_Erro = SQLCA.SQLErrText
				SQLCA.of_RollBack ()
				dw_2.Object.dh_reentrada_mercadoria [ll_linha] = ldh_nulo
				dw_2.ResetUpdate ()
				MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o da nota ' + String (ll_NF) + ':~n~n~r' + ls_Erro, StopSign!)
			End if
		End if
	else
		MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', &
						'Os produtos da ' + is_Desc_Tipo_Nota + ' Cancelada ' + String (ll_NF) + '-' + ls_Especie + '-' + ls_Serie + ' j$$HEX1$$e100$$ENDHEX$$ entraram no saldo do CD.~n~n~r' + &
						'Opera$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o processada!', &
						Exclamation!)
	End if
	
Finally
	Destroy ids_Produtos
	Close (w_Aguarde)
End Try
end event

