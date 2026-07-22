HA$PBExportHeader$uo_ge258_movimentacao.sru
forward
global type uo_ge258_movimentacao from nonvisualobject
end type
end forward

global type uo_ge258_movimentacao from nonvisualobject
end type
global uo_ge258_movimentacao uo_ge258_movimentacao

type variables
Boolean 	ivb_Commit = True
Boolean	ib_mostra_erro_tela = True
Boolean 	ivb_Endereco_Bloqueado = True
Boolean 	ivb_Valida_Inventario = True
String 	is_chave_movimento
String	is_log_erro

PRIVATE String	is_tipo_movto_selecionado

CONSTANT String CIS_TIPO_DESMONTA_KIT = 'DESMONTA_KIT'
end variables

forward prototypes
private function boolean of_sequencial (string as_endereco, long al_produto, string as_lote, long al_cx_padrao, datetime adh_validade, ref long al_sequencial)
public function boolean of_insere_movimentacao (string as_endereco_entrada, string as_endereco_saida, long al_produto, long al_cx_padrao, string as_lote, date adh_validade, long al_qt_movimentada, string as_tipo_movimento, long al_filial, string as_fornecedor, long al_nota, string as_especie, string as_serie, string as_matricula_responsavel)
public function boolean of_insere_movimentacao (string as_endereco_entrada, string as_endereco_saida, long al_produto, long al_cx_padrao, string as_lote, date adh_validade, long al_qt_movimentada, string as_tipo_movimento)
public function boolean of_insere_movimentacao (string as_endereco_entrada, string as_endereco_saida, long al_produto, long al_cx_padrao, string as_lote, date adh_validade, long al_qt_movimentada, string as_tipo_movimento, long al_filial, string as_fornecedor, long al_nota, string as_especie, string as_serie, string as_matricula_responsavel, long al_sequencial)
public function boolean of_insere_movimentacao (string as_endereco_entrada, string as_endereco_saida, long al_produto, long al_cx_padrao, string as_lote, date adh_validade, long al_qt_movimentada, string as_tipo_movimento, long al_filial, string as_fornecedor, long al_nota, string as_especie, string as_serie, string as_matricula_responsavel, long al_sequencial, decimal adc_bc_icms_st, decimal adc_icms_st, decimal adc_custo_unitario, decimal adc_custo_gerencial)
public function boolean of_endereco_fracionado (string as_endereco, ref string as_fracionado)
private function boolean of_sequencial_saida (string as_endereco, long al_produto, string as_lote, long al_cx_padrao, datetime adh_validade, ref long al_sequencial)
public function boolean of_corrige_saldo_negativo (long al_produto)
public function boolean of_atualiza_movimentacao (string as_endereco_entrada, long al_produto, long al_nr_movimentacao, long al_qt_movimento, string as_lote, long al_cx_padrao, datetime adh_validade, string as_matricula)
public function boolean of_atualiza_movimentacao (string as_endereco_entrada, long al_produto, long al_nr_movimentacao, long al_qt_movimento, string as_lote, long al_cx_padrao, datetime adh_validade)
public function boolean of_inclui_lote_transferencia_transito (long al_filial_origem, long al_nota)
public function boolean of_set_mostra_erro_tela (boolean ab_mostra_erro_tela)
public function boolean of_buscar_ultima_movimentacao (long al_cd_produto, string as_endereco, string as_tipo_endereco, string as_nr_lote, long al_qt_caixa_padrao, date ad_dh_validade, string as_id_tipo_movimento, string as_nr_matricula, ref long al_nr_movimentacao)
public function boolean of_set_tipo_movto (string as_tipo_movto, ref string as_log)
end prototypes

private function boolean of_sequencial (string as_endereco, long al_produto, string as_lote, long al_cx_padrao, datetime adh_validade, ref long al_sequencial);
Select top 1 nr_sequencial
Into :al_Sequencial
From wms_localizacao
Where cd_endereco 		= :as_Endereco
	and cd_produto 		= :al_Produto
	and nr_lote				= :as_Lote
	and qt_caixa_padrao = :al_Cx_Padrao
	and dh_validade 		= :adh_Validade
Order by nr_sequencial desc	
Using SqlCa;

Choose Case SqlCa.SqlCode 	
	Case 0
		Return True
	Case 100
		Select isnull(max(nr_sequencial), 0) + 1
		Into :al_Sequencial
		From wms_localizacao
		Where cd_endereco = :as_Endereco
		Using SqlCa;
		Choose Case SqlCa.SqlCode 
			Case -1
				is_log_erro	= "Erro ao localizar o pr$$HEX1$$f300$$ENDHEX$$ximo sequencial: "+ SqlCa.SQLErrText
				
				SQLCA.of_rollback()
				
				if ib_mostra_erro_tela then
					MessageBox("Erro", is_log_erro)
				end if
				
				Return False
		End Choose
	Case -1
		is_log_erro	= "Erro ao localizar o pr$$HEX1$$f300$$ENDHEX$$ximo sequencial: "+ SqlCa.SQLErrText
		
		SQLCA.of_rollback()
		
		if ib_mostra_erro_tela then
			MessageBox("Erro", is_log_erro)
		end if

		Return False
End Choose

Return True
end function

public function boolean of_insere_movimentacao (string as_endereco_entrada, string as_endereco_saida, long al_produto, long al_cx_padrao, string as_lote, date adh_validade, long al_qt_movimentada, string as_tipo_movimento, long al_filial, string as_fornecedor, long al_nota, string as_especie, string as_serie, string as_matricula_responsavel);Boolean lvb_Retorno

String ls_Nulo

Long ll_Nulo, ll_Sequencial

SetNull(ls_Nulo)
SetNull(ll_Nulo)
SetNull(ll_Sequencial)

lvb_Retorno = of_insere_movimentacao(as_endereco_entrada, as_endereco_saida, al_produto,&
															al_cx_padrao, as_lote, adh_validade, al_qt_movimentada,&
															as_tipo_movimento, al_filial, as_fornecedor,&
															al_nota, as_especie, as_serie, as_matricula_responsavel, ll_Sequencial)

Return lvb_Retorno
end function

public function boolean of_insere_movimentacao (string as_endereco_entrada, string as_endereco_saida, long al_produto, long al_cx_padrao, string as_lote, date adh_validade, long al_qt_movimentada, string as_tipo_movimento);Boolean lvb_Retorno

String ls_Nulo

Long ll_Nulo

SetNull(ls_Nulo)
SetNull(ll_Nulo)

lvb_Retorno = of_insere_movimentacao(as_endereco_entrada, as_endereco_saida, al_produto,&
															al_cx_padrao, as_lote, adh_validade, al_qt_movimentada,&
															as_tipo_movimento, ll_Nulo, ls_Nulo,&
															ll_Nulo, ls_Nulo, ls_Nulo, ls_Nulo)

Return lvb_Retorno
end function

public function boolean of_insere_movimentacao (string as_endereco_entrada, string as_endereco_saida, long al_produto, long al_cx_padrao, string as_lote, date adh_validade, long al_qt_movimentada, string as_tipo_movimento, long al_filial, string as_fornecedor, long al_nota, string as_especie, string as_serie, string as_matricula_responsavel, long al_sequencial);Boolean lvb_Retorno

String ls_Nulo

Long ll_Nulo

SetNull(ls_Nulo)
SetNull(ll_Nulo)

lvb_Retorno = of_insere_movimentacao(as_endereco_entrada, as_endereco_saida, al_produto,&
															al_cx_padrao, as_lote, adh_validade, al_qt_movimentada,&
															as_tipo_movimento, al_Filial, as_Fornecedor,&
															al_Nota, as_Especie, as_Serie, as_Matricula_Responsavel,&
															al_Sequencial, 0.00, 0.00, 0.00, 0.00)

Return lvb_Retorno
end function

public function boolean of_insere_movimentacao (string as_endereco_entrada, string as_endereco_saida, long al_produto, long al_cx_padrao, string as_lote, date adh_validade, long al_qt_movimentada, string as_tipo_movimento, long al_filial, string as_fornecedor, long al_nota, string as_especie, string as_serie, string as_matricula_responsavel, long al_sequencial, decimal adc_bc_icms_st, decimal adc_icms_st, decimal adc_custo_unitario, decimal adc_custo_gerencial);Long 		ll_Sequencial_Saida, ll_Sequencial_Entrada, ll_Qt_Recebida
String 	ls_Erro_Insert, ls_Matricula_Responsavel, ls_Erro_End_Bloq
Boolean 	lb_Endereco_Bloqueado_In, lb_Endereco_Bloqueado_Out

SetNull(ll_Sequencial_Saida)
SetNull(ll_Sequencial_Entrada)

If Not IsNull(as_Endereco_Entrada) And as_Endereco_Entrada <> "" Then
	If Not of_Sequencial(as_Endereco_Entrada, al_Produto, as_lote, al_cx_padrao, DateTime(adh_validade), Ref ll_Sequencial_Entrada) Then
		Return False
	End If
End If

If Not IsNull(as_Endereco_Saida) And as_Endereco_Saida <> "" Then
	If Not IsNull(al_sequencial) and al_sequencial > 0 Then
		ll_Sequencial_Saida = al_sequencial
	Else
		If Not of_Sequencial_Saida(as_Endereco_Saida, al_Produto, as_Lote, al_cx_padrao, DateTime(adh_validade), Ref ll_Sequencial_Saida) Then
			Return False
		End If
	End If
End If
		
If IsNull(as_matricula_responsavel) Then
	ls_Matricula_Responsavel = gvs_ws001_Matricula
Else
	ls_Matricula_Responsavel = as_matricula_responsavel
End If

//Valida se endereco est$$HEX1$$e100$$ENDHEX$$ desbloqueado
If ivb_Endereco_Bloqueado Then	
	// Endereco de Entrada
	If Not IsNull(as_endereco_entrada) And as_endereco_entrada <> "" Then
		If Not gf_Verifica_Endereco_Bloqueado(as_endereco_entrada, Ref ls_Erro_End_Bloq) Then 
			SQLCA.of_rollback()
			
			is_log_erro	= ls_Erro_End_Bloq
		
			if ib_mostra_erro_tela then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", is_log_erro)
			end if
			
			Return False
		End If
	End If 	
	
	// Endereco de Saida
	If Not IsNull(as_endereco_saida) And as_endereco_saida <> "" Then
		If Not gf_Verifica_Endereco_Bloqueado(as_endereco_saida, Ref ls_Erro_End_Bloq) Then 
			SQLCA.of_rollback()
			
			is_log_erro	= ls_Erro_End_Bloq
		
			if ib_mostra_erro_tela then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", is_log_erro)
			end if
			
			Return False
		End If
	End If 
End If


If ivb_Valida_Inventario Then 
	// N$$HEX1$$e300$$ENDHEX$$o Movimenta se Estiver em Invent$$HEX1$$e100$$ENDHEX$$rio: Endereco do Flow
	If Not IsNull(as_endereco_entrada) And as_endereco_entrada <> "" Then
		If gf_wms_endereco_inventario(as_endereco_entrada) Then
			Return False
		End If
	End If 	
	
	// N$$HEX1$$e300$$ENDHEX$$o Movimenta se Estiver em Invent$$HEX1$$e100$$ENDHEX$$rio: Endereco do Flow
	If Not IsNull(as_endereco_saida) And as_endereco_saida <> "" Then
		If gf_wms_endereco_inventario(as_endereco_saida) Then
			Return False
		End If	
	End If
End If 

If Not IsNull(is_chave_movimento)  and Trim(is_chave_movimento) <> '' Then

	Insert into wms_movimentacao(
				cd_endereco_entrada,
				nr_sequencial_entrada,
				cd_endereco_saida,
				nr_sequencial_saida,
				cd_produto,
				qt_caixa_padrao,
				nr_lote,
				dh_validade,
				qt_movimento,
				id_tipo_movimento,
				dh_movimentacao,
				nr_matricula_responsavel,
				cd_filial,
				cd_fornecedor,
				nr_nf,
				de_especie,
				de_serie,
				vl_bc_icms_st,
				vl_icms_st,
				vl_custo_unitario,
				vl_custo_gerencial,
				cd_chave_movimento)
	Values(	:as_Endereco_Entrada,
				:ll_Sequencial_Entrada,
				:as_Endereco_Saida,
				:ll_Sequencial_Saida,
				:al_Produto,
				:al_Cx_Padrao,
				:as_Lote,
				:adh_Validade,
				:al_Qt_Movimentada,
				:as_Tipo_Movimento,
				GetDate(),
				:ls_Matricula_Responsavel,
				:al_Filial,
				:as_Fornecedor,
				:al_Nota,
				:as_Especie,
				:as_serie,
				:adc_bc_icms_st,
				:adc_icms_st,
				:adc_custo_unitario,
				:adc_custo_gerencial,
				:is_chave_movimento)
	Using SqlCa;

Else
	
	Insert into wms_movimentacao(
			cd_endereco_entrada,
			nr_sequencial_entrada,
			cd_endereco_saida,
			nr_sequencial_saida,
			cd_produto,
			qt_caixa_padrao,
			nr_lote,
			dh_validade,
			qt_movimento,
			id_tipo_movimento,
			dh_movimentacao,
			nr_matricula_responsavel,
			cd_filial,
			cd_fornecedor,
			nr_nf,
			de_especie,
			de_serie,
			vl_bc_icms_st,
			vl_icms_st,
			vl_custo_unitario,
			vl_custo_gerencial)
Values(	:as_Endereco_Entrada,
			:ll_Sequencial_Entrada,
			:as_Endereco_Saida,
			:ll_Sequencial_Saida,
			:al_Produto,
			:al_Cx_Padrao,
			:as_Lote,
			:adh_Validade,
			:al_Qt_Movimentada,
			:as_Tipo_Movimento,
			GetDate(),
			:ls_Matricula_Responsavel,
			:al_Filial,
			:as_Fornecedor,
			:al_Nota,
			:as_Especie,
			:as_serie,
			:adc_bc_icms_st,
			:adc_icms_st,
			:adc_custo_unitario,
			:adc_custo_gerencial)
Using SqlCa;
	
	
End If

If SqlCa.SqlCode = -1 Then
	ls_Erro_Insert = SqlCa.SQLErrText
	SqlCa.of_RollBack()
	
	is_log_erro	= "Erro ao inserir dados na tabela 'wms_movimentacao': "+ ls_Erro_Insert
		
	if ib_mostra_erro_tela then
		MessageBox("Erro", is_log_erro)
	end if
	
	Return False
End If

If ivb_Commit Then
	SqlCa.of_Commit()
End If

Return True
end function

public function boolean of_endereco_fracionado (string as_endereco, ref string as_fracionado);Select coalesce(id_fracionado, 'N')
Into :as_fracionado
From vw_wms_endereco
Where cd_endereco = :as_endereco
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Return True
	Case 100
		SQLCA.of_rollback()
		
		is_log_erro	= "Endere$$HEX1$$e700$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o localizado '" + as_Endereco + "'."
		
		if ib_mostra_erro_tela then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", is_log_erro, StopSign!)
		end if
	Case -1
		is_log_erro	= "Erro ao verificar endere$$HEX1$$e700$$ENDHEX$$o fracionado: "+ SqlCa.SQLErrText
		
		SQLCA.of_rollback()
		
		if ib_mostra_erro_tela then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", is_log_erro, StopSign!)
		end if
End Choose

Return False
end function

private function boolean of_sequencial_saida (string as_endereco, long al_produto, string as_lote, long al_cx_padrao, datetime adh_validade, ref long al_sequencial);String ls_Erro_Insert, ls_Chave

select //Top 1
		nr_sequencial
Into :al_sequencial
from wms_localizacao 
where cd_endereco 		= :as_Endereco
  and cd_produto 			= :al_Produto
  and nr_lote 				= :as_Lote
  and qt_caixa_padrao 	= :al_Cx_Padrao
  and dh_validade			= :adh_Validade
Using SqlCa;

Choose Case SqlCa.SqlCode 
	Case -1
		ls_Chave = "End:'" + as_Endereco + "' Produto: '" +  String(al_Produto) + "' Lote: '" + as_Lote + "' Validade: '" + String(adh_Validade, "dd/mm/yyyy") + "'" 
		ls_Erro_Insert = SqlCa.SQLErrText
		SqlCa.of_RollBack();
		
		is_log_erro	= "Erro ao localizar o sequencial " + ls_Chave + " '" + ls_Erro_Insert + "'."
		
		if ib_mostra_erro_tela then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", is_log_erro, StopSign!)
		end if
		
		Return False
	Case 100
		SqlCa.of_RollBack();
		
		is_log_erro	= "Sequencial n$$HEX1$$e300$$ENDHEX$$o localizado.~r~r"+&
						 	"Endere$$HEX1$$e700$$ENDHEX$$o: "+as_Endereco+"~r"+&
							"Produto: "+String(al_Produto)+"~r"+&
							"Lote: "+as_Lote+"~r"+&
							"Cx. Padrao: "+String(al_Cx_Padrao)+"~r"+&
							"Validade: "+String(adh_Validade, "dd-mm-yyyy") + "~r~r"+&
							"Verifique na aba [Lista de Produtos para Devolu$$HEX2$$e700e300$$ENDHEX$$o] se a validade do lote est$$HEX1$$e100$$ENDHEX$$ correta.~r~r"+&
							"Se for necess$$HEX1$$e100$$ENDHEX$$rio alterar, utilize bot$$HEX1$$e300$$ENDHEX$$o [Alterar Validade] nesta mesma aba."
		
		if ib_mostra_erro_tela then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", is_log_erro, StopSign!)
		end if
		
		Return False
End Choose

Return True
end function

public function boolean of_corrige_saldo_negativo (long al_produto);String ls_Mensagem, ls_Lote, ls_Lote2, ls_Endereco_Negativo, ls_Nulo, ls_Msg

Long ll_Linha, ll_Linhas, ll_Produto, ll_Qtde_Negativa, ll_Linha_Lote, ll_Linhas_Lote, ll_Qtde_Saldo

Long ll_Qtde_Movimento, ll_Nulo, ll_Seq_Negativo, ll_Seq_Lote

Date ldh_Validade, lvdh_Validade2
		
SetNull(ls_Nulo)
SetNull(ll_Nulo)

TRY
	dc_uo_ds_base lds
	lds = Create dc_uo_ds_base
	If Not  lds.of_ChangeDataObject("ds_ge258_lote_negativo") Then	Return False
	
	dc_uo_ds_base lds_lote
	lds_lote = Create dc_uo_ds_base
	If Not lds_lote.of_ChangeDataObject("ds_ge258_lote_positivo") Then	Return False
		
	ll_Linhas  = lds.Retrieve(al_Produto)
	
	If ll_Linhas > 0 Then
			
		For ll_Linha = 1 To ll_Linhas
				
			ll_Produto 				= lds.Object.cd_produto	[ll_Linha]
			ll_Qtde_Negativa	= lds.Object.qt_saldo		[ll_Linha]
			ls_Lote					= lds.Object.nr_lote			[ll_Linha]
			ldh_Validade			= date(lds.Object.dh_validade	[ll_Linha])
			ls_Endereco_Negativo	= lds.Object.cd_endereco[ll_Linha]
			ll_Seq_Negativo			= lds.Object.nr_sequencial[ll_Linha]
			
			ll_Qtde_Negativa = ll_Qtde_Negativa * (-1)
							
			ll_Linhas_Lote = lds_lote.Retrieve(ll_produto, ls_Endereco_Negativo)
						
			If ll_Linhas_Lote > 0 Then
			
				For ll_Linha_Lote = 1 to ll_Linhas_Lote
					
					ls_Lote2			= lds_lote.Object.nr_lote			[ll_Linha_Lote]
					lvdh_Validade2	= date(lds_lote.Object.dh_validade	[ll_Linha_Lote])
					ll_Qtde_Saldo		= lds_lote.Object.qt_saldo		[ll_Linha_Lote]
					ll_Seq_lote			= lds_lote.Object.nr_sequencial[ll_Linha_Lote]
									
					If ll_Qtde_Saldo >= ll_Qtde_Negativa Then
						ll_Qtde_Movimento = ll_Qtde_Negativa
						
						// ENTRADA DO SALDO DO LOTE NEGATIVO
						Insert into wms_movimentacao(cd_endereco_entrada, nr_sequencial_entrada, cd_endereco_saida,
													 nr_sequencial_saida, cd_produto, qt_caixa_padrao, nr_lote,dh_validade,	
													 qt_movimento,id_tipo_movimento,dh_movimentacao,	nr_matricula_responsavel,
													 cd_filial,cd_fornecedor,nr_nf,de_especie,de_serie)
						Values(	:ls_Endereco_Negativo,:ll_Seq_Negativo,null,null,:ll_Produto,1,:ls_Lote,:ldh_Validade,
									:ll_Qtde_Movimento,	'M',GetDate(),'14330',null,NULL,NULL,NULL,NULL)
						Using SqlCa;
					
						If  SqlCa.SqlCode = -1 Then
							is_log_erro = "Erro ao inserir dados na tabela 'wms_movimentacao': "+SqlCa.SQLErrText
							
							SqlCa.of_RollBack()
								
							if ib_mostra_erro_tela then
								MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", is_log_erro, StopSign!)
							end if
							
							Return False
						End If
						
						// SAIDA DO LOTE POSITIVO
						Insert into wms_movimentacao(	cd_endereco_entrada,	nr_sequencial_entrada,cd_endereco_saida,
																		nr_sequencial_saida,cd_produto,qt_caixa_padrao,nr_lote,
																		dh_validade,qt_movimento,id_tipo_movimento,dh_movimentacao,
																		nr_matricula_responsavel,cd_filial,cd_fornecedor,nr_nf,de_especie,
																		de_serie)
						Values(	null,null,	:ls_Endereco_Negativo,:ll_Seq_lote,:ll_Produto,	1,:ls_Lote2,:lvdh_Validade2,
									:ll_Qtde_Movimento,'M',GetDate(),'14330',	null,NULL,NULL,NULL,NULL)
						Using SqlCa;
						
						If  SqlCa.SqlCode = -1 Then
							is_log_erro = "Erro ao inserir dados na tabela 'wms_movimentacao': "+SqlCa.SQLErrText
							
							SqlCa.of_RollBack()
							
							if ib_mostra_erro_tela then
								MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", is_log_erro, StopSign!)
							end if
							
							Return False
						End If
											
						Exit
					Else
						ll_Qtde_Movimento = ll_Qtde_Saldo
						
						// ENTRADA DO SALDO DO LOTE NEGATIVO
						Insert into wms_movimentacao(cd_endereco_entrada, nr_sequencial_entrada, cd_endereco_saida,
													 nr_sequencial_saida, cd_produto, qt_caixa_padrao, nr_lote,dh_validade,	
													 qt_movimento,id_tipo_movimento,dh_movimentacao,	nr_matricula_responsavel,
													 cd_filial,cd_fornecedor,nr_nf,de_especie,de_serie)
						Values(	:ls_Endereco_Negativo,:ll_Seq_Negativo,null,null,:ll_Produto,1,:ls_Lote,:ldh_Validade,
									:ll_Qtde_Movimento,	'M',GetDate(),'14330',null,NULL,NULL,NULL,NULL)
						Using SqlCa;
					
						If  SqlCa.SqlCode = -1 Then
							is_log_erro = "Erro ao inserir dados na tabela 'wms_movimentacao': "+SqlCa.SQLErrText
							
							SqlCa.of_RollBack()
							
							if ib_mostra_erro_tela then
								MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", is_log_erro, StopSign!)
							end if
							
							Return False
						End If
						
						// SAIDA DO LOTE POSITIVO
						Insert into wms_movimentacao(	cd_endereco_entrada,	nr_sequencial_entrada,cd_endereco_saida,
																		nr_sequencial_saida,cd_produto,qt_caixa_padrao,nr_lote,
																		dh_validade,qt_movimento,id_tipo_movimento,dh_movimentacao,
																		nr_matricula_responsavel,cd_filial,cd_fornecedor,nr_nf,de_especie,
																		de_serie)
						Values(	null,null,	:ls_Endereco_Negativo,:ll_Seq_lote,:ll_Produto,	1,:ls_Lote2,:lvdh_Validade2,
									:ll_Qtde_Movimento,'M',GetDate(),'14330',	null,NULL,NULL,NULL,NULL)
						Using SqlCa;
						
						If  SqlCa.SqlCode = -1 Then
							is_log_erro = "Erro ao inserir dados na tabela 'wms_movimentacao': "+SqlCa.SQLErrText
							
							SqlCa.of_RollBack()
							
							if ib_mostra_erro_tela then
								MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", is_log_erro, StopSign!)
							end if
							
							Return False
						End If
						
						ll_Qtde_Negativa = ll_Qtde_Negativa - ll_Qtde_Movimento
						
						If ll_Qtde_Negativa = 0 Then Exit					
					End If
					
				Next	
				
			End If
				
			Delete from wms_localizacao
			Where cd_endereco 	= :ls_Endereco_Negativo
				and nr_sequencial 	= :ll_Seq_Negativo
				and cd_produto		= :ll_Produto
				and qt_saldo 			= 0
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				is_log_erro = "Erro ao excluir o registro da tabela wms_localizacao "+SqlCa.SQLErrText
							
				SqlCa.of_RollBack()
				
				if ib_mostra_erro_tela then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", is_log_erro, StopSign!)
				end if
				
				Return False
			End If			
			
		Next
		
	ElseIf ll_Linhas < 0 Then
		SqlCa.of_RollBack()

		is_log_erro = "Erro ao listar os lotes para corrigir o saldo negativo."
							
		if ib_mostra_erro_tela then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", is_log_erro, StopSign!)
		end if
				
		Return False
	End If
		
FINALLY
	Destroy lds
	Destroy lds_lote
END TRY

Return True
end function

public function boolean of_atualiza_movimentacao (string as_endereco_entrada, long al_produto, long al_nr_movimentacao, long al_qt_movimento, string as_lote, long al_cx_padrao, datetime adh_validade, string as_matricula);String 	ls_Erro, ls_Fracionado
Long		ll_Sequencial_Entrada, ll_Caixa_Padrao

If Not This.of_Endereco_Fracionado(as_Endereco_Entrada, ref ls_Fracionado) Then Return False

If ls_Fracionado = 'S' Then
	ll_Caixa_Padrao = 1
Else
	ll_Caixa_Padrao = al_Cx_Padrao
End If

If Not of_Sequencial(as_Endereco_Entrada, al_Produto, as_Lote, ll_Caixa_Padrao, adh_Validade,Ref ll_Sequencial_Entrada) Then
	Return False
End If

If IsNull(as_Matricula) Then
	Update wms_movimentacao
				set cd_endereco_entrada 		= :as_Endereco_Entrada,
					nr_sequencial_entrada 		= :ll_Sequencial_Entrada,
					qt_movimento 					= :al_Qt_Movimento
	where nr_movimentacao = :al_Nr_Movimentacao
	Using SqlCa;
Else
	Update wms_movimentacao
				set cd_endereco_entrada 		= :as_Endereco_Entrada,
					nr_sequencial_entrada 		= :ll_Sequencial_Entrada,
					qt_movimento 					= :al_Qt_Movimento,
					nr_matricula_responsavel	= :as_Matricula
	where nr_movimentacao = :al_Nr_Movimentacao
	Using SqlCa;
End If

Choose Case SqlCa.SqlCode
	Case -1		
		ls_Erro = SqlCa.SQLErrText
		SqlCa.of_RollBack()

		is_log_erro = "Erro ao inserir dados na tabela 'wms_movimentacao': "+ ls_Erro
							
		if ib_mostra_erro_tela then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", is_log_erro, StopSign!)
		end if
		
		Return False		
End Choose

If ivb_Commit Then
	SqlCa.of_Commit()
End If

Return True
end function

public function boolean of_atualiza_movimentacao (string as_endereco_entrada, long al_produto, long al_nr_movimentacao, long al_qt_movimento, string as_lote, long al_cx_padrao, datetime adh_validade);String ls_Matricula

SetNull(ls_Matricula)

If Not of_atualiza_movimentacao(as_endereco_entrada, al_produto, al_nr_movimentacao, al_qt_movimento, as_lote, al_cx_padrao, adh_validade, ls_Matricula) Then
	Return False
End If

Return True
end function

public function boolean of_inclui_lote_transferencia_transito (long al_filial_origem, long al_nota);/*
	Objetivo: Esta fun$$HEX2$$e700e300$$ENDHEX$$o serve para incluir o lote gen$$HEX1$$e900$$ENDHEX$$rico de transfer$$HEX1$$ea00$$ENDHEX$$ncia em tr$$HEX1$$e200$$ENDHEX$$nsito
	Deve ser usado pontualmente
	Corrigir o saldo na WMS_LOCALIZACAO
	FOI COLOCADO UM BOT$$HEX1$$c300$$ENDHEX$$O NA WS001 ONDE INCLUI ENDERECOS.. PARA ESTA FUN$$HEX2$$c700c300$$ENDHEX$$O...
*/

String lvs_Endereco_Mercadoria_Transito , lvs_Log , lvs_Lote
String lvs_Data, lvs_Chave, lvs_TipoAlteracao, lvs_Matricula, lvs_Especie, lvs_Serie

Long  ll_Linha, ll_Linhas, ll_Qtd_Antes, ll_Achou, ll_Loja, ll_Nr_NF
Long ll_Produto, ll_Qtd, ll_Sequencial_Novo, ll_Sequencial_Existe


// Informa$$HEX2$$e700f500$$ENDHEX$$es Fixas
Boolean lb_Sucesso =  True 
lvs_Lote 		= 'SEM LOTE'
lvs_Data  	=  '2099-12-31'
lvs_Matricula = String(gvo_Aplicacao.ivo_Seguranca.Nr_Matricula) 

/// Endereco Mercadoria em Transito
Select vl_parametro
Into :lvs_Endereco_Mercadoria_Transito
From wms_parametro
where cd_parametro = 'CD_ENDERECO_SEGREGADO_MERCADORIA_TRANSIT'
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	lb_Sucesso = False
	SqlCa.Of_MsgDbError("Erro ao localizar endereco mercadoria em transito") 
	SqlCa.of_RollBack()
   	Return lb_Sucesso
End If


dc_uo_ds_base lds_produtos
lds_produtos = Create dc_uo_ds_base
		
If Not lds_produtos.of_ChangeDataObject("ds_ge258_produtos_nota_problema", False) Then
	lb_Sucesso = False
	lvs_Log = "Erro na ds_ge258_produtos_nota_problema"
	gvo_aplicacao.of_grava_log(lvs_Log)			
	SqlCa.of_Rollback()
	Return lb_Sucesso
End If 	


ll_Linhas = lds_produtos.retrieve(al_filial_origem ,al_nota)

For ll_Linha  = 1 To ll_Linhas 

	ll_Produto 		= lds_produtos.Object.cd_produto			[ll_Linha]
	ll_Qtd 			= lds_produtos.Object.qt_transferida		[ll_Linha]
 	lvs_Especie 		= lds_produtos.Object.de_especie			[ll_Linha]
	lvs_Serie 		=  lds_produtos.Object.de_serie				[ll_Linha]
	ll_Loja 			=  lds_produtos.Object.cd_filial_origem		[ll_Linha]
	ll_Nr_Nf 			=  lds_produtos.Object.nr_nf					[ll_Linha] 
 
	Select  max(nr_sequencial)   + 1 
	Into :ll_Sequencial_Novo
	From wms_localizacao
	///Where  cd_produto=:ll_Produto	
	Using SqlCA;

	If SqlCa.SqlCode = -1 Then
		lb_Sucesso = False
		SqlCa.Of_MsgDbError("Erro ao localizar proximo Sequencial") 
		SqlCa.of_RollBack()
	   	Return lb_Sucesso
	End If

	// Localiza Se existe O Registro
	Select Count(*) , nr_sequencial   , qt_saldo 
	Into :ll_Achou ,  :ll_Sequencial_Existe ,:ll_Qtd_Antes 
	From	wms_localizacao
	Where cd_produto		=:ll_Produto
	And     cd_endereco	=:lvs_Endereco_Mercadoria_Transito
	And 	  nr_lote 			=:lvs_Lote
	And     dh_validade	=:lvs_Data
	And     qt_caixa_padrao =1
	Group by nr_sequencial , qt_saldo 
	Using SqlCA;
	
	Choose Case SqlCa.SqlCode 
	Case -1
		lb_Sucesso = False
		SqlCa.of_RollBack();
		SqlCa.Of_MsgDbError("Erro ao localizar proximo Sequencial") 
		Return lb_Sucesso 
	Case 0
		If ll_Achou > 0  and  ll_Qtd_Antes < ll_Qtd  Then     
			Update	wms_localizacao
			Set		qt_saldo= qt_saldo+:ll_Qtd
			Where cd_produto		=:ll_Produto
			And     cd_endereco	=:lvs_Endereco_Mercadoria_Transito
			And 	  nr_lote 			=:lvs_Lote
			And     dh_validade	=:lvs_Data
			And     qt_caixa_padrao =1
			And     nr_sequencial  =:ll_Sequencial_Existe
			Using SqlCA;
		
			If SqlCa.SqlCode = -1 Then
				lb_Sucesso = False
				SqlCa.Of_MsgDbError("Erro ao atualizar produto") 
				SqlCa.of_RollBack()
				Return lb_Sucesso
			End If
			lvs_TipoAlteracao = "A"
		Else 
			Continue 
		End If 	
	Case 100
		If ll_Achou = 0 Then 
			Insert into wms_localizacao (cd_endereco, nr_sequencial,cd_produto,qt_caixa_padrao,nr_lote,qt_saldo,dh_validade)
			Values (:lvs_Endereco_Mercadoria_Transito,:ll_Sequencial_Novo, :ll_Produto, 1,:lvs_Lote,:ll_Qtd,:lvs_Data)
			Using SqlCA;
			
			If SqlCa.SqlCode = -1 Then
				lb_Sucesso = False
				SqlCa.Of_MsgDbError("Erro ao Insertir produto") 
				SqlCa.of_RollBack()
					Return lb_Sucesso
			End If
			lvs_TipoAlteracao = "I"
		End If 	
	End Choose
	
	///Inclusao de Registros
	If lvs_TipoAlteracao = "I" and ll_Achou  = 0  Then 
		lvs_Chave = String(ll_Loja )+";"+String(ll_Produto)+";"+String(ll_Nr_Nf)+";"+String(ll_Sequencial_Novo)
		// Historico Alteracao	
		If not gf_Grava_Historico_Alteracao_Tabela('WMS_LOCALIZACAO',lvs_Chave, 'QT_SALDO', '0', String(ll_Qtd), lvs_Matricula , lvs_TipoAlteracao ,ref lvs_Log,True) Then
			lb_Sucesso = False
			SqlCa.of_Rollback();
			Return lb_Sucesso
		End If
	ElseIf 	lvs_TipoAlteracao = "A" and (ll_Achou>0 and  ll_Qtd_Antes < ll_Qtd)  Then 
	// Altera$$HEX2$$e700e300$$ENDHEX$$o de Registros	
		lvs_Chave =String(ll_Loja )+";"+String(ll_Produto)+";"+String(ll_Nr_Nf)+";"+String(ll_Sequencial_Existe)
		// Historico Alteracao	
		If not gf_Grava_Historico_Alteracao_Tabela('WMS_LOCALIZACAO',lvs_Chave, 'QT_SALDO', String(ll_Qtd_Antes), String(ll_Qtd), lvs_Matricula , lvs_TipoAlteracao ,ref lvs_Log,True) Then
			lb_Sucesso = False
			SqlCa.of_Rollback();
			Return lb_Sucesso
		End If
	End If 	
	
	If lb_Sucesso Then 
		SqlCa.of_Commit()		
	End If 	
Next 

Destroy (lds_produtos)


//of_inclui_lote_transferencia_transito

//select @validade 	= convert(datetime, '2099/12/31')
//select @lote 		= 'SEM LOTE'

// 1 - Localizar o endereco CD_ENDERECO_SEGREGADO_MERCADORIA_TRANSIT
//2 - Listar os itens da nota com problema
//3 - Pegar o pr$$HEX1$$f300$$ENDHEX$$ximo sequencial
//4 - Inser ou update na WMS_LOCALIZACAO
//5 - Historico


//-- Data: 18/04/2022
//	-- Controle para garantir que o sistema esta gravando a entrada de transferencia no endere$$HEX1$$e700$$ENDHEX$$o em transito (LOJA -> CD)
//	select @achou = coalesce(count(*), 0) 
//	from wms_localizacao 
//	where cd_endereco 	= @endereco
//	  and nr_sequencial = @sequencial
//	  and cd_produto  	= @produto
//	  and nr_lote 		= @lote
//	  and dh_validade   = @validade
//
//	if @@error <> 0
//	begin
//		select @mensagem = 'Erro na LOCALIZACAO do registro na tabela wms_localizacao  - sp_wms_inclui_movimento_me. (' + convert(char(6), @produto) + ')'
//		rollback trigger with raiserror 20000 @mensagem
//		return -1
//	end
//	
//	sE @achou  > 0 
//	UPDATE
//	SEN$$HEX1$$c300$$ENDHEX$$O
//	INSERT

// PEGAR O PROXIMO SEQUENCIAL
//Select top 1 @seqlocalizado = nr_sequencial 
//From wms_localizacao
//Where cd_endereco 		= @endereco
//  and cd_produto 		= @produto
//  and qt_caixa_padrao 	= @caixa_padrao  
//  and nr_lote 			= @lote
//  and dh_validade  		= @validade
//order by nr_sequencial asc
//  
//if @@error <> 0
//begin
//	select @mensagem = 'Erro ao localizar o ultimo sequencial TOP 1. ('  + convert(char(6), @produto) + ')'
//	rollback trigger with raiserror 20000 @mensagem
//	return -1
//end
//
//if @seqlocalizado is not null and @seqlocalizado > 0
//begin
//	select @sequencial = @seqlocalizado
//end
//else
//begin
//	select @sequencial = 0
//							
//	-- Verifica o pr$$HEX1$$f300$$ENDHEX$$ximo sequencial
//	select @sequencial = max(nr_sequencial) 
//	from wms_localizacao
//	where cd_endereco = @endereco
//	
//	if @@error <> 0
//	begin
//		select @mensagem = 'Erro ao localizar o ultimo sequencial do endere$$HEX1$$e700$$ENDHEX$$o (' + @endereco + ').'
//		rollback trigger with raiserror 20000 @mensagem
//		return -1
//	end
//
//	if @sequencial is null or @sequencial = 0 
//		select @sequencial = 1
//	else		
//		select @sequencial = @sequencial + 1
//end

//select i.cd_produto, i.qt_transferida 
//from nf_transferencia n
//inner join item_nf_transferencia i
//	on i.cd_filial_origem = n.cd_filial_origem
//	and i.nr_nf = n.nr_nf
//	and i.de_especie = n.de_especie
//	and i.de_serie = n.de_serie
//where n.dh_movimentacao_caixa >= '20221201'
//  and n.dh_cancelamento is null
//  and n.cd_filial_destino = 1
//   and n.cd_filial_origem = :al_filial_origem
//  and n.nr_nf = :al_nota
//  and not exists (select * from wms_localizacao w
//						where w.cd_produto = i.cd_produto
//						  and w.cd_endereco = 'F910010A')

//gravar historico de altera$$HEX2$$e700e300$$ENDHEX$$o
//gf_grava_historico_alteracao_tabela


end function

public function boolean of_set_mostra_erro_tela (boolean ab_mostra_erro_tela);ib_mostra_erro_tela = ab_mostra_erro_tela

Return True
end function

public function boolean of_buscar_ultima_movimentacao (long al_cd_produto, string as_endereco, string as_tipo_endereco, string as_nr_lote, long al_qt_caixa_padrao, date ad_dh_validade, string as_id_tipo_movimento, string as_nr_matricula, ref long al_nr_movimentacao);String	ls_erro


//Pega o n$$HEX1$$fa00$$ENDHEX$$mero da movimenta$$HEX2$$e700e300$$ENDHEX$$o
if as_tipo_endereco = 'S' then
	select Top 1 nr_movimentacao
	  Into :al_nr_movimentacao
	  from wms_movimentacao
	 where cd_produto 					= :al_cd_produto
		and nr_matricula_responsavel 	= :as_nr_matricula
		and cd_endereco_saida 			= :as_endereco
		and nr_lote							= :as_nr_lote
		and qt_caixa_padrao 				= :al_qt_caixa_padrao
		and dh_validade 					= :ad_dh_validade
		and id_tipo_movimento 			= :as_id_tipo_movimento
	Using SqlCa;
else
	select Top 1 nr_movimentacao
	  Into :al_nr_movimentacao
	  from wms_movimentacao
	 where cd_produto 					= :al_cd_produto
		and nr_matricula_responsavel 	= :as_nr_matricula
		and cd_endereco_entrada			= :as_endereco
		and nr_lote							= :as_nr_lote
		and qt_caixa_padrao 				= :al_qt_caixa_padrao
		and dh_validade 					= :ad_dh_validade
		and id_tipo_movimento 			= :as_id_tipo_movimento
	Using SqlCa;
end if

Choose Case SqlCa.SqlCode
	Case -1
		ls_erro = SqlCa.SQLErrText
		
		SqlCa.of_Rollback()
		
		is_log_erro	= "Erro ao buscar $$HEX1$$fa00$$ENDHEX$$ltima movimenta$$HEX2$$e700e300$$ENDHEX$$o realizada.~r~rErro: " + ls_erro
		
		if ib_mostra_erro_tela then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", is_log_erro)
		end if
		
		Return False
	Case 100
		SqlCa.of_Rollback()
		
		is_log_erro	= "N$$HEX1$$e300$$ENDHEX$$o foi encontrada movimenta$$HEX2$$e700e300$$ENDHEX$$o em aberto para os seguintes dados: ~r~r" + &
						  "Produto: " + String(al_cd_produto) + "~r~r" + &
						  "Lote: " + as_nr_lote + "~r~r" + &
						  "Validade: " + String(ad_dh_validade, 'dd/mm/yyyy') + "~r~r" + &
						  "Caixa Padr$$HEX1$$e300$$ENDHEX$$o: " + String(al_qt_caixa_padrao)
						  
		if ib_mostra_erro_tela then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", is_log_erro)
		end if
						
		Return False
End Choose

Return True
end function

public function boolean of_set_tipo_movto (string as_tipo_movto, ref string as_log);//Possivel altera$$HEX2$$e700e300$$ENDHEX$$o para rastrear melhor as movimenta$$HEX2$$e700f500$$ENDHEX$$es de estoque
Choose Case as_tipo_movto
	Case CIS_TIPO_DESMONTA_KIT
		is_tipo_movto_selecionado	= CIS_TIPO_DESMONTA_KIT
	Case Else
		as_log	= 'Tipo de movimento n$$HEX1$$e300$$ENDHEX$$o encontrado'
		Return False
End Choose

return true
end function

on uo_ge258_movimentacao.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge258_movimentacao.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;SetNull(is_chave_movimento)
end event

