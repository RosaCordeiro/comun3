HA$PBExportHeader$uo_ge473_lista_tecnica_prd.sru
forward
global type uo_ge473_lista_tecnica_prd from nonvisualobject
end type
end forward

global type uo_ge473_lista_tecnica_prd from nonvisualobject
end type
global uo_ge473_lista_tecnica_prd uo_ge473_lista_tecnica_prd

type variables
uo_ge473_comum io_Comum

Boolean ib_continue = False
String is_cd_componente
String is_cd_um_componente
String is_cd_produto_sap
String is_chave_sap
String is_cd_tipo_apresentacao
String is_de_tipo_apresentacao
String is_de_um_componente
String is_nm_componente
Decimal idc_qt_concentracao
long il_tabela = 67
Long il_cd_produto


long il_cd_promocao
string is_promocao_sap, is_matricula
Datetime idh_inicio, idh_fim, idh_alteracao
dc_uo_ds_base ids_lista_tecnica
end variables

forward prototypes
public function boolean of_valida_dados (ref string as_log)
private function boolean of_inicializa_variaveis (ref string as_log)
public subroutine of_processa_atualizacao ()
public function boolean of_carrega_chave (long al_controle, ref string as_chave_sap, ref string as_log)
public function boolean of_validar_substancia (string ps_cd_componente, string ps_de_componente, ref long pl_cd_substancia, ref string ps_log)
public function boolean of_validar_tipo_concentracao (ref string ps_log)
public function boolean of_validar_unidade_medida (ref string ps_log)
public function boolean of_insere_composicao (ref string as_log)
public function boolean of_atualiza_composicao (long al_controle, long al_tabela)
public function boolean of_excluir_composicao (long pl_cd_produto, ref string ps_log)
end prototypes

public function boolean of_valida_dados (ref string as_log);boolean lb_existe = false
long ll_existe

Try	

	if isnull(is_cd_componente) or is_cd_componente = '' Then
		as_log = 'O campo cd_componente n$$HEX1$$e300$$ENDHEX$$o pode ser nulo.'
		return false
	end if
	
	if isnull(is_cd_produto_sap) or is_cd_produto_sap = '' Then
		as_log = 'O c$$HEX1$$f300$$ENDHEX$$digo do produto SAP n$$HEX1$$e300$$ENDHEX$$o pode ser nulo. '
		return false
	end if
	
	if isnull(is_cd_tipo_apresentacao) or is_cd_tipo_apresentacao = '' Then
		as_log = 'O tipo de apresenta$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o pode ser nulo. '
		return false
	end if
	
	if isnull(is_cd_um_componente) or is_cd_um_componente = '' Then
		as_log = 'O c$$HEX1$$f300$$ENDHEX$$digo da unidade medida do componente n$$HEX1$$e300$$ENDHEX$$o pode ser nulo.'
		return false
	end if
	
	if isnull(is_de_tipo_apresentacao) or is_de_tipo_apresentacao = '' Then
		as_log = 'A descri$$HEX2$$e700e300$$ENDHEX$$o do tipo apresenta$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o pode ser nula.'
		return false
	end if
	
	if isnull(is_de_um_componente) or is_de_um_componente = '' Then
		as_log = 'A descri$$HEX2$$e700e300$$ENDHEX$$o da unidade medida do componente n$$HEX1$$e300$$ENDHEX$$o pode ser nula.'
		return false
	end if
	
	if isnull(is_nm_componente) or is_nm_componente = '' Then
		as_log = 'O nome do componente n$$HEX1$$e300$$ENDHEX$$o pode ser nulo.'
		return false
	end if
	
Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_valida_dados'. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True
end function

private function boolean of_inicializa_variaveis (ref string as_log);Try

	setnull(is_cd_componente)
	setnull(is_cd_produto_sap)
	setnull(il_cd_produto)
	setnull(is_cd_tipo_apresentacao)
	setnull(is_cd_um_componente)
	setnull(is_de_tipo_apresentacao)
	setnull(is_de_um_componente)
	setnull(is_nm_componente)
	setnull(idc_qt_concentracao)
	
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
		gvo_aplicacao.of_grava_log("Interface Lista t$$HEX1$$e900$$ENDHEX$$cnica prd - Erro alterar a DW [ds_ge473_lista_controles] - uo_ge473_lista_tecnica_prd.of_processa_atualizacao" )
		Return
	End If
	
	ll_Linhas = lds.Retrieve(il_Tabela)
	
	If ll_Linhas > 0 Then
		For ll_Linha = 1 To ll_Linhas
											
			uo_ge473_lista_tecnica_prd lo_busca_facil
			 
			Try
				lo_busca_facil	= Create uo_ge473_lista_tecnica_prd
				lo_busca_facil.of_atualiza_composicao( lds.Object.nr_controle[ll_Linha] , il_Tabela )
			Finally
				Destroy(lo_busca_facil)
			End Try			
			
		Next
	ElseIf ll_Linhas < 0 Then
		gvo_aplicacao.of_grava_log("Interface Lista t$$HEX1$$e900$$ENDHEX$$cnica prd - Erro ao recuperar os da DW [ds_ge473_lista_controles] - uo_ge473_lista_tecnica_prd.of_processa_atualizacao.")
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

public function boolean of_validar_substancia (string ps_cd_componente, string ps_de_componente, ref long pl_cd_substancia, ref string ps_log);long ll_cd_substancia
string ls_descricao

select cd_substancia, de_substancia
into :ll_cd_substancia, :ls_descricao
from substancia_produto
where cd_produto_sap = :ps_cd_componente;

if sqlca.sqlcode = -1 then
	ps_log = 'Problemas ao consultar a tabela "substancia_produto": ' + sqlca.sqlerrtext
	return false
end if

if ll_cd_substancia = 0 or isnull(ll_cd_substancia) Then
	
	Select max(cd_substancia)
	into :ll_cd_substancia
	from substancia_produto;
	
	if sqlca.sqlcode = -1 then
		ps_log = 'Problemas ao consultar a tabela "substancia_produto": ' + sqlca.sqlerrtext
		return false
	end if
	
	if isnull(ll_cd_substancia) or ll_cd_substancia = 0 Then
		ll_cd_substancia = 1
	else
		ll_cd_substancia++
	end if
	
	Insert into substancia_produto(cd_substancia, de_substancia, cd_produto_sap)
	Values( :ll_cd_substancia, :ps_de_componente, :ps_cd_componente);

	if sqlca.sqlcode = -1 then
		ps_log = 'Problemas ao inserir registro na tabela "substancia_produto": ' + sqlca.sqlerrtext
		return false
	end if
	
Elseif ls_descricao <> ps_de_componente Then
	
	//Se j$$HEX1$$e100$$ENDHEX$$ existir atualiza a descri$$HEX2$$e700e300$$ENDHEX$$o (pode haver altera$$HEX2$$e700e300$$ENDHEX$$o de descri$$HEX2$$e700e300$$ENDHEX$$o no SAP).
	Update substancia_produto
	set de_substancia = :ps_de_componente
	where cd_substancia = :ll_cd_substancia;
	
	if sqlca.sqlcode = -1 then
		ps_log = 'Problemas ao atualizar registro na tabela "substancia_produto": ' + sqlca.sqlerrtext
		return false
	end if
	
end if

pl_cd_substancia = ll_cd_substancia

return true
end function

public function boolean of_validar_tipo_concentracao (ref string ps_log);long ll_existe

Select count(*)
	into :ll_existe
from tipo_concentracao
where cd_tipo_concentracao = :is_cd_tipo_apresentacao;

if sqlca.sqlcode = -1 then
	ps_log = 'Problemas ao consultar a tabela "TIPO_CONCENTRACAO": ' + sqlca.sqlerrtext
	return false
end if

if ll_existe = 0 or isnull(ll_existe) Then
	
	Insert into tipo_concentracao(cd_tipo_concentracao, de_tipo_concentracao)
	values( :is_cd_tipo_apresentacao, :is_de_tipo_apresentacao );
	
	if sqlca.sqlcode = -1 then
		ps_log = 'Problemas ao inserir registro na tabela "TIPO_CONCENTRACAO": ' + sqlca.sqlerrtext
		return false
	end if
else
	update tipo_concentracao
		set de_tipo_concentracao = :is_de_tipo_apresentacao
	 where cd_tipo_concentracao = :is_cd_tipo_apresentacao;

	if sqlca.sqlcode = -1 then
		ps_log = 'Problemas ao atualizar registro na tabela "TIPO_CONCENTRACAO": ' + sqlca.sqlerrtext
		return false
	end if
end if

return true
end function

public function boolean of_validar_unidade_medida (ref string ps_log);long ll_existe

Select count(*)
	into :ll_existe
from unidade_medida
where cd_unidade_medida = :is_cd_um_componente;

if sqlca.sqlcode = -1 then
	ps_log = 'Problemas ao consultar a tabela "UNIDADE_MEDIDA": ' + sqlca.sqlerrtext
	return false
end if

if ll_existe = 0 or isnull(ll_existe) Then
	
	Insert into unidade_medida(cd_unidade_medida, de_unidade_medida)
	values( :is_cd_um_componente, :is_de_um_componente );
	
	if sqlca.sqlcode = -1 then
		ps_log = 'Problemas ao inserir registro na tabela "UNIDADE_MEDIDA": ' + sqlca.sqlerrtext
		return false
	end if
	
end if

return true
end function

public function boolean of_insere_composicao (ref string as_log);long ll_cd_substancia, ll_find
string ls_log

if Not this.of_validar_substancia( is_cd_componente, is_nm_componente, ref ll_cd_substancia, ref ls_log ) Then return false

//Verifica se a substancia j$$HEX1$$e100$$ENDHEX$$ existe na lista gravada no banco.
ll_find = ids_lista_tecnica.find('cd_substancia = ' + string(ll_cd_substancia) + ' and qt_concentracao = dec("' + String(idc_qt_concentracao) + '") and cd_unidade_medida = "' + is_cd_um_componente + '"', 1, ids_lista_tecnica.rowcount( ) )
		
if ll_find > 0 Then
	//Se a substancia j$$HEX1$$e100$$ENDHEX$$ existe na lista do produto exclui a linha da datastore.
	//Ao final do processo permanecer$$HEX1$$e300$$ENDHEX$$o na datastore apenas as substancias que existem no sybase mas n$$HEX1$$e300$$ENDHEX$$o existem no SAP (as que devem ser excluidas).
	ids_lista_tecnica.deleterow( ll_find )
end if

//N$$HEX1$$e300$$ENDHEX$$o encontrou o registro no banco: Insert
if ll_find = 0 or isnull(ll_find) Then
	
	If not this.of_validar_tipo_concentracao( ref as_log ) Then return false
	
	If not this.of_validar_unidade_medida( ref as_log ) Then return false
	
	Insert into composicao_produto(cd_produto, cd_substancia, qt_concentracao, cd_tipo_concentracao, cd_unidade_medida)
	values( :il_cd_produto, :ll_cd_substancia, :idc_qt_concentracao, :is_cd_tipo_apresentacao, :is_cd_um_componente );
	
	if sqlca.sqlcode = -1 then
		as_log = 'Objeto: ' + this.classname() + '~nM$$HEX1$$e900$$ENDHEX$$todo: of_insere_composicao ~n' + 'Erro ao inserir registro na tabela "COMPOSICAO_PRODUTO": ' + sqlca.sqlerrtext
		return false
	end if
	
//Encontrou o registro no banco: Update	
else
	
	If not this.of_validar_tipo_concentracao( ref as_log ) Then return false
	
	If not this.of_validar_unidade_medida( ref as_log ) Then return false
	
	Update composicao_produto
	set cd_tipo_concentracao = :is_cd_tipo_apresentacao
	where cd_produto = :il_cd_produto
	and cd_substancia = :ll_cd_substancia
	and qt_concentracao = :idc_qt_concentracao
	and cd_unidade_medida = :is_cd_um_componente;	
	
	if sqlca.sqlcode = -1 then
		as_log = 'Objeto: ' + this.classname() + '~nM$$HEX1$$e900$$ENDHEX$$todo: of_insere_composicao ~n' + 'Erro ao atualizar registro na tabela "COMPOSICAO_PRODUTO": ' + sqlca.sqlerrtext
		return false
	end if
	
end if
		
return true
end function

public function boolean of_atualiza_composicao (long al_controle, long al_tabela);dc_uo_ds_base lds
Long	ll_Linhas,&
		ll_Linha, ll_registro_pendente
		
String	ls_Log
String ls_inicio, ls_fim, ls_alteracao
Boolean	lb_Sucesso = True		

Try
	
	ids_lista_tecnica = create dc_uo_ds_base
	
	ids_lista_tecnica.of_changedataobject( 'ds_ge473_composicao_produto' )
	
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
		
		if ll_linhas > 0 Then
		
			For ll_Linha = 1 To ll_linhas
				
				this.of_inicializa_variaveis( ref ls_log )
			
				is_cd_componente = gf_Tira_Zero_Esquerda(lo_Comum.ids_lista_registros.object.cd_componente[ll_linha])
				
				is_cd_produto_sap = gf_Tira_Zero_Esquerda(lo_Comum.ids_lista_registros.object.cd_produto_sap[ll_linha])
				
				if isnull(is_cd_componente) and isnull(is_cd_produto_sap) Then
					//Quando os campos vierem nulo $$HEX1$$e900$$ENDHEX$$ porque deve excluir os registros relacionado ao produto vindo na chave.
			
					is_cd_produto_sap = gf_Tira_Zero_Esquerda(is_chave_sap)
						
					If IsNull(is_cd_produto_sap) Then is_cd_produto_sap = ''
					
					If Not io_Comum.of_Localiza_Codigo_Produto_Legado(is_cd_produto_sap, Ref il_cd_produto, Ref ls_Log) Then 
						lb_sucesso = false
						Return False	
					end if
					
					if il_cd_produto > 0 then
						
						//Excluir as substancias que existem no Sybase mas j$$HEX1$$e100$$ENDHEX$$ n$$HEX1$$e300$$ENDHEX$$o existem no SAP.
						If Not This.of_excluir_composicao( il_cd_produto, ref ls_log ) Then
							lb_sucesso = false
							return false
						end if
						
						Return True
						
					end if
					
				end if
				
				If IsNull(is_cd_produto_sap) Then is_cd_produto_sap = ''
				
				If Not io_Comum.of_Localiza_Codigo_Produto_Legado(is_cd_produto_sap, Ref il_cd_produto, Ref ls_Log) Then 
					lb_sucesso = false
					Return False	
				end if
	
				if isvalid(w_aguarde_3) Then
					w_aguarde_3.wf_settext('Produto: ' + String(il_cd_produto), 3 )
					w_aguarde_3.wf_settext('Subst$$HEX1$$e200$$ENDHEX$$ncia: ' + String(is_cd_componente), 4 )
				end if
	
				is_cd_tipo_apresentacao = lo_Comum.ids_lista_registros.object.cd_tipo_apresentacao[ll_linha]
				is_cd_um_componente = lo_Comum.ids_lista_registros.object.cd_um_componente[ll_linha]
				is_de_tipo_apresentacao = lo_Comum.ids_lista_registros.object.de_tipo_apresentacao[ll_linha]
				is_de_um_componente = lo_Comum.ids_lista_registros.object.de_um_componente[ll_linha]
				is_nm_componente = lo_Comum.ids_lista_registros.object.nm_componente[ll_linha]
				
				If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.qt_concentracao[ll_Linha], 'QT_CONCENTRACAO', ref idc_qt_concentracao, ref ls_Log) Then 
					lb_sucesso = false
					Return False
				end if
				
				If Not This.of_Valida_Dados(Ref ls_Log) Then
					lb_sucesso = false
					return false
				end if
			
				if ll_linha = 1 Then
					
					//Busca a lista de substancias relacionadas ao produto.
					if ids_lista_tecnica.retrieve( il_cd_produto ) = -1 then
						ls_log = 'Problemas ao consultar a lista de subst$$HEX1$$e200$$ENDHEX$$ncias relacionados ao seguinte produto: ' + string(il_cd_produto)
						lb_sucesso = false
						return false
					end if
					
				end if
			
				If Not This.of_insere_composicao( ref ls_log ) Then
					lb_Sucesso	= False
					return false
				end if
				
				if isvalid(w_aguarde_3) Then
					w_aguarde_3.uo_progress_2.of_setprogress(ll_linha)
				end if
				
			Next
			
			//Excluir as substancias que existem no Sybase mas j$$HEX1$$e100$$ENDHEX$$ n$$HEX1$$e300$$ENDHEX$$o existem no SAP.
			If Not This.of_excluir_composicao( 0, ref ls_log ) Then
				lb_sucesso = false
				return false
			end if
			
		end if
		
	Else
		lb_sucesso = false
		Return False
	End If	
			
Finally
	
	If lb_Sucesso Then
		SqlCa.of_Commit()
	Else
		SqlCA.of_RollBack()
		io_Comum.of_grava_erro(al_controle, 179, ls_Log)
	End If
		
	Destroy(lds)
	Destroy(lo_comum)
	Destroy(ids_lista_tecnica)
	
End Try

Return lb_Sucesso
end function

public function boolean of_excluir_composicao (long pl_cd_produto, ref string ps_log);long ll_cd_produto, ll_cd_substancia, ll_for
decimal ldc_qt_concentracao
string ls_cd_unidade_medida

if pl_cd_produto > 0 Then
	//Exclui todos os registros relacionados ao produto.
	delete from composicao_produto
	where cd_produto = :pl_cd_produto;
	
	If sqlca.sqlcode = -1 then
		ps_log = 'Objeto: ' + this.classname() + 'M$$HEX1$$e900$$ENDHEX$$todo: of_excluir_composicao~nProblemas ao excluir registro da tabela "COMPOSICAO_PRODUTO": ' + sqlca.sqlerrtext
		return false
	end if
	
else

	//Os registros que permaneceram na datastore s$$HEX1$$e300$$ENDHEX$$o os que existem no Sybase mas n$$HEX1$$e300$$ENDHEX$$o vieram no XML do SAP. Portanto devem ser excluidos.
	
	for ll_for = 1 to ids_lista_tecnica.rowcount()
		
		ll_cd_produto = ids_lista_tecnica.object.cd_produto[ll_for] 
		ll_cd_substancia = ids_lista_tecnica.object.cd_substancia[ll_for]
		ldc_qt_concentracao = ids_lista_tecnica.object.qt_concentracao[ll_for]
		ls_cd_unidade_medida = ids_lista_tecnica.object.cd_unidade_medida[ll_for]
		
		if ll_cd_produto > 0 and ll_cd_substancia > 0 Then
			
			delete from composicao_produto
			where cd_produto = :ll_cd_produto
			and cd_substancia = :ll_cd_substancia
			and qt_concentracao = :ldc_qt_concentracao
			and cd_unidade_medida = :ls_cd_unidade_medida;
			
			If sqlca.sqlcode = -1 then
				ps_log = 'Objeto: ' + this.classname() + 'M$$HEX1$$e900$$ENDHEX$$todo: of_excluir_composicao~nProblemas ao excluir registro da tabela "COMPOSICAO_PRODUTO": ' + sqlca.sqlerrtext
				return false
			end if
			
		end if
		
	Next

end if

return true
end function

on uo_ge473_lista_tecnica_prd.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge473_lista_tecnica_prd.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;io_Comum	= Create uo_ge473_comum


end event

event destructor;Destroy(io_Comum)

end event

