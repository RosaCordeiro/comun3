HA$PBExportHeader$uo_ge473_lista_tecnica_prd_agrup.sru
forward
global type uo_ge473_lista_tecnica_prd_agrup from nonvisualobject
end type
end forward

global type uo_ge473_lista_tecnica_prd_agrup from nonvisualobject
end type
global uo_ge473_lista_tecnica_prd_agrup uo_ge473_lista_tecnica_prd_agrup

type variables
uo_ge473_comum io_Comum

Boolean ib_continue = False
String is_cd_produto_sap
String is_chave_sap
long il_tabela = 68
Long il_cd_produto
long il_cd_agrupamento
String is_excluir_agrupamento

dc_uo_ds_base ids_lista_agrup

end variables

forward prototypes
public function boolean of_valida_dados (ref string as_log)
private function boolean of_inicializa_variaveis (ref string as_log)
public subroutine of_processa_atualizacao ()
public function boolean of_carrega_chave (long al_controle, ref string as_chave_sap, ref string as_log)
public function boolean of_atualiza_agrupamento (long al_controle, long al_tabela)
public function boolean of_insere_agrupamento (ref string as_log)
public function boolean of_excluir_agrupamento_prod (ref string ps_log)
public function boolean of_excluir_agrupamento (long pl_cd_agrupamento, ref string ps_log)
end prototypes

public function boolean of_valida_dados (ref string as_log);boolean lb_existe = false
long ll_existe, ll_cd_agrup

Try	

	if isnull(is_chave_sap) or is_chave_sap = '' Then
		as_log = 'O campo chave deve ser informado.'
		return false
	end if
	
	if isnull(il_cd_agrupamento) or il_cd_agrupamento = 0 Then
		as_log = 'O agrupamento n$$HEX1$$e300$$ENDHEX$$o pode ser nulo.'
		return false
	end if
	
	if isnull(is_cd_produto_sap) or is_cd_produto_sap = '' Then
		as_log = 'O c$$HEX1$$f300$$ENDHEX$$digo do produto SAP n$$HEX1$$e300$$ENDHEX$$o pode ser nulo. '
		return false
	end if
	
	if isnull(il_cd_produto) or il_cd_produto = 0 Then
		as_log = 'O produto SAP ' + is_cd_produto_sap + ' n$$HEX1$$e300$$ENDHEX$$o foi encontrado.'
		return false
	end if
	
	if is_excluir_agrupamento = 'X' Then
		
		ll_cd_agrup = long(is_chave_sap)
		
		Select Count(*)
		into :ll_existe
		from lista_tecnica_prd_agrup
		where cd_agrupamento = :ll_cd_agrup;
		
		if sqlca.sqlcode = -1 then
			as_log = 'Objeto: ' + this.classname( ) + '~nM$$HEX1$$e900$$ENDHEX$$todo: of_valida_dados' + '~nErro ao consultar a tabela "lista_tecnica_prd_agrup": ' + sqlca.sqlerrtext
			return false
		end if
		
		if ll_existe = 0 or isnull(ll_existe) Then
			as_log = 'O agrupamento ' + is_chave_sap + ' n$$HEX1$$e300$$ENDHEX$$o foi encontrado. N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel realizar a exclus$$HEX1$$e300$$ENDHEX$$o.'
			return false
		end if
		
	end if
	
Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_valida_dados'. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True
end function

private function boolean of_inicializa_variaveis (ref string as_log);Try

	setnull(il_cd_agrupamento)
	setnull(is_cd_produto_sap)
	setnull(il_cd_produto)
	
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
		gvo_aplicacao.of_grava_log("Interface lista_tecnica_prd_agrup - Erro alterar a DW [ds_ge473_lista_controles] - uo_ge473_lista_tecnica_prd_agrup.of_processa_atualizacao" )
		Return
	End If
	
	ll_Linhas = lds.Retrieve(il_Tabela)
	
	If ll_Linhas > 0 Then
		For ll_Linha = 1 To ll_Linhas
											
			uo_ge473_lista_tecnica_prd_agrup lo_lista
			 
			Try
				lo_lista	= Create uo_ge473_lista_tecnica_prd_agrup
				lo_lista.of_atualiza_agrupamento( lds.Object.nr_controle[ll_Linha] , il_Tabela )
			Finally
				Destroy(lo_lista)
			End Try			
			
		Next
	ElseIf ll_Linhas < 0 Then
		gvo_aplicacao.of_grava_log("Interface lista_tecnica_prd_agrup - Erro ao recuperar os da DW [ds_ge473_lista_controles] - uo_ge473_lista_tecnica_prd_agrup.of_processa_atualizacao.")
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

public function boolean of_atualiza_agrupamento (long al_controle, long al_tabela);Long	ll_Linhas,&
		ll_Linha, ll_registro_pendente
		
String	ls_Log
String ls_inicio, ls_fim, ls_alteracao, ls_id_eliminado
Boolean lb_Sucesso = True		

Try
	
	if Not io_Comum.of_atualizacao_pendente( al_controle, ref ll_registro_pendente, ref ls_log) Then 
		lb_sucesso = false
		return false
	end if
		
	ids_lista_agrup = create 	dc_uo_ds_base	
	ids_lista_agrup.of_changedataobject( 'ds_ge473_lista_tecnica_agrupamento' )	
		
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
		
			il_cd_agrupamento = long(gf_Tira_Zero_Esquerda(lo_Comum.ids_lista_registros.object.cd_agrupamento[ll_linha]))
		
			is_excluir_agrupamento = lo_Comum.ids_lista_registros.object.id_eliminado[ll_linha]
		
			if ll_linha = 1 then
				
				if ids_lista_agrup.retrieve( il_cd_agrupamento ) < 0 Then
					ls_log = 'Problemas ao consultar a lista de produtos relacionados ao seguinte Agrupamento: ' + string(il_cd_agrupamento)
					lb_sucesso = false
					return false
				end if
				
			end if
			
			is_cd_produto_sap = gf_Tira_Zero_Esquerda(lo_Comum.ids_lista_registros.object.cd_produto_sap[ll_linha])
			
			If IsNull(is_cd_produto_sap) Then is_cd_produto_sap = ''
			
			If Not io_Comum.of_Localiza_Codigo_Produto_Legado(is_cd_produto_sap, Ref il_cd_produto, Ref ls_Log) Then 
				lb_sucesso = false
				Return False	
			end if
			
			if isvalid(w_aguarde_3) Then
				w_aguarde_3.wf_settext('Produto: ' + String(il_cd_produto), 3 )
			end if
			
			If Not This.of_Valida_Dados(Ref ls_Log) Then
				lb_sucesso = false
				return false
			end if
		
			//Excluir o agrupamento (da tag Chave) quando id_eliminado = 'X'
			if is_excluir_agrupamento = 'X' Then
				
				il_cd_agrupamento = long(is_chave_sap)
				
				if Not this.of_excluir_agrupamento( il_cd_agrupamento, ref ls_log) Then 
					lb_sucesso = false
					return false
				end if
				
				Exit
			end if
		
			If Not This.of_insere_agrupamento( ref ls_log ) Then
				lb_Sucesso	= False
				return false
			end if
			
			if isvalid(w_aguarde_3) Then
				w_aguarde_3.uo_progress_2.of_setprogress(ll_linha)
			end if
			
		Next
		
		If is_excluir_agrupamento = '' or isnull(is_excluir_agrupamento) Then
		
			If Not this.of_excluir_agrupamento_prod( ref ls_log ) Then
				lb_Sucesso	= False
				return false
			end if
			
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
		io_Comum.of_grava_erro(al_controle, 179, ls_Log)
	End If
		
	Destroy(ids_lista_agrup)
	Destroy(lo_comum)
	
End Try

Return lb_Sucesso
end function

public function boolean of_insere_agrupamento (ref string as_log);long ll_existe, ll_find
string ls_log

//Verifica se o produto j$$HEX1$$e100$$ENDHEX$$ existe no agrupamento.
ll_existe = ids_lista_agrup.find('cd_produto = ' + string(il_cd_produto) + ' and cd_agrupamento = ' + string(il_cd_agrupamento) , 1, ids_lista_agrup.rowcount() )

if ll_existe > 0 Then
	//Se o produto j$$HEX1$$e100$$ENDHEX$$ existe no agrupamento, exclui a linha da datastore.
	//Ao final do processo permanecer$$HEX1$$e300$$ENDHEX$$o na datastore apenas os produtos que existem no sybase mas n$$HEX1$$e300$$ENDHEX$$o existem no SAP (os que devem ser excluidos).
	ids_lista_agrup.deleterow( ll_existe )

elseif ll_existe = 0 Then
	
	Insert into lista_tecnica_prd_agrup(cd_produto, cd_agrupamento)
	values( :il_cd_produto, :il_cd_agrupamento );
	
	if sqlca.sqlcode = -1 then
		as_log = 'Objeto: ' + this.classname() + '~nM$$HEX1$$e900$$ENDHEX$$todo: of_insere_agrupamento ~n' + 'Erro ao inserir registro na tabela "LISTA_TECNICA_PRD_AGRUP": ' + sqlca.sqlerrtext
		return false
	end if
	
end if
						
return true
end function

public function boolean of_excluir_agrupamento_prod (ref string ps_log);long ll_cd_produto, ll_cd_agrupamento, ll_for

//Os registros que permaneceram na datastore s$$HEX1$$e300$$ENDHEX$$o os que existem no Sybase mas n$$HEX1$$e300$$ENDHEX$$o vieram no XML do SAP. Portanto devem ser excluidos.

for ll_for = 1 to ids_lista_agrup.rowcount()
	
	ll_cd_produto = ids_lista_agrup.object.cd_produto[ll_for] 
	ll_cd_agrupamento = ids_lista_agrup.object.cd_agrupamento[ll_for]
	
	if ll_cd_produto > 0 and ll_cd_agrupamento > 0 Then
		
		delete from lista_tecnica_prd_agrup
		where cd_produto = :ll_cd_produto
		and cd_agrupamento = :ll_cd_agrupamento;
		
		If sqlca.sqlcode = -1 then
			ps_log = 'Objeto: ' + this.classname() + 'M$$HEX1$$e900$$ENDHEX$$todo: of_excluir_agrupamento~nProblemas ao excluir registro da tabela "LISTA_TECNICA_PRD_AGRUP": ' + sqlca.sqlerrtext
			return false
		end if
		
	end if
	
Next

return true
end function

public function boolean of_excluir_agrupamento (long pl_cd_agrupamento, ref string ps_log);
if pl_cd_agrupamento > 0 Then
	
	Delete from lista_tecnica_prd_agrup
	where cd_agrupamento = :pl_cd_agrupamento;
	
	if sqlca.sqlcode = -1 then
		ps_log = 'Objeto: ' + this.classname() + '~nM$$HEX1$$e900$$ENDHEX$$todo: of_excluir_agrupamento' + '~nErro ao excluir registro da tabela "lista_tecnica_prd_agrup": ' + sqlca.sqlerrtext
		return false
	end if

end if

return true
end function

on uo_ge473_lista_tecnica_prd_agrup.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge473_lista_tecnica_prd_agrup.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;io_Comum	= Create uo_ge473_comum


end event

event destructor;Destroy(io_Comum)

end event

