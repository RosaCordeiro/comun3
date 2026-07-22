HA$PBExportHeader$uo_ge473_distrib_produto_reg_info.sru
forward
global type uo_ge473_distrib_produto_reg_info from nonvisualobject
end type
end forward

global type uo_ge473_distrib_produto_reg_info from nonvisualobject
end type
global uo_ge473_distrib_produto_reg_info uo_ge473_distrib_produto_reg_info

type variables
uo_ge473_comum io_Comum

Boolean ib_continue = False



String is_fornecedor_sap,&
		is_produto_sap,&
		is_filial_sap,&
		is_imposto_sap, is_uf, is_cd_distribuidora

Long il_produto_legado, il_filial_legado


String is_chave_sap
				
long il_tabela = 56

end variables

forward prototypes
public function boolean of_valida_dados (ref string as_log)
private function boolean of_inicializa_variaveis (ref string as_log)
public subroutine of_processa_atualizacao ()
public function boolean of_carrega_chave (long al_controle, ref string as_chave_sap, ref string as_log)
public function boolean of_atualiza_reg_info (long al_controle, long al_tabela)
public function boolean of_insere_reg_info (ref string as_log)
end prototypes

public function boolean of_valida_dados (ref string as_log);boolean lb_existe = false
long ll_existe

Try	

	if is_filial_sap = '' or isnull(is_filial_sap) Then
		as_log = 'C$$HEX1$$f300$$ENDHEX$$digo da filial SAP n$$HEX1$$e300$$ENDHEX$$o informado.'
		return false
	end if

	select cd_chave_legado
	into :is_uf
	from integracao_sap
	where cd_tabela = 'FILIAL_REFERENCIA'
	and cd_chave_sap = :is_filial_sap;

	if sqlca.sqlcode = -1 then
		as_log = 'Objeto: ' + this.classname() + '~nM$$HEX1$$e900$$ENDHEX$$todo: of_valida_dados' + '~nErro ao consultar a tabela INTEGRACAO_SAP: ' + sqlca.sqlerrtext
		return false	
	end if

	if is_UF = '' or isnull(is_uf) Then
		as_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar a UF da Filial refer$$HEX1$$ea00$$ENDHEX$$ncia ' + is_filial_sap + '.'
		return false	
	end if
	
	if isnull(is_cd_distribuidora) or is_cd_distribuidora = '' Then
		as_log = 'C$$HEX1$$f300$$ENDHEX$$digo do fornecedor SAP [' + is_fornecedor_sap + '] n$$HEX1$$e300$$ENDHEX$$o encontrado no Sybase.'
		return false
	end if
	
	if isnull(il_produto_legado)  Then
		as_log = 'C$$HEX1$$f300$$ENDHEX$$digo do produto SAP [' + is_produto_sap + '] n$$HEX1$$e300$$ENDHEX$$o encontrado no Sybase.'
		return false
	end if

Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_valida_dados'. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True
end function

private function boolean of_inicializa_variaveis (ref string as_log);Try
	
	setnull(is_imposto_sap)
	setnull(is_fornecedor_sap)
	setnull(is_produto_sap)
	setnull(il_produto_legado)
	setnull(is_filial_sap)
	setnull(is_uf) 
	setnull(is_cd_distribuidora)
	
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
		gvo_aplicacao.of_grava_log("Interface Produto - Erro alterar a DW [ds_ge473_lista_controles] - uo_ge473_distrib_produto_reg_info.of_processa_atualizacao" )
		Return
	End If
	
	ll_Linhas = lds.Retrieve(il_Tabela)
	
	If ll_Linhas > 0 Then
		For ll_Linha = 1 To ll_Linhas
											
			uo_ge473_distrib_produto_reg_info  lo_reg_info
			 
			Try
				lo_reg_info	= Create uo_ge473_distrib_produto_reg_info
				lo_reg_info.of_atualiza_reg_info( lds.Object.nr_controle[ll_Linha] , il_Tabela )
			Finally
				Destroy(lo_reg_info)
			End Try			
			
		Next
	ElseIf ll_Linhas < 0 Then
		gvo_aplicacao.of_grava_log("Interface FornecedorConexao - Erro ao recuperar os da DW [ds_ge473_lista_controles] - uo_ge473_fornecedor_conexao.of_processa_atualizacao.")
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

public function boolean of_atualiza_reg_info (long al_controle, long al_tabela);dc_uo_ds_base lds

Long	ll_Linhas,&
		ll_Linha, ll_registro_pendente
		
String	ls_Log
		
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
	 
	uo_ge473_comum lo_Comum
	lo_Comum = Create uo_ge473_comum
	
	If lo_Comum.of_processa_carrega_dados(al_controle, ref ls_Log) Then
		
		ll_linhas = lo_Comum.ids_lista_registros.RowCount()
		
		if isvalid(w_aguarde_3) Then
			w_aguarde_3.uo_progress_2.of_reset()
			w_aguarde_3.uo_progress_2.of_setmax(ll_linhas)
		end if
		
		For ll_Linha = 1 To ll_linhas
			
			this.of_inicializa_variaveis( ref ls_log )
			
			is_filial_sap = lo_Comum.ids_lista_registros.Object.cd_filial_sap_ref[ll_Linha]
			is_imposto_sap = lo_Comum.ids_lista_registros.Object.cd_imposto_sap[ll_Linha]
			
			is_fornecedor_sap = gf_Tira_Zero_Esquerda(lo_Comum.ids_lista_registros.Object.cd_fornecedor_sap[ll_Linha])
			if isnull(is_fornecedor_sap) Then is_fornecedor_sap = ''
			
			if Not lo_comum.of_localiza_codigo_fornecedor_legado( is_fornecedor_sap, ref is_cd_distribuidora, ref ls_log) Then
				lb_sucesso = false
				Return False	
			end if
			
			is_produto_sap = gf_Tira_Zero_Esquerda(lo_Comum.ids_lista_registros.Object.cd_produto_sap[ll_Linha])
			If IsNull(is_produto_sap) Then is_produto_sap = ''
			
			if Not lo_comum.of_localiza_codigo_produto_legado( is_produto_sap, ref il_produto_legado, ref ls_log) Then
				lb_sucesso = false
				Return False	
			end if
		
			if isvalid(w_aguarde_3) Then
				w_aguarde_3.wf_settext('Produto: ' + String(il_produto_legado), 3 )
			end if
		
			If Not This.of_Valida_Dados(Ref ls_Log) Then
				lb_sucesso = false
				return false
			end if
		
			If Not This.of_insere_reg_info( ref ls_log ) Then
				lb_Sucesso	= False
				return false
			end if
			
			if isvalid(w_aguarde_3) Then
				w_aguarde_3.uo_progress_2.of_setprogress(ll_linha)
			end if
			
		Next
		
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

public function boolean of_insere_reg_info (ref string as_log);long ll_existe

Select Count(*)
into :ll_existe
from distribuidora_produto
	where cd_unidade_federacao = :is_UF
		and cd_produto = :il_produto_legado
		and cd_distribuidora = :is_cd_distribuidora;

if sqlca.sqlcode = -1 then
	as_log = 'Objeto: ' + this.classname() + '~nM$$HEX1$$e900$$ENDHEX$$todo: of_insere_reg_info ~n' + 'Erro ao consultar registro na tabela "DISTRIBUIDORA_PRODUTO": ' + sqlca.sqlerrtext
	return false
end if

if ll_existe = 0 or isnull(ll_existe) Then
	as_log = 'N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ registros na tabela DISTRIBUIDORA_PRODUTO com os par$$HEX1$$e200$$ENDHEX$$metros informados.'
	return false
end if
		
Update distribuidora_produto
	Set cd_imposto_sap = :is_imposto_sap
	where cd_unidade_federacao = :is_UF
		and cd_produto = :il_produto_legado
		and cd_distribuidora = :is_cd_distribuidora;
					
if sqlca.sqlcode = -1 then
	as_log = 'Erro ao atualizar registro na tabela "DISTRIBUIDORA_PRODUTO": ' + sqlca.sqlerrtext
	return false
end if					
		
		
return true
end function

on uo_ge473_distrib_produto_reg_info.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge473_distrib_produto_reg_info.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;io_Comum	= Create uo_ge473_comum


end event

event destructor;Destroy(io_Comum)

end event

