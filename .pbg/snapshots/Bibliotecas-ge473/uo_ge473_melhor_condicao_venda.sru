HA$PBExportHeader$uo_ge473_melhor_condicao_venda.sru
forward
global type uo_ge473_melhor_condicao_venda from nonvisualobject
end type
end forward

global type uo_ge473_melhor_condicao_venda from nonvisualobject
end type
global uo_ge473_melhor_condicao_venda uo_ge473_melhor_condicao_venda

type variables
uo_ge473_comum io_Comum

Boolean ib_continue = False

String is_organizacao_venda,&
		is_produto_sap,&
		is_uf

Long il_produto_legado, il_cd_filial

decimal idc_preco
datetime idh_data_atualizacao

String is_matricula_sap = 'SAP001', is_chave_sap
				
long il_tabela = 64

end variables

forward prototypes
public function boolean of_valida_dados (ref string as_log)
private function boolean of_inicializa_variaveis (ref string as_log)
public subroutine of_processa_atualizacao ()
public function boolean of_carrega_chave (long al_controle, ref string as_chave_sap, ref string as_log)
public function boolean of_busca_fator_conversao (long pl_cd_produto, ref long pl_fator_conversao, ref string ps_log)
public function boolean of_insere_preco_venda (ref string as_log)
public function boolean of_atualiza_melhor_condicao (long al_controle, long al_tabela)
public function boolean of_valida_filial_referencia (string ps_cd_uf, string ps_rede, ref long pl_cd_filial, ref string ps_log)
public function boolean of_excluir_preco_venda (long pl_cd_filial, datetime pdh_data, ref string ps_log)
end prototypes

public function boolean of_valida_dados (ref string as_log);boolean lb_existe = false
long ll_existe

Try	

	If IsNull(is_organizacao_venda) Then
		as_Log	= "Organiza$$HEX2$$e700e300$$ENDHEX$$o Venda n$$HEX1$$e300$$ENDHEX$$o pode ser nulo."
		Return False
	End If	


	If IsNull(is_UF) or Trim(is_UF) = '' Then
		as_Log	= "C$$HEX1$$f300$$ENDHEX$$digo da UF n$$HEX1$$e300$$ENDHEX$$o pode ser nulo."
		Return False
	end if

	Choose Case is_organizacao_venda
			
		Case 'CP00'
			is_organizacao_venda = 'CP'
			
		Case 'DC00'
			is_organizacao_venda = 'DC'
			
		Case 'FA00'
			is_organizacao_venda = 'FA'
			
		Case 'MP00'
			is_organizacao_venda = 'MP'
			
		Case 'PF00'
			is_organizacao_venda = 'PF'
			
		Case 'PP00'
			is_organizacao_venda = 'PP'
			
		Case Else
			
			as_log = "O valor [" + is_organizacao_venda + "] informado para o campo CD_ORGANIZACAO_VENDA n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ v$$HEX1$$e100$$ENDHEX$$lido."	
			return false
			
	End Choose
	
	ib_continue = False 

	if Not of_valida_filial_referencia(is_uf, is_organizacao_venda, ref il_cd_filial, ref as_log) Then return false

	if il_cd_filial = 0 or isnull(il_cd_filial) Then
		as_log = 'N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ filial refer$$HEX1$$ea00$$ENDHEX$$ncia relacianada a UF ['+ is_uf +'] e a rede de vendas [' + is_organizacao_venda + '].'
		return false
	end if

	if il_produto_legado = 0 or isnull(il_produto_legado) Then
		as_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar o produto com o c$$HEX1$$f300$$ENDHEX$$digo SAP [' + is_produto_sap + '].'
		return false
	end if

Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_valida_dados'. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True
end function

private function boolean of_inicializa_variaveis (ref string as_log);Try
	
	setnull(is_organizacao_venda)
	setnull(is_produto_sap)
	setnull(is_uf)
	setnull(idc_preco)
	setnull(il_produto_legado)
	
Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro ao ao iniciar as vari$$HEX1$$e100$$ENDHEX$$veis. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True
end function

public subroutine of_processa_atualizacao ();Long ll_Linhas
Long ll_Linha

dc_uo_ds_base lds 

try 
	
	lds  = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject('ds_ge473_lista_controles', False) Then 
		gvo_aplicacao.of_grava_log("Interface Melhor Condi$$HEX2$$e700e300$$ENDHEX$$o Venda - Erro alterar a DW [ds_ge473_lista_controles] - uo_ge473_melhor_condicao_venda.of_processa_atualizacao" )
		Return
	End If

	ll_Linhas = lds.Retrieve(il_Tabela)
	
	If ll_Linhas > 0 Then
		For ll_Linha = 1 To ll_Linhas
											
			uo_ge473_melhor_condicao_venda  lo_melhor_condicao
			 
			Try
				lo_melhor_condicao	= Create uo_ge473_melhor_condicao_venda
				lo_melhor_condicao.of_atualiza_melhor_condicao( lds.Object.nr_controle[ll_Linha] , il_Tabela )
			Finally
				Destroy(lo_melhor_condicao)
			End Try			
			
		Next
	ElseIf ll_Linhas < 0 Then
		gvo_aplicacao.of_grava_log("Interface Melhor Condi$$HEX2$$e700e300$$ENDHEX$$o Venda - Erro ao recuperar os da DW [ds_ge473_lista_controles] - uo_ge473_melhor_condicao_venda.of_processa_atualizacao.")
	End If	
	
finally
	Destroy lds
end try
end subroutine

public function boolean of_carrega_chave (long al_controle, ref string as_chave_sap, ref string as_log);
select de_chave_sap
into :as_chave_sap
from interface_sap
where nr_controle = :al_controle
Using SQLCA;

if sqlca.sqlcode = -1 then 
	as_log = 'Erro ao consultar a tabela "interface_sap": ' + sqlca.sqlerrtext
	return false
end if

as_chave_sap =  gf_Tira_Zero_Esquerda(as_chave_sap)

return True
end function

public function boolean of_busca_fator_conversao (long pl_cd_produto, ref long pl_fator_conversao, ref string ps_log);select vl_fator_conversao
into :pl_fator_conversao
from produto_geral
where cd_produto = :pl_cd_produto;

if sqlca.sqlcode = -1 then
	ps_log = 'Erro ao consultar a tabela "PRODUTO_GERAL" (of_busca_fator_conversao): ' + sqlca.sqlerrtext
	return false
end if

return true
end function

public function boolean of_insere_preco_venda (ref string as_log);long ll_existe

Select Count(*)
	into :ll_existe
from preco_venda_filial
where cd_produto = :il_produto_legado
	and cd_filial = :il_cd_filial;
		
if sqlca.sqlcode = -1 then
	as_log = 'Erro ao consultar a tabela "PRECO_VENDA_FILIAL": ' + sqlca.sqlerrtext
	return false
end if	

if ll_existe > 0 Then
	
	Update preco_venda_filial
	set vl_preco_liquido = :idc_preco, dh_atualizacao = :idh_data_atualizacao
	where cd_produto = :il_produto_legado
	and cd_filial = :il_cd_filial; 
	
	if sqlca.sqlcode = -1 then
		as_log = 'Erro ao atualizar registro na tabela "PRECO_VENDA_FILIAL": ' + sqlca.sqlerrtext
		return false
	end if	
	
else
	
	Insert into preco_venda_filial(cd_produto, cd_filial, vl_preco_liquido, dh_atualizacao)
	values(:il_produto_legado, :il_cd_filial, :idc_preco, :idh_data_atualizacao);
	
	if sqlca.sqlcode = -1 then
		as_log = 'Erro ao inserir registro na tabela "PRECO_VENDA_FILIAL": ' + sqlca.sqlerrtext
		return false
	end if	
	
end if

Return True
end function

public function boolean of_atualiza_melhor_condicao (long al_controle, long al_tabela);dc_uo_ds_base lds

Long	ll_Linhas,&
		ll_Linha, ll_registro_pendente, ll_fator_conversao
		
String	ls_Log, ls_id_finaliza_promocao

Datetime ldh_Data_Inicio
		
Boolean	lb_Sucesso = True

Try
	
	if Not io_Comum.of_atualizacao_pendente( al_controle, ref ll_registro_pendente, ref ls_log) Then 
		lb_sucesso = false
		return false
	end if
		
	//Controle j$$HEX1$$e100$$ENDHEX$$ foi processado
	If ll_registro_pendente = 0 Then Return True
	
	If Not io_Comum.of_Muda_Situacao_Interface(al_Controle, Ref ls_Log) Then Return False
	
	if Not this.of_carrega_chave( al_controle, ref is_chave_sap, ref ls_log ) Then Return False
	
	/*
	 MELHOR_CONDICAO_VENDA(64)
	*/
	 
	uo_ge473_comum lo_Comum
	lo_Comum = Create uo_ge473_comum
	
	If lo_Comum.of_processa_carrega_dados(al_controle, ref ls_Log) Then
		
		idh_data_atualizacao = gf_getserverdate()
		
		ll_linhas = lo_Comum.ids_lista_registros.RowCount()
		
		if isvalid(w_aguarde_3) Then
			w_aguarde_3.uo_progress_2.of_reset()
			w_aguarde_3.uo_progress_2.of_setmax(ll_linhas)
		end if
		
		For ll_Linha = 1 To ll_linhas
			
			this.of_inicializa_variaveis( ref ls_log )
			
			is_organizacao_venda = lo_Comum.ids_lista_registros.Object.cd_organizacao_venda[ll_Linha]
			is_uf = lo_Comum.ids_lista_registros.Object.cd_uf[ll_Linha]
			
			is_produto_sap = gf_Tira_Zero_Esquerda(lo_Comum.ids_lista_registros.Object.cd_produto_sap[ll_Linha])
			If IsNull(is_produto_sap) Then is_produto_sap = ''
			
			If Not io_Comum.of_Localiza_Codigo_Produto_Legado(is_produto_sap, Ref il_produto_legado, Ref ls_Log) Then 
				lb_sucesso = false
				Return False	
			end if
			
			if isvalid(w_aguarde_3) Then
				w_aguarde_3.wf_settext('Produto: ' + String(il_produto_legado), 3 )
			end if
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vl_preco[ll_Linha], 'PRE$$HEX1$$c700$$ENDHEX$$O', ref idc_preco, ref ls_Log) Then 
				lb_sucesso = false
				Return False
			end if
		
			If Not This.of_Valida_Dados(Ref ls_Log) Then
				lb_sucesso = false
				return false
			end if
			
			If ib_continue Then 
				ib_continue = false
				Continue
			end if
		
			If Not This.of_insere_preco_venda( ref ls_log ) Then
				lb_Sucesso	= False
				return false
			end if
			
			if isvalid(w_aguarde_3) Then
				w_aguarde_3.uo_progress_2.of_setprogress(ll_linha)
			end if
			
		Next
		
		if Not of_excluir_preco_venda(il_cd_filial, idh_data_atualizacao, ref ls_log) Then
			lb_Sucesso	= False
			return false
		end if
		
	Else
		lb_sucesso = false
		Return False
	End If	
	
	Destroy(lo_comum)	
			
Finally
	
	If lb_Sucesso Then
		SqlCa.of_Commit()
	Else
		SqlCA.of_RollBack()
		io_Comum.of_grava_erro(al_controle, 176, ls_Log)
	End If
		
	Destroy(lds)
	Destroy(lo_comum)
	
End Try

Return lb_Sucesso
end function

public function boolean of_valida_filial_referencia (string ps_cd_uf, string ps_rede, ref long pl_cd_filial, ref string ps_log);datetime ldh_inicio

select cd_filial_referencia, dh_inicio_interface_sap
into :pl_cd_filial, :ldh_inicio
from preco_venda_filial_referencia
where id_rede_filial = :ps_rede
	and cd_uf = :ps_cd_uf;
	
if sqlca.sqlcode = -1 then 
	ps_log = 'Problemas ao consultar a tabela "preco_venda_filial_referencia": ' + sqlca.sqlerrtext
	return	 false
end if

if pl_cd_filial > 0 Then
	
	if isnull(ldh_inicio) Then
		
		Update preco_venda_filial_referencia
		set dh_inicio_interface_sap = getdate()
		where id_rede_filial = :ps_rede
			and cd_uf = :ps_cd_uf;
			
		if sqlca.sqlcode = -1 then 
			ps_log = 'Problemas ao atualizar a tabela "preco_venda_filial_referencia": ' + sqlca.sqlerrtext
			return	 false
		end if	
			
	end if
	
end if

return True
end function

public function boolean of_excluir_preco_venda (long pl_cd_filial, datetime pdh_data, ref string ps_log);
Delete from preco_venda_filial
where cd_filial = :pl_cd_filial
and ( dh_atualizacao is null or dh_atualizacao < :pdh_data );

if sqlca.sqlcode = -1 then
	ps_log = 'Problemas ao excluir registros da tabela "preco_venda_filial": ' + Sqlca.sqlerrtext
	return false
end if

Return True
end function

on uo_ge473_melhor_condicao_venda.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge473_melhor_condicao_venda.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;io_Comum	= Create uo_ge473_comum


end event

event destructor;Destroy(io_Comum)

end event

