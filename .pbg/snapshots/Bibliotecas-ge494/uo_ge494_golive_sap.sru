HA$PBExportHeader$uo_ge494_golive_sap.sru
forward
global type uo_ge494_golive_sap from nonvisualobject
end type
end forward

global type uo_ge494_golive_sap from nonvisualobject
end type
global uo_ge494_golive_sap uo_ge494_golive_sap

type variables
uo_transacao_online ivo_Conecta_Odbc
dc_uo_transacao itr_Filial
dc_uo_transacao itr_log
dc_uo_odbc ivo_Odbc
long il_cd_filial
string is_id_rede, is_cd_uf, is_cd_cidade_ibge, is_nr_matricula
dc_uo_ds_base ids_promocao_sap

dc_uo_ds_base idw_log_monitor
boolean ib_log_monitor=false
boolean ib_gerar_log=True
boolean ib_validacao

date idh_parametro
integer il_erros_promo

long il_Promo_legado
long il_Promo_sap
long il_Produto

long il_Qtde_Div_Aceita_Prec_Regular = 100
long il_Qtde_Div_Aceita_Prec_Regular_Futura = 50
long il_Qtde_Div_Aceita_PMC = 310
Long il_Promo_nao_equiv_sap = 6

string is_Valor_Legado
string is_valor_sap
end variables

forward prototypes
public function boolean of_grava_log (string ps_tipo_mov, string ps_ds_mensagem, ref string ps_log)
public function boolean of_alterar_parametro_matriz (ref string ps_log)
public function boolean of_busca_dados_filial (long pl_cd_filial, ref string ps_log)
public function boolean of_incluir_log_preco_uf (ref string ps_log)
public function boolean of_validar_promocao_legado (long pl_cd_promocao_sap, long pl_cd_promocao_legado, ref string ps_log)
public function boolean of_alterar_parametro_loja (ref string ps_log)
public function boolean of_conectar_filial (ref string ps_log)
public function boolean of_incluir_promocao (ref string ps_log)
public function boolean of_incluir_log_est_min (long pl_cd_promocao, ref string ps_log)
public function boolean of_incluir_est_base (ref string ps_log)
public function boolean of_validar_filial (ref string ps_log)
public function boolean of_incluir_promocao_filial (ref string ps_log)
public function boolean of_validar_promocao (ref string ps_log)
public function boolean of_incluir_minimo_promocao (long pl_cd_promocao_legado, ref string ps_log)
public function boolean of_excluir_promocao_antiga (long pl_cd_promocao, ref string ps_log)
public function boolean of_executar (long pl_cd_filial, boolean pb_simulacao, ref string ps_log)
public function boolean of_validar_preco (ref string ps_log)
end prototypes

public function boolean of_grava_log (string ps_tipo_mov, string ps_ds_mensagem, ref string ps_log);string ls_nr_matricula
long ll_linha
datetime ldt_data
long ll_Nulo, ll_file

SetNull(ll_Nulo)

Try

	ldt_data = gf_getserverdate()

	if ib_gerar_log = False Then return True

	ls_nr_matricula = gvo_aplicacao.ivo_seguranca.nr_matricula
	
	insert into log_migracao_filial_sap(cd_filial, id_tipo_movimento, nr_matricula, de_mensagem, dh_movimento, cd_promocao_legado, cd_promocao_sap, cd_produto, de_valor_legado, de_valor_sap)
	values(:il_cd_filial, :ps_tipo_mov, :ls_nr_matricula , :ps_ds_mensagem, :ldt_data, :il_Promo_legado, :il_Promo_sap, :il_Produto, :is_Valor_Legado, :is_valor_sap)
	Using Itr_log;
	
	if Itr_log.sqlcode = -1 then 
		ps_log = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_log ~nProblemas ao inserir registro na tabela "log_migracao_filial_sap": ' + Itr_log.sqlerrtext
		Itr_log.of_rollback()
		return false
	end if
	
	
//	ll_file = FileOpen('D:\Teste\teste1.txt', LineMode!, Write!)
//	FileWriteEx(ll_file, ps_ds_mensagem )
//	FileClose(ll_file)
	
	SetNull(il_Promo_legado)
	SetNull(il_Promo_sap)
	SetNull(il_Produto)
	SetNull(is_Valor_Legado)
	SetNull(is_valor_sap)
		
	Itr_log.of_commit( )

Finally
	
	If ib_log_monitor = True Then
		
		ll_linha = idw_log_monitor.insertrow(0)
		idw_log_monitor.object.ds_texto[ll_linha] = '[' + String(ldt_data, 'dd/mm/yyyy hh:mm') + '] ' + ps_ds_mensagem
		
		w_ge494_monitor_golive_sap.dw_2.object.datawindow.VerticalScrollPosition = w_ge494_monitor_golive_sap.dw_2.object.datawindow.VerticalScrollMaximum
		
	end if
	
End Try

return true

end function

public function boolean of_alterar_parametro_matriz (ref string ps_log);string ls_tp_mov = 'ADM_SAP_MATRIZ'
string ls_data

if Not this.of_grava_log( ls_tp_mov, 'Alterando administra$$HEX2$$e700e300$$ENDHEX$$o da Filial ' + string(il_cd_filial) + ' para o SAP - Base Matriz...', ref ps_log ) Then return false

Update parametro_loja
set vl_parametro = 'S'
where cd_parametro = 'ID_ADM_FILIAL_SAP'
and cd_filial = :il_cd_filial
Using SQLCA;

If sqlca.sqlcode = -1 then
	ps_log = 'Problemas ao alterar registro na tabela "PARAMETRO_LOJA": ' + sqlca.sqlerrtext
	return false
end if

ls_data = String( idh_parametro, 'dd/mm/yyyy')

Update parametro_loja
set vl_parametro = :ls_data
where cd_parametro = 'DH_ADM_FILIAL_SAP'
and cd_filial = :il_cd_filial
Using SQLCA;

If sqlca.sqlcode = -1 then
	ps_log = 'Problemas ao alterar registro na tabela "PARAMETRO_LOJA": ' + sqlca.sqlerrtext
	return false
end if

if Not this.of_grava_log( ls_tp_mov, 'Administrativo da filial ' + string(il_cd_filial) + ' alterado para o SAP com sucesso  - Base Matriz.', ref ps_log ) Then return false

return true
end function

public function boolean of_busca_dados_filial (long pl_cd_filial, ref string ps_log);string ls_tp_mov = 'DADOS_FILIAL'

if Not this.of_grava_log( ls_tp_mov, 'Buscando dados da filial ' + string(il_cd_filial) + '...', ref ps_log ) Then return false

select fi.id_rede_filial, c.cd_unidade_federacao, c.cd_cidade_ibge
into :is_id_rede, :is_cd_uf, :is_cd_cidade_ibge
from filial fi
    inner join cidade c on (c.cd_cidade = fi.cd_cidade)
where cd_filial =:pl_cd_filial
Using SQLCA;

if sqlca.sqlcode = -1 then
	ps_log = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_busca_dados_filial' + '~nProblemas ao consultar a tabela "filial": ' + sqlca.sqlerrtext
	return false
end if

if Not this.of_grava_log( ls_tp_mov, 'Dados da filial ' + string(il_cd_filial) + ' obtidos com sucesso.', ref ps_log ) Then return false

return true
end function

public function boolean of_incluir_log_preco_uf (ref string ps_log);string ls_tp_mov = 'PRECO_REGULAR'

if Not this.of_grava_log( ls_tp_mov, 'Atualizando pre$$HEX1$$e700$$ENDHEX$$o regular referente a UF ' + is_cd_uf + '...', ref ps_log ) Then return false

INSERT INTO log_exportacao_comum ( nm_tabela,
													dh_atualizacao,
													de_chave,
													id_atualizacao)
	select 'PRODUTO_GERAL_UF',
			getdate(),
			u.cd_unidade_federacao + '@#!' + CAST( u.cd_produto AS VARCHAR ),
			'A'
	from produto_uf u
	where u.cd_unidade_federacao = :is_cd_uf
	and (u.vl_preco_venda_maximo_sap is not null or u.vl_preco_venda_atual_sap is not null or u.vl_preco_venda_futuro_sap is not null)
	and not exists (select * 
						from log_exportacao_comum l
						where l.dh_atualizacao >= dateadd(dd, -1, getdate())
							and l.nm_tabela = 'PRODUTO_GERAL_UF'
							and l.de_chave = u.cd_unidade_federacao + '@#!' + CAST( u.cd_produto AS VARCHAR )
							and l.id_processado = 'N' )
Using SQLCA;

if sqlca.sqlcode = -1 then 
	ps_log = 'Objeto: ' + this.classname( ) + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_incluir_log_preco_uf' + '~nProblemas ao inserir registro na tabela "log_exportacao_comum": ~n' + sqlca.sqlerrtext
	return false
end if

if Not this.of_grava_log( ls_tp_mov, 'Pre$$HEX1$$e700$$ENDHEX$$o regular atualizado com sucesso.', ref ps_log ) Then return false

return true
end function

public function boolean of_validar_promocao_legado (long pl_cd_promocao_sap, long pl_cd_promocao_legado, ref string ps_log);long ll_cd_produto, ll_find, ll_linhas, ll_for
string ls_tp_mov = 'VALIDA PROMOCAO'
decimal ldc_pc_desconto
date ldh_dh_vigencia_futuro

dc_uo_ds_base lds_promocao_legado, lds_promocao_sap

if pl_cd_promocao_sap = 0 or isnull(pl_cd_promocao_sap) Then return false
	
lds_promocao_legado = create dc_uo_ds_base
lds_promocao_sap = create dc_uo_ds_base

lds_promocao_sap.of_changedataobject( 'ds_ge494_promocao_produto' )
lds_promocao_legado.of_changedataobject( 'ds_ge494_promocao_produto' )

Try

	lds_promocao_legado.retrieve(pl_cd_promocao_legado)
	
	ll_linhas = lds_promocao_sap.retrieve(pl_cd_promocao_sap)
	
	for ll_for = 1 to ll_linhas
				
		ll_cd_produto     = lds_promocao_sap.object.cd_produto[ll_for]
		ldc_pc_desconto = lds_promocao_sap.object.pc_desconto[ll_for]
		ldh_dh_vigencia_futuro = date(lds_promocao_sap.object.dh_vigencia_futuro[ll_for])
		
		ll_find = lds_promocao_legado.find('cd_produto = ' + string(ll_cd_produto),1,lds_promocao_legado.rowcount( ) )
		
		if ll_find = 0 Then
			
			If ldc_pc_desconto > 0.00 Then		
				il_Promo_legado 	= pl_cd_promocao_legado
				il_Produto			= ll_cd_produto
				ps_log = 'O Produto ' + string(ll_cd_produto) + ' n$$HEX1$$e300$$ENDHEX$$o foi encontrado na promo$$HEX2$$e700e300$$ENDHEX$$o ' + String(pl_cd_promocao_legado)
				if Not this.of_grava_log( ls_tp_mov, ps_log, ref ps_log ) Then return false
			Else
				If Not IsNull(ldh_dh_vigencia_futuro) and ldh_dh_vigencia_futuro >= idh_parametro Then
					ps_log = 'O Produto ' + string(ll_cd_produto) + ' n$$HEX1$$e300$$ENDHEX$$o foi encontrado na promo$$HEX2$$e700e300$$ENDHEX$$o ' + String(pl_cd_promocao_legado)
					il_Promo_legado	= pl_cd_promocao_legado
					il_Produto			= ll_cd_produto
					if Not this.of_grava_log( ls_tp_mov, ps_log, ref ps_log ) Then return false
				End If
			End If		
			
		elseif ll_find > 0 Then
					
			If ll_for = 1 Then
					
				if lds_promocao_sap.object.id_tipo_promocao[ll_for] <> lds_promocao_legado.object.id_tipo_promocao[ll_find] Then
					il_Promo_legado = pl_cd_promocao_legado					  
					il_Promo_SAP = pl_cd_promocao_SAP	
					
					is_Valor_Legado 	= lds_promocao_legado.object.id_tipo_promocao[ll_find]
					is_Valor_SAP 		= lds_promocao_sap.object.id_tipo_promocao[ll_for]
	
						if Not this.of_grava_log( ls_tp_mov, 'Diverg$$HEX1$$ea00$$ENDHEX$$ncia no campo ID_TIPO_PROMOCAO das seguintes promo$$HEX2$$e700f500$$ENDHEX$$es: ;' + string(pl_cd_promocao_sap) + '; ' + string(pl_cd_promocao_legado), ref ps_log ) Then return false
							il_erros_promo ++
				end if
				
				if lds_promocao_sap.object.dh_termino[ll_for] <> lds_promocao_legado.object.dh_termino[ll_find] Then
					il_Promo_legado = pl_cd_promocao_legado					  
					il_Promo_SAP = pl_cd_promocao_SAP	
					
					is_Valor_Legado 	= String(lds_promocao_legado.object.dh_termino[ll_find])
					is_Valor_SAP 		= String(lds_promocao_sap.object.dh_termino[ll_for])
	
					if Not this.of_grava_log( ls_tp_mov, 'Diverg$$HEX1$$ea00$$ENDHEX$$ncia no campo DH_TERMINO das seguintes promo$$HEX2$$e700f500$$ENDHEX$$es: ;' + string(pl_cd_promocao_sap) + '; ' + string(pl_cd_promocao_legado), ref ps_log ) Then return false
					il_erros_promo ++
				end if
				
				if lds_promocao_sap.object.id_filial_altera_estoque[ll_for] <> lds_promocao_legado.object.id_filial_altera_estoque[ll_find] Then
					il_Promo_legado = pl_cd_promocao_legado					  
					il_Promo_SAP = pl_cd_promocao_SAP	
					
					is_Valor_Legado 	= lds_promocao_legado.object.id_filial_altera_estoque[ll_find]
					is_Valor_SAP 		= lds_promocao_sap.object.id_filial_altera_estoque[ll_for]
		
					if Not this.of_grava_log( ls_tp_mov, 'Diverg$$HEX1$$ea00$$ENDHEX$$ncia no campo ID_FILIAL_ALTERA_ESTOQUE das seguintes promo$$HEX2$$e700f500$$ENDHEX$$es: ;' + string(pl_cd_promocao_sap) + '; ' + string(pl_cd_promocao_legado), ref ps_log ) Then return false
					il_erros_promo ++
				end if
				
				if lds_promocao_sap.object.dh_termino_estoque_minimo[ll_for] <> lds_promocao_legado.object.dh_termino_estoque_minimo[ll_find] Then
					il_Promo_legado 	= pl_cd_promocao_legado					  
					il_Promo_SAP 		= pl_cd_promocao_SAP	
		
					is_Valor_Legado 	= String(lds_promocao_legado.object.dh_termino_estoque_minimo[ll_find])
					is_Valor_SAP 		= String(lds_promocao_sap.object.dh_termino_estoque_minimo[ll_for])
	
	
					if Not this.of_grava_log( ls_tp_mov, 'Diverg$$HEX1$$ea00$$ENDHEX$$ncia no campo DH_TERMINO_ESTOQUE_MINIMO das seguintes promo$$HEX2$$e700f500$$ENDHEX$$es: ;' + string(pl_cd_promocao_sap) + '; ' + string(pl_cd_promocao_legado), ref ps_log ) Then return false
					il_erros_promo ++
				end if
			
			End If
			
			if lds_promocao_sap.object.pc_desconto[ll_for] <> lds_promocao_legado.object.pc_desconto[ll_find] Then
				il_Promo_legado 	= pl_cd_promocao_legado					  
				il_Promo_SAP 		= pl_cd_promocao_SAP	
				il_produto			= ll_cd_produto
				
				is_Valor_Legado 	= String(lds_promocao_legado.object.pc_desconto[ll_find])
				is_Valor_SAP 		= String(lds_promocao_sap.object.pc_desconto[ll_for])
	
				if Not this.of_grava_log( ls_tp_mov, 'Diverg$$HEX1$$ea00$$ENDHEX$$ncia no campo PC_DESCONTO nas promo$$HEX2$$e700f500$$ENDHEX$$es: ; ' + string(pl_cd_promocao_sap) + '; ' + string(pl_cd_promocao_legado) + ';' + String(ll_cd_produto), ref ps_log ) Then return false
				il_erros_promo ++
			end if
			
			if lds_promocao_sap.object.pc_desconto_clube[ll_for] <> lds_promocao_legado.object.pc_desconto_clube[ll_find] Then
				il_Promo_legado 	= pl_cd_promocao_legado					  
				il_Promo_SAP 		= pl_cd_promocao_SAP	
				il_produto			= ll_cd_produto
				
				is_Valor_Legado 	= String(lds_promocao_legado.object.pc_desconto_clube[ll_find])
				is_Valor_SAP 		= String(lds_promocao_sap.object.pc_desconto_clube[ll_for])
			
				if Not this.of_grava_log( ls_tp_mov, 'Diverg$$HEX1$$ea00$$ENDHEX$$ncia no campo PC_DESCONTO_CLUBE nas promo$$HEX2$$e700f500$$ENDHEX$$es: ;' + string(pl_cd_promocao_sap) + '; ' + string(pl_cd_promocao_legado) + ';' + String(ll_cd_produto), ref ps_log ) Then return false
				il_erros_promo ++
				If (not ib_validacao) Then Return False
			end if
					
			if lds_promocao_sap.object.pc_desconto_clube_futuro[ll_for] <> lds_promocao_legado.object.pc_desconto_clube_futuro[ll_find] Then
				//	SOMENTE SE A DATA DE VIGENCIA FUTURA FOR MAIOR OU IGUAL A DATA ATUAL
				If date(lds_promocao_legado.object.dh_vigencia_futuro[ll_find]) >= idh_parametro Then
					il_Promo_legado 	= pl_cd_promocao_legado					  
					il_Promo_SAP 		= pl_cd_promocao_SAP	
					il_produto			= ll_cd_produto
					
					is_Valor_Legado 	= String(lds_promocao_legado.object.pc_desconto_clube_futuro[ll_find])
					is_Valor_SAP 		= String(lds_promocao_sap.object.pc_desconto_clube_futuro[ll_for])
					
					if Not this.of_grava_log( ls_tp_mov, 'Diverg$$HEX1$$ea00$$ENDHEX$$ncia no campo PC_DESCONTO_CLUBE_FUTURO nas promo$$HEX2$$e700f500$$ENDHEX$$es: ;' + string(pl_cd_promocao_sap) + '; ' + string(pl_cd_promocao_legado) + ';' + String(ll_cd_produto), ref ps_log ) Then return false
					il_erros_promo ++
				End If
			end if
			
			if lds_promocao_sap.object.cd_desc_progressivo[ll_for] <> lds_promocao_legado.object.cd_desc_progressivo[ll_find] Then
				il_Promo_legado 	= pl_cd_promocao_legado					  
				il_Promo_SAP 		= pl_cd_promocao_SAP	
				il_produto			= ll_cd_produto
				
				is_Valor_Legado 	= STring(lds_promocao_legado.object.cd_desc_progressivo[ll_find])
				is_Valor_SAP 		= String(lds_promocao_sap.object.cd_desc_progressivo[ll_for])
			
				if Not this.of_grava_log( ls_tp_mov, 'Diverg$$HEX1$$ea00$$ENDHEX$$ncia no campo CD_DESC_PROGRESSIVO nas promo$$HEX2$$e700f500$$ENDHEX$$es: ;' + string(pl_cd_promocao_sap) + '; ' + string(pl_cd_promocao_legado) + ';' + String(ll_cd_produto), ref ps_log ) Then return false
				If (not ib_validacao) Then Return False
			end if
			
			if lds_promocao_sap.object.cd_desc_progressivo_clube[ll_for] <> lds_promocao_legado.object.cd_desc_progressivo_clube[ll_find] Then
				il_Promo_legado 	= pl_cd_promocao_legado					  
				il_Promo_SAP 		= pl_cd_promocao_SAP	
				il_produto			= ll_cd_produto
				
				is_Valor_Legado 	= String(lds_promocao_legado.object.cd_desc_progressivo_clube[ll_find])
				is_Valor_SAP 		= STring(lds_promocao_sap.object.cd_desc_progressivo_clube[ll_for])
	
				if Not this.of_grava_log( ls_tp_mov, 'Diverg$$HEX1$$ea00$$ENDHEX$$ncia no campo CD_DESC_PROGRESSIVO_CLUBE nas promo$$HEX2$$e700f500$$ENDHEX$$es: ;' + string(pl_cd_promocao_sap) + '; ' + string(pl_cd_promocao_legado) + ';' + String(ll_cd_produto), ref ps_log ) Then return false
				il_erros_promo ++
			end if
			
			if lds_promocao_sap.object.pc_desconto_futuro[ll_for] <> lds_promocao_legado.object.pc_desconto_futuro[ll_find] Then
				//	SOMENTE SE A DATA DE VIGENCIA FUTURA FOR MAIOR OU IGUAL A DATA ATUAL
				If date(lds_promocao_legado.object.dh_vigencia_futuro[ll_find]) >= idh_parametro Then
					il_Promo_legado 	= pl_cd_promocao_legado					  
					il_Promo_SAP 		= pl_cd_promocao_SAP	
					il_produto			= ll_cd_produto
					
					is_Valor_Legado 	= String(lds_promocao_legado.object.pc_desconto_futuro[ll_find])
					is_Valor_SAP 		= String(lds_promocao_sap.object.pc_desconto_futuro[ll_for])
	
					if Not this.of_grava_log( ls_tp_mov, 'Diverg$$HEX1$$ea00$$ENDHEX$$ncia no campo PC_DESCONTO_FUTURO nas promo$$HEX2$$e700f500$$ENDHEX$$es: ;' + string(pl_cd_promocao_sap) + '; ' + string(pl_cd_promocao_legado) + ';' + String(ll_cd_produto), ref ps_log ) Then return false
					il_erros_promo ++
				End If
			end if
				
			if lds_promocao_sap.object.dh_vigencia_futuro[ll_for] <> lds_promocao_legado.object.dh_vigencia_futuro[ll_find] Then
				il_Promo_legado 	= pl_cd_promocao_legado					  
				il_Promo_SAP 		= pl_cd_promocao_SAP	
				il_produto			= ll_cd_produto
				
				is_Valor_Legado 	= String(lds_promocao_legado.object.dh_vigencia_futuro[ll_find])
				is_Valor_SAP 		= String(lds_promocao_sap.object.dh_vigencia_futuro[ll_for])
	
				//	SOMENTE SE A DATA DE VIGENCIA FUTURA FOR MAIOR OU IGUAL A DATA ATUAL
				If date(lds_promocao_legado.object.dh_vigencia_futuro[ll_find]) >= idh_parametro Then
					if Not this.of_grava_log( ls_tp_mov, 'Diverg$$HEX1$$ea00$$ENDHEX$$ncia no campo DH_VIGENCIA_FUTURO nas promo$$HEX2$$e700f500$$ENDHEX$$es: ;' + string(pl_cd_promocao_sap) + '; ' + string(pl_cd_promocao_legado) + ';' + String(ll_cd_produto) , ref ps_log ) Then return false
					il_erros_promo ++
				End If
			end if
		
		end if
		
	next

Finally
	
	destroy(lds_promocao_legado)
	destroy(lds_promocao_sap)
	
End Try

return true
end function

public function boolean of_alterar_parametro_loja (ref string ps_log);Boolean lb_Conectou = False

String ls_Achou

string ls_tp_mov = 'ADM_SAP_FILIAL'

if Not this.of_grava_log( ls_tp_mov, 'Alterando administra$$HEX2$$e700e300$$ENDHEX$$o da Filial ' + string(il_cd_filial) + ' para o SAP - Base Filial...', ref ps_log ) Then return false

Try

	if Not this.of_conectar_filial( ref ps_log ) then 
	//	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'N$$HEX1$$e300$$ENDHEX$$o foi possivel conectar  no BD da filial ' + string(il_cd_filial))
		Return True
//		return false
	End If
	
	lb_Conectou = True
	
	select vl_parametro
	into :ls_Achou
	from parametro_loja
	where cd_parametro = 'ID_ADM_FILIAL_SAP'
	Using itr_Filial;
	
	Choose Case itr_Filial.SqlCode
		Case 0
			Update parametro_loja
			set vl_parametro = 'S'
			where cd_parametro = 'ID_ADM_FILIAL_SAP'
			Using itr_Filial;
			
			If itr_Filial.sqlcode = -1 then
				ps_log = 'Problemas ao alterar registro na tabela "PARAMETRO_LOJA": ' + itr_Filial.sqlerrtext
				itr_Filial.of_rollback( )
				return false
			end if
		Case 100
			
			  INSERT INTO parametro_loja  ( cd_parametro, vl_parametro )  
  			  VALUES ( 'ID_ADM_FILIAL_SAP',  'S' ) 
			  using itr_Filial;
			  
			  	If itr_Filial.sqlcode = -1 then
					ps_log = 'Problemas incluir o registro na tabela "PARAMETRO_LOJA": ' + itr_Filial.sqlerrtext
					itr_Filial.of_rollback( )
					return false
				end if
				
		Case -1
			ps_log = 'Problemas localizar o "PARAMETRO_LOJA": ' + itr_Filial.sqlerrtext
			itr_Filial.of_rollback( )
			return false
	End Choose
		
	itr_Filial.of_commit( )

Finally

	If lb_Conectou Then
		if itr_filial.of_isconnected( ) Then
			itr_filial.of_disconnect( )
		end if
	End If
	
End Try

return true
end function

public function boolean of_conectar_filial (ref string ps_log);string ls_Odbc

string ls_tp_mov

ls_tp_mov = 'CONEXAO_FILIAL'

if Not this.of_grava_log( ls_tp_mov, 'Testando conex$$HEX1$$e300$$ENDHEX$$o com a filial ' + string(il_cd_filial) + '...', ref ps_log ) Then return false

//Conectar na base da filial
ivo_Conecta_Odbc.of_inclui_odbc( il_cd_Filial )

ls_Odbc = ivo_Odbc.of_Localiza( il_cd_Filial )

If itr_Filial.of_IsConnected( ) Then
	itr_Filial.of_Disconnect( )
End If

if itr_Filial.of_Connect( ls_Odbc, 'TRANSF' ) = False Then
	//ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel estabelecer conex$$HEX1$$e300$$ENDHEX$$o com a Filial ' + string(il_cd_filial) + '.'
	if Not this.of_grava_log( ls_tp_mov, 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel estabelecer conex$$HEX1$$e300$$ENDHEX$$o com a Filial ' + string(il_cd_filial) + '.', ref ps_log ) Then return false
	return false
end if

if Not this.of_grava_log( ls_tp_mov, 'Conex$$HEX1$$e300$$ENDHEX$$o com a filial ' + string(il_cd_filial) + ' efetuada com sucesso.', ref ps_log ) Then return false

return true
end function

public function boolean of_incluir_promocao (ref string ps_log);string ls_tp_mov = 'PROMOCAO'

if Not this.of_grava_log( ls_tp_mov, 'Atualizando promo$$HEX2$$e700f500$$ENDHEX$$es na base da filial...', ref ps_log ) Then return false

INSERT INTO log_exportacao_filial ( cd_filial_atualizacao,
											 	nm_tabela,
												dh_atualizacao,
											 	de_chave,
											 	id_atualizacao )
SELECT  :il_cd_filial,
			'PROMOCAO_SOS',
			getdate(),
			Convert( varchar, ps.cd_promocao_sos),
			'I'
FROM promocao_sos ps
where ps.id_rede_filial = :is_id_rede
  and ( ps.cd_unidade_federacao = :is_cd_uf or ps.cd_cidade_ibge = :is_cd_cidade_ibge )
Using SQLCA;

if sqlca.sqlcode = -1 then
	ps_log = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_incluir_promocao' + '~nProblemas ao inserir registros na tabela "log_exportacao_filial":~n ' + sqlca.sqlerrtext
	return false
end if

if Not this.of_grava_log( ls_tp_mov, 'Promo$$HEX2$$e700f500$$ENDHEX$$es atualizadas com sucesso.', ref ps_log ) Then return false

Return true
end function

public function boolean of_incluir_log_est_min (long pl_cd_promocao, ref string ps_log);string ls_tp_mov = 'ESTOQUE_MINIMO'

//if Not this.of_grava_log( ls_tp_mov, 'Incluindo estoque m$$HEX1$$ed00$$ENDHEX$$nimo...', ref ps_log ) Then return false

insert into log_exportacao_filial ( cd_filial_atualizacao,
										 nm_tabela,
										 dh_atualizacao,
										 de_chave,
										 id_atualizacao)
	select cd_filial,
	 'PROMOCAO_SOS_ESTOQUE_MINIMO',
	 getdate(),
	 convert(varchar, cd_promocao_sos) + '@#!' + convert(char(4), cd_filial) + '@#!' + convert(char(6), cd_produto),
	 'I'
	from promocao_sos_estoque_minimo
	where cd_promocao_sos = :pl_cd_promocao
	 and cd_filial = :il_cd_filial
Using SQLCA;
	 
if sqlca.sqlcode = -1 then
	ps_log = 'Objeto: ' + this.classname( ) + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_incluir_est_min' + '~nProblemas ao inserir registro na tabela "log_exportacao_filial": ~n' + sqlca.sqlerrtext	
	return false
end if

//if Not this.of_grava_log( ls_tp_mov, 'Estoque m$$HEX1$$ed00$$ENDHEX$$nimo inclu$$HEX1$$ed00$$ENDHEX$$do com sucesso.', ref ps_log ) Then return false

return true
end function

public function boolean of_incluir_est_base (ref string ps_log);string ls_tp_mov = 'ESTOQUE_BASE'

if Not this.of_grava_log( ls_tp_mov, 'Incluindo estoque base...', ref ps_log ) Then return false

Update resumo_reposicao_estoque
set id_golive_sap = 'S'
where cd_filial = :il_cd_filial
Using SQLCA;

if sqlca.sqlcode = -1 then 
	ps_log = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_incluir_est_base' + '~nProblemas ao atualizar registro na tabela "resumo_reposicao_estoque": ' + sqlca.sqlerrtext
	return false
end if

if Not this.of_grava_log( ls_tp_mov, 'Estoque base inclu$$HEX1$$ed00$$ENDHEX$$do com sucesso.', ref ps_log ) Then return false

return true
end function

public function boolean of_validar_filial (ref string ps_log);string ls_parametro, ls_tp_mov

ls_tp_mov = 'VALIDACAO_FILIAL'

if Not this.of_grava_log( ls_tp_mov, 'Iniciando valida$$HEX2$$e700e300$$ENDHEX$$o da Filial ' + string(il_cd_filial) + '...', ref ps_log ) Then return false

Select vl_parametro
	into :ls_parametro
from parametro_loja
where cd_parametro = 'ID_ADM_FILIAL_SAP'
	and cd_filial = :il_cd_filial
Using SQLCA;

If SQLCA.sqlcode = -1 then
	ps_log = 'Objeto: ' + this.classname( ) + '~Fun$$HEX2$$e700e300$$ENDHEX$$o: of_validar_filial' + '~Problemas ao consultar a tabela "parametro_loja": ' + SQLCA.sqlerrtext
	return false
end if

If Not ib_validacao Then
	if ls_parametro = 'S' Then
		ps_log = 'A filial ' + String(il_cd_filial) + ' j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ sendo administrada pelo SAP.'
		return false
	end if
End If

if Not this.of_grava_log( ls_tp_mov, 'Filial ' + string(il_cd_filial) + ' v$$HEX1$$e100$$ENDHEX$$lida para executar o processo.', ref ps_log ) Then return false

return true
end function

public function boolean of_incluir_promocao_filial (ref string ps_log);long ll_linhas, ll_for, ll_cd_promocao, ll_cd_promocao_legado, ll_Achou

string ls_tp_mov = 'PROMOCAO_FILIAL'

if Not this.of_grava_log( ls_tp_mov, 'Incluindo filial nas promo$$HEX2$$e700f500$$ENDHEX$$es...', ref ps_log ) Then return false

ll_linhas = ids_promocao_sap.rowcount()

for ll_for = 1 to ll_linhas
	
	ll_cd_promocao = ids_promocao_sap.object.cd_promocao_sos[ll_for]
	ll_cd_promocao_legado = ids_promocao_sap.object.cd_promocao_legado[ll_for]
	
	select cd_promocao_sos
	into :ll_Achou
	from promocao_sos_filial
	where cd_promocao_sos =  :ll_cd_promocao
		and cd_filial = :il_cd_filial
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
		Case 100
			Insert into promocao_sos_filial( cd_promocao_sos, 
											 cd_filial,
											 nr_matricula_alteracao)
			Values ( :ll_cd_promocao, 
						:il_cd_filial,
						:is_nr_matricula )
			Using SqlCa;
	
			if sqlca.sqlcode = -1 then
				ps_log = 'Objeto: ' + this.classname( ) + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_incluir_promocao_filial' + '~nProblemas ao inserir registro na tabela "promocao_sos_filial": ~n' + sqlca.sqlerrtext
				return false
			end if
		Case -1
			ps_log = 'Objeto: ' + this.classname( ) + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_incluir_promocao_filial' + '~nProblemas ao localizar registro na tabela "promocao_sos_filial": ~n' + sqlca.sqlerrtext
			return false
	End Choose
		
	if Not this.of_incluir_minimo_promocao( ll_cd_promocao_legado, ref ps_log ) then return false
	
	if Not this.of_incluir_log_est_min( ll_cd_promocao, ref ps_log ) then return false
	
	if Not this.of_excluir_promocao_antiga( ll_cd_promocao_legado, ref ps_log) then return false
	
next

if Not this.of_grava_log( ls_tp_mov, 'Filial inclu$$HEX1$$ed00$$ENDHEX$$da nas promo$$HEX2$$e700f500$$ENDHEX$$es com sucesso.', ref ps_log ) Then return false

return true
end function

public function boolean of_validar_promocao (ref string ps_log);string ls_id_rede, ls_cd_uf, ls_cidade_ibge
long ll_linhas, ll_for, ll_cd_promocao_legado, ll_linhas2, ll_cd_promocao_sap, ll_existe
string ls_tp_mov = 'VALIDAR_PROMOCAO'

if Not this.of_grava_log( ls_tp_mov, 'Iniciando processo de valida$$HEX2$$e700e300$$ENDHEX$$o das promo$$HEX2$$e700f500$$ENDHEX$$es...', ref ps_log ) Then return false

Select Count(*)
into :ll_existe
From promocao_sos
where cd_unidade_federacao = :is_cd_uf
and id_rede_filial = :is_id_rede
and cd_promocao_sap is not null
and cd_promocao_legado is null
and dh_termino >= :idh_parametro;

If Sqlca.sqlcode = -1 then
	ps_log = 'Objeto: ' + this.classname( ) + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_validar_promocao' + '~nProblemas ao consultar a tabela "promocao_sos": ' + sqlca.sqlerrtext
	return false
end if

if not isnull(ll_existe) and ll_existe > 0 Then
	ps_log = 'Existem promo$$HEX2$$e700f500$$ENDHEX$$es SAP que n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e300$$ENDHEX$$o vinculadas a promo$$HEX2$$e700f500$$ENDHEX$$es do legado - N$$HEX1$$c300$$ENDHEX$$O POSSUI CODIGO DO LEGADO. - ['  + sTRING(ll_existe ) + '].'
	
	if Not this.of_grava_log( ls_tp_mov, ps_log, ref ps_log ) Then return false
	return false
end if

//
Select Count(*)
into :ll_existe
from promocao_sos p
where ((p.dh_inicio <= :idh_parametro and p.dh_termino >= :idh_parametro) or  p.dh_termino >= :idh_parametro)
and exists (select 1
                from promocao_sos_filial f
                where p.cd_promocao_sos = f.cd_promocao_sos
                and f.cd_filial = :il_cd_filial)
and p.cd_promocao_sap is null
and not exists (select 1
				  	from promocao_sos x
				  where x.cd_promocao_legado = p.cd_promocao_sos)
and p.id_tipo_promocao <> 'P' ;

If Sqlca.sqlcode = -1 then
	ps_log = 'Objeto: ' + this.classname( ) + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_validar_promocao' + '~nProblemas ao consultar a tabela "promocao_sos": ' + sqlca.sqlerrtext
	return false
end if 

if not isnull(ll_existe) and ll_existe > 0 Then
	
	If ll_existe > 10 Then
		ps_log = 'Existe promo$$HEX2$$e700e300$$ENDHEX$$o no legado que n$$HEX1$$e300$$ENDHEX$$o possui uma equivalente no SAP - MAIS QUE 10.'
		if Not this.of_grava_log( ls_tp_mov, ps_log, ref ps_log ) Then return false
		return false
	Else
		ps_log = 'Foram encontradas [' + String(ll_existe) + '] promo$$HEX2$$e700f500$$ENDHEX$$es que n$$HEX1$$e300$$ENDHEX$$o existe equivalente no SAP.'
		if Not this.of_grava_log( ls_tp_mov, ps_log, ref ps_log ) Then return false
		
		If ll_Existe >= il_Promo_nao_equiv_sap Then
			If Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ps_log + '~r~rDeseja continuar o processo?', question!, yesno!, 2) = 2 Then
				return false
			end if
		End If
	End If
end if

if il_cd_filial = 149 Then
	il_cd_filial = il_cd_filial
end if

ll_linhas = ids_promocao_sap.retrieve( is_id_rede, is_cd_uf, is_cd_cidade_ibge )

il_erros_promo = 0

for ll_for = 1 to ll_linhas
	
	ll_cd_promocao_sap = ids_promocao_sap.object.cd_promocao_sos[ll_for]
	ll_cd_promocao_legado = ids_promocao_sap.object.cd_promocao_legado[ll_for]
	
	if Not of_validar_promocao_legado(ll_cd_promocao_sap, ll_cd_promocao_legado, ref ps_log) Then return false
	
next

If il_erros_promo> 0 Then
	
	If il_erros_promo > 50 Then
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Foram encontrados mais de 50 erros na valida$$HEX2$$e700e300$$ENDHEX$$o das promo$$HEX2$$e700f500$$ENDHEX$$es. *** PROCESSO ABORTADO ****')
		if Not this.of_grava_log( ls_tp_mov, 'Foram encontrados mais de 50 erros na valida$$HEX2$$e700e300$$ENDHEX$$o das promo$$HEX2$$e700f500$$ENDHEX$$es. *** PROCESSO ABORTADO ****', ref ps_log ) Then return false
		Return False
	End If
	
	if Not this.of_grava_log( ls_tp_mov, 'Promo$$HEX2$$e700f500$$ENDHEX$$es validadas. Registros com erro: ' + String(il_erros_promo), ref ps_log ) Then return false
	
	If Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Promo$$HEX2$$e700f500$$ENDHEX$$es validadas.' + '~rRegistros com erro: ' + String(il_erros_promo) + '.' + '~r~rDeseja continuar o processo?', question!, yesno!, 2) = 2 Then
		return false
	end if
	
Else
	if Not this.of_grava_log( ls_tp_mov, 'Promo$$HEX2$$e700f500$$ENDHEX$$es validadas com sucesso.', ref ps_log ) Then return false
End If

return true
end function

public function boolean of_incluir_minimo_promocao (long pl_cd_promocao_legado, ref string ps_log);string ls_tp_mov = 'MINIMO_PROMOCAO'

//if Not this.of_grava_log( ls_tp_mov, 'Incluindo m$$HEX1$$ed00$$ENDHEX$$nimo de promo$$HEX2$$e700e300$$ENDHEX$$o...', ref ps_log ) Then return false

 INSERT INTO promocao_sos_estoque_minimo
				 ( cd_promocao_sos,
				 cd_filial,
				 cd_produto,
				 qt_estoque_minimo,
				 id_alterado_filial,
				 qt_estoque_minimo_matriz,
				 nr_matricula_alteracao,
				 cd_motivo_alteracao )
 select x.cd_promocao_sos,
		 p.cd_filial,
		 p.cd_produto,
		 p.qt_estoque_minimo,
		 p.id_alterado_filial,
		 p.qt_estoque_minimo_matriz,
		 p.nr_matricula_alteracao,
		 p.cd_motivo_alteracao
from promocao_sos_estoque_minimo p
	inner join promocao_sos x
 		on x.cd_promocao_legado = p.cd_promocao_sos
where p.cd_promocao_sos = :pl_cd_promocao_legado
 and p.cd_filial = :il_cd_filial
 and not exists (select * 
 					 from promocao_sos_estoque_minimo y
					 where y.cd_promocao_sos = x.cd_promocao_sos
					 and y.cd_produto = p.cd_produto
					 and y.cd_filial = p.cd_filial)
Using SQLCA;
					 
If sqlca.sqlcode = -1 then 
	ps_log = 'Problemas ao inserir registro na tabela "promocao_sos_estoque_minimo": ' + sqlca.sqlerrtext
	return false
end if

//if Not this.of_grava_log( ls_tp_mov, 'M$$HEX1$$ed00$$ENDHEX$$nimo de promo$$HEX2$$e700e300$$ENDHEX$$o inclu$$HEX1$$ed00$$ENDHEX$$do com sucesso.', ref ps_log ) Then return false

Return true
end function

public function boolean of_excluir_promocao_antiga (long pl_cd_promocao, ref string ps_log);
delete from promocao_sos_filial
where cd_filial = :il_cd_filial
and cd_promocao_sos = :pl_cd_promocao
Using SQLCA; 
									
If sqlca.sqlcode = -1 then
	ps_log = 'Objeto: ' + this.classname( ) + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_excluir_promocao_antiga' +  '~nProblemas ao excluir registro da tabela "promocao_sos_filial": ' + sqlca.sqlerrtext
	return false
end if

return true
end function

public function boolean of_executar (long pl_cd_filial, boolean pb_simulacao, ref string ps_log);boolean lb_sucesso = false

Try

//	if pb_simulacao = True Then
//		ib_gerar_log = false
//	end if

	SetNull(il_Promo_legado)
	SetNull(il_Promo_sap)
	SetNull(il_Produto)
	SetNull(is_Valor_Legado)
	SetNull(is_valor_sap)

	ib_validacao  = pb_simulacao
	
	idh_parametro = Date(gf_GetServerDate())

	il_cd_filial = pl_cd_filial

	If Not this.of_validar_filial( ref ps_log ) Then Return False

	//Testa conex$$HEX1$$e300$$ENDHEX$$o com a Filial
//	if Not this.of_conectar_filial( ref ps_log ) Then Return False
//	
//	if itr_filial.of_isconnected( ) Then
//		itr_filial.of_disconnect( )
//	End if
	
	//Busca as informa$$HEX2$$e700f500$$ENDHEX$$es da Filial (rede, UF, cidade)
	if Not this.of_busca_dados_filial( pl_cd_filial, ref ps_log ) Then Return False
	
	//Validar Promo$$HEX2$$e700f500$$ENDHEX$$es
	If Not this.of_validar_promocao( ref ps_log ) Then Return False
	
	//Validar Pre$$HEX1$$e700$$ENDHEX$$os
//	If Not this.of_validar_preco( ref ps_log ) Then Return False
	
	//Se estiver executando no modo simula$$HEX2$$e700e300$$ENDHEX$$o, realiza apenas as valida$$HEX2$$e700f500$$ENDHEX$$es.
	If pb_simulacao = True Then
		return true
	end if
	
	//Alterar o par$$HEX1$$e200$$ENDHEX$$metro ID_ADM_FILIAL_SAP na Matriz
	if Not this.of_alterar_parametro_matriz( ref ps_log ) Then Return False
	
	//Gera LOg do Pre$$HEX1$$e700$$ENDHEX$$o Regular
	If Not this.of_incluir_log_preco_uf( ref ps_log ) Then Return False
	
	//Incluir Promo$$HEX2$$e700e300$$ENDHEX$$o na base da Filial
	If Not this.of_incluir_promocao( ref ps_log ) Then Return False
	
	//Incluir Filial nas promo$$HEX2$$e700f500$$ENDHEX$$es
	If Not this.of_incluir_promocao_filial( ref ps_log ) Then Return False
	
//	If il_cd_filial <> 563 Then
//		//Disparar processo de atualiza$$HEX2$$e700e300$$ENDHEX$$o do estoque base
//		If Not this.of_incluir_est_base( ref ps_log ) Then Return false
//	end if
	
	//Alterar o par$$HEX1$$e200$$ENDHEX$$metro ID_ADM_FILIAL_SAP na Filial
	If Not this.of_alterar_parametro_loja( ref ps_log ) Then Return False

	lb_sucesso = True

Finally
	
	if (lb_sucesso) and (not pb_simulacao) Then
		SQLCA.of_commit( )
	else
		SQLCA.of_rollback( )
	end if

End Try

return true
end function

public function boolean of_validar_preco (ref string ps_log);long ll_existe
Date ldt_saldo
String ls_tp_mov= 'VALIDAR_PRECO'

ldt_saldo = Date( '01/' + String(month( idh_parametro ) ) + '/' + String(year( idh_parametro) ) )

if Not this.of_grava_log( ls_tp_mov, 'Iniciando processo de valida$$HEX2$$e700e300$$ENDHEX$$o de pre$$HEX1$$e700$$ENDHEX$$os...', ref ps_log ) Then return false

//VALIDAR O PRECO ATUAL
select Count(*)
into :ll_existe
from produto_uf u
inner join produto_geral g on ( g.cd_produto = u.cd_produto )
where u.cd_unidade_federacao = :is_cd_uf
  and (g.id_situacao = 'A' or (g.id_situacao <> 'A'
  and exists (select * 
  				from saldo_produto s
			  where s.cd_produto = g.cd_produto
				 and s.dh_saldo = :ldt_saldo
			 	 and s.qt_saldo_final > 0)))
  and round(u.vl_preco_venda_atual / vl_fator_conversao, 2) <> round(coalesce(u.vl_preco_venda_atual_sap, 0) / vl_fator_conversao, 2)
  and substring(g.cd_subcategoria, 1,1) <> '5'
  ;

if Sqlca.sqlcode = -1 then
	ps_log = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_validar_preco' + '~nProblemas ao consultar a tabela "produto_uf": ' + sqlca.sqlerrtext
	return false
end if

If ll_existe > 0 Then
	ps_log = 'Encontradas diverg$$HEX1$$ea00$$ENDHEX$$ncias no pre$$HEX1$$e700$$ENDHEX$$o regular dos produtos.' + '~Produtos: ' + String(ll_existe) + '.'
	if Not this.of_grava_log( ls_tp_mov, ps_log, ref ps_log ) Then return false
	
	If ll_existe >= il_Qtde_Div_Aceita_Prec_Regular Then
		If Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ps_log + '~r~rDeseja continuar o processo?', question!, yesno!, 2) = 2 Then
			return false
		end if
	End If
end if

//VALIDAR O PRECO FUTURO, CASO EXISTA
select Count(*)
into :ll_existe
from produto_uf u
inner join produto_geral g on ( g.cd_produto = u.cd_produto )
where u.cd_unidade_federacao = :is_cd_uf
  and (g.id_situacao = 'A' or (g.id_situacao <> 'A'
  and exists (select * 
  				from saldo_produto s
			  where s.cd_produto = g.cd_produto
				 and s.dh_saldo = :ldt_saldo
			 	 and s.qt_saldo_final > 0)))
  and u.dh_preco_venda_futuro  <> u.dh_preco_venda_futuro_sap
  and  u.dh_preco_venda_futuro is not null
  and substring(g.cd_subcategoria, 1,1) <> '5'
	;

if Sqlca.sqlcode = -1 then
	ps_log = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_validar_preco' + '~nProblemas ao consultar a tabela "produto_uf": ' + sqlca.sqlerrtext
	return false
end if

If ll_existe > 0 Then
	ps_log = 'Encontradas diverg$$HEX1$$ea00$$ENDHEX$$ncias data do pre$$HEX1$$e700$$ENDHEX$$o futuro dos produtos.' + '~Produtos: ' + String(ll_existe) + '.'
	if Not this.of_grava_log( ls_tp_mov, ps_log, ref ps_log ) Then return false
	
	If ll_Existe >= il_Qtde_Div_Aceita_Prec_Regular_Futura Then
		If Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ps_log + '~r~rDeseja continuar o processo?', question!, yesno!, 2) = 2 Then
			return false
		end if
	End If
end if

//VALIDAR O PRECO FUTURO, CASO EXISTA preco
select Count(*)
into :ll_existe
from produto_uf u
inner join produto_geral g on ( g.cd_produto = u.cd_produto )
where u.cd_unidade_federacao = :is_cd_uf
  and (g.id_situacao = 'A' or (g.id_situacao <> 'A'
  and exists (select * 
  				from saldo_produto s
			  where s.cd_produto = g.cd_produto
				 and s.dh_saldo = :ldt_saldo
			 	 and s.qt_saldo_final > 0)))
  and round(u.vl_preco_venda_futuro  / vl_fator_conversao, 2) <> round(coalesce(u.vl_preco_venda_futuro_sap, 0) / vl_fator_conversao, 2)
  and  u.vl_preco_venda_futuro is not null
  and substring(g.cd_subcategoria, 1,1) <> '5'
	;

if Sqlca.sqlcode = -1 then
	ps_log = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_validar_preco' + '~nProblemas ao consultar a tabela "produto_uf": ' + sqlca.sqlerrtext
	return false
end if

If ll_existe > 0 Then
	ps_log = 'Encontradas diverg$$HEX1$$ea00$$ENDHEX$$ncias no pre$$HEX1$$e700$$ENDHEX$$o futuro dos produtos.' + '~rProdutos: ' + String(ll_existe) + '.'
	if Not this.of_grava_log( ls_tp_mov, ps_log, ref ps_log ) Then return false
	
	If ll_Existe >= il_Qtde_Div_Aceita_Prec_Regular_Futura Then
		If Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ps_log + '~r~rDeseja continuar o processo?', question!, yesno!, 2) = 2 Then
			return false
		end if
	End If
end if

//VALIDAR O PRECO M$$HEX1$$c100$$ENDHEX$$XIMO
select Count(*)
into :ll_existe
from produto_uf u
inner join produto_geral g on ( g.cd_produto = u.cd_produto )
where u.cd_unidade_federacao = :is_cd_uf
  and (g.id_situacao = 'A' or (g.id_situacao <> 'A'
  and exists (select * 
  				from saldo_produto s
			  where s.cd_produto = g.cd_produto
				 and s.dh_saldo = :ldt_saldo
				 and s.qt_saldo_final > 0)))
  and round(u.vl_preco_venda_maximo  / vl_fator_conversao, 2) <> round(coalesce(u.vl_preco_venda_maximo_sap, 0) / vl_fator_conversao, 2)
  and u.vl_preco_venda_maximo is not null
  and substring(g.cd_subcategoria, 1,1 ) <> '5'
  ;
  
if Sqlca.sqlcode = -1 then
	ps_log = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_validar_preco' + '~nProblemas ao consultar a tabela "produto_uf": ' + sqlca.sqlerrtext
	return false
end if

If ll_existe > 0 Then
	ps_log = 'Encontradas diverg$$HEX1$$ea00$$ENDHEX$$ncias no pre$$HEX1$$e700$$ENDHEX$$o m$$HEX1$$e100$$ENDHEX$$ximo dos produtos.' + '~rProdutos: ' + String(ll_existe) + '.'
	if Not this.of_grava_log( ls_tp_mov, ps_log, ref ps_log ) Then return false
	
	If ll_Existe >= il_Qtde_Div_Aceita_PMC Then
		If Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ps_log + '~r~rDeseja continuar o processo?', question!, yesno!, 2) = 2 Then
			return false
		end if
	End If
end if

////Se houver divergencias, Verificar se o usu$$HEX1$$e100$$ENDHEX$$rio deseja continuar .
//If lb_existe = True Then
//	If Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ps_log + ' Deseja continuar o processo?', question!, yesno!, 2) = 2 Then
//		return false
//	end if
//end if

if Not this.of_grava_log( ls_tp_mov, 'Valida$$HEX2$$e700e300$$ENDHEX$$o de pre$$HEX1$$e700$$ENDHEX$$o realizada com sucesso.', ref ps_log ) Then return false

return true
end function

on uo_ge494_golive_sap.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge494_golive_sap.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;
itr_Filial = create dc_uo_transacao
itr_Filial.ivs_DataBase = 'ANYWHERE'

ivo_Conecta_Odbc = create uo_transacao_online
ivo_Odbc = create dc_uo_odbc

ids_promocao_sap = create dc_uo_ds_base
ids_promocao_sap.of_changedataobject( 'ds_ge494_promocao_sap' )

is_nr_matricula = gvo_aplicacao.ivo_seguranca.nr_matricula

itr_log = create dc_uo_transacao
itr_log.of_SetDataBase(SQLCA.ivs_database)
itr_log.of_connect( SQLCA.database, gvo_aplicacao.ivo_Seguranca.Cd_Sistema + "_" + gvo_aplicacao.of_UserId() )

idw_log_monitor = create dc_uo_ds_base
idw_log_monitor.of_changedataobject( 'dw_ge494_log' )
end event

event destructor;itr_log.of_disconnect( )

destroy(ivo_Conecta_Odbc);
destroy(itr_Filial);
destroy(itr_log);
destroy(ivo_Odbc);
end event

