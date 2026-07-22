HA$PBExportHeader$uo_ge473_remanejamento.sru
forward
global type uo_ge473_remanejamento from nonvisualobject
end type
end forward

global type uo_ge473_remanejamento from nonvisualobject
end type
global uo_ge473_remanejamento uo_ge473_remanejamento

type variables
uo_ge473_comum io_Comum

Boolean ib_continue = False
String is_cd_produto_sap
String is_chave_sap
long il_tabela = 69
Long il_cd_produto
long il_cd_agrupamento
String is_excluir_agrupamento


String is_cd_remanejamento
String is_cd_status
String is_de_hora
String is_de_remanejamento
String is_usuario
String	is_id_retirada_excluida	
Datetime idh_inicio_vigencia
Datetime idh_remanejamento
Datetime idh_termino_vigencia


end variables

forward prototypes
public function boolean of_valida_dados (ref string as_log)
private function boolean of_inicializa_variaveis (ref string as_log)
public subroutine of_processa_atualizacao ()
public function boolean of_carrega_chave (long al_controle, ref string as_chave_sap, ref string as_log)
public function boolean of_atualiza_remanejamento (long al_controle, long al_tabela)
public function boolean of_valida_usuario (ref string as_nr_matricula, ref string as_log)
public function boolean of_busca_valor_custo (long pl_cd_filial, long pl_cd_produto, ref decimal pdc_valor, ref string ps_log)
public function boolean of_insere_remanejamento_resultado (long al_cd_remanejamento, long al_controle_pai, ref string as_log)
public function boolean of_insere_remanejamento (ref long al_cd_remanejamento, ref string as_log)
public function boolean of_insere_remanejamento_filial (long pl_cd_remanejamento, long pl_cd_filial, string ps_tipo, ref string ps_log)
end prototypes

public function boolean of_valida_dados (ref string as_log);boolean lb_existe = false
long ll_existe

Try	

	if isnull(is_cd_remanejamento) or is_cd_remanejamento = '' Then
		as_log = 'O C$$HEX1$$f300$$ENDHEX$$digo do remanejamento n$$HEX1$$e300$$ENDHEX$$o pode ser nulo.'
		return false
	end if
	
	if isnull(is_cd_status) or is_cd_status = '' Then
		as_log = 'O status do remanejamento n$$HEX1$$e300$$ENDHEX$$o pode ser nulo. '
		return false
	end if
	
	if isnull(is_de_hora) or is_de_hora = '' Then
		as_log = 'A hora do remanejamento n$$HEX1$$e300$$ENDHEX$$o pode ser nula.'
		return false
	end if
	
	if isnull(is_de_remanejamento) or is_de_remanejamento = '' Then
		as_log = 'A descri$$HEX2$$e700e300$$ENDHEX$$o do remanejamento n$$HEX1$$e300$$ENDHEX$$o pode ser nula.'
		return false
	end if
	
	if isnull(idh_inicio_vigencia) Then
		as_log = 'A data de inicio da vig$$HEX1$$ea00$$ENDHEX$$ncia n$$HEX1$$e300$$ENDHEX$$o pode ser nula.'
		return false
	end if
	
	if isnull(idh_termino_vigencia) Then
		as_log = 'A data de t$$HEX1$$e900$$ENDHEX$$rmino da vig$$HEX1$$ea00$$ENDHEX$$ncia n$$HEX1$$e300$$ENDHEX$$o pode ser nula.'
		return false
	end if
	
	if isnull(idh_remanejamento) Then
		as_log = 'A data de cria$$HEX2$$e700e300$$ENDHEX$$o do remanejamento n$$HEX1$$e300$$ENDHEX$$o pode ser nula.'
		return false
	end if
	
	if isnull(is_usuario) or is_usuario = '' Then
		as_log = 'O usu$$HEX1$$e100$$ENDHEX$$rio repons$$HEX1$$e100$$ENDHEX$$vel pela cria$$HEX2$$e700e300$$ENDHEX$$o do remanejamento deve ser informado.'
		return false
	end if
	
	//Se o Status vier como E (Encerrado) deve encerrar o remanejamento (data atual - 1).
	if is_cd_status = 'E' Then
		
		idh_termino_vigencia = Datetime( RelativeDate( Date( gf_getserverdate() ), -1), Time('00:00') )
		
	end if
	
	if Not of_valida_usuario(ref is_usuario, ref as_log) Then return false
	
Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_valida_dados'. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True
end function

private function boolean of_inicializa_variaveis (ref string as_log);Try

	Setnull(is_cd_remanejamento)
	Setnull(is_cd_status)
	Setnull(is_de_hora)
	Setnull(is_de_remanejamento)
	Setnull(is_usuario)
	Setnull(idh_inicio_vigencia)
	Setnull(idh_termino_vigencia)
	Setnull(idh_remanejamento)
	
Catch ( runtimeerror lo_rte )
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
		gvo_aplicacao.of_grava_log("Interface Remanejamento - Erro alterar a DW [ds_ge473_lista_controles] - uo_ge473_remanejamento.of_processa_atualizacao" )
		Return
	End If
	
	ll_Linhas = lds.Retrieve(il_Tabela)
	
	If ll_Linhas > 0 Then
		For ll_Linha = 1 To ll_Linhas
											
			uo_ge473_remanejamento lo_remanejamento
			 
			Try
				lo_remanejamento	= Create uo_ge473_remanejamento
				lo_remanejamento.of_atualiza_remanejamento( lds.Object.nr_controle[ll_Linha] , il_Tabela )
			Finally
				Destroy(lo_remanejamento)
			End Try			
			
		Next
	ElseIf ll_Linhas < 0 Then
		gvo_aplicacao.of_grava_log("Interface Remanejamento - Erro ao recuperar os da DW [ds_ge473_lista_controles] - uo_ge473_remanejamento.of_processa_atualizacao.")
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

public function boolean of_atualiza_remanejamento (long al_controle, long al_tabela);dc_uo_ds_base lds
Long	ll_Linhas,&
		ll_Linha, ll_registro_pendente, ll_cd_remanejamento
		
String	ls_Log
String ls_inicio, ls_fim, ls_alteracao
Boolean	lb_Sucesso = True		

Try
	
	if Not io_Comum.of_atualizacao_pendente( al_controle, ref ll_registro_pendente, ref ls_log) Then 
		lb_sucesso = false
		return false
	end if
		
	//Controle j$$HEX1$$e100$$ENDHEX$$ foi processado
	If ll_registro_pendente = 0 Then Return True
	
	If Not io_Comum.of_Muda_Situacao_Interface(al_Controle, Ref ls_Log) Then Return False
	 
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
		
			is_cd_remanejamento 		= gf_Tira_Zero_Esquerda(lo_Comum.ids_lista_registros.object.cd_remanejamento[ll_linha])
			is_cd_status 				= lo_Comum.ids_lista_registros.object.cd_status[ll_linha]
			is_de_hora 					= lo_Comum.ids_lista_registros.object.de_hora[ll_linha]
			is_de_remanejamento 		= lo_Comum.ids_lista_registros.object.de_remanejamento[ll_linha]
			is_usuario 					= lo_Comum.ids_lista_registros.object.nr_matricula_usuario[ll_linha]
			is_id_retirada_excluida	= lo_Comum.ids_lista_registros.object.id_retirada_excluida[ll_linha]
			
			If Not io_Comum.of_date_time(lo_Comum.ids_lista_registros.Object.dh_inicio_vigencia[ll_Linha], 'DATA INICIO VIGENCIA', ref idh_inicio_vigencia, ref ls_Log) Then Return False
			If Not io_Comum.of_date_time(lo_Comum.ids_lista_registros.Object.dh_termino_vigencia[ll_Linha], 'DATA TERMINO VIGENCIA', ref idh_termino_vigencia, ref ls_Log) Then Return False
			If Not io_Comum.of_date_time(lo_Comum.ids_lista_registros.Object.dh_remanejamento[ll_Linha], 'DATA REMANEJAMENTO', ref idh_remanejamento, ref ls_Log) Then Return False
			
			if isvalid(w_aguarde_3) Then
				w_aguarde_3.wf_settext('Remanejamento: ' + is_cd_remanejamento, 3 )
			end if
			
			If Not This.of_Valida_Dados(Ref ls_Log) Then
				lb_sucesso = false
				return false
			end if
		
			If Not This.of_insere_remanejamento( ref ll_cd_remanejamento, ref ls_log ) Then
				lb_Sucesso	= False
				return false
			end if
			
			if ll_cd_remanejamento > 0 Then
				If Not This.of_insere_remanejamento_resultado(ll_cd_remanejamento, al_controle, ref ls_log ) Then
					lb_Sucesso	= False
					return false
				end if
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

public function boolean of_valida_usuario (ref string as_nr_matricula, ref string as_log);long ll_existe

Select count(*)
into :ll_existe
from usuario
where nr_matricula = :as_nr_matricula
Using SQLCA;

if SQLCA.sqlcode = -1 then 
	as_log = 'Objeto: ' + this.classname() + '~nM$$HEX1$$e900$$ENDHEX$$todo: of_valida_usuario ~nErro ao consultar a tabela "usuario": ' + sqlca.sqlerrtext
	return false
end if

If ll_existe = 0 or isnull(ll_existe) Then as_nr_matricula = 'SAP001'

return true
end function

public function boolean of_busca_valor_custo (long pl_cd_filial, long pl_cd_produto, ref decimal pdc_valor, ref string ps_log);decimal{2} ldc_custo

select vl_custo
	into :ldc_custo
from saldo_estoque_sap
where cd_filial = :pl_cd_filial
	and cd_produto = :pl_cd_produto;

if sqlca.sqlcode = -1 then
	ps_log = 'Objeto: ' + this.classname( ) + '~nM$$HEX1$$e900$$ENDHEX$$todo: of_busca_valor_custo ~nProblemas ao consultar a tabela "saldo_estoque_sap": ' + sqlca.sqlerrtext
	return false
end if

if isnull(ldc_custo) then
	pdc_valor = 0 
else
	pdc_valor = ldc_custo
end if

return true
end function

public function boolean of_insere_remanejamento_resultado (long al_cd_remanejamento, long al_controle_pai, ref string as_log);Long ll_linhas, ll_exists
Long ll_linha
Long ll_cd_Filial_origem, ll_cd_filial_destino
Long ll_controle_filho, ll_cd_produto,ll_existe
Long ll_qt_remanejamento
Decimal{2} ldc_vl_custo, ldc_vl_remanejamento

String ls_filial_origem, ls_filial_destino, ls_cd_remanejamento_sap
String ls_chave_sap_filial, ls_cd_produto_sap

Try

	SELECT nr_controle, de_chave_sap
	Into :ll_Controle_filho, :ls_chave_sap_filial
	FROM interface_sap  i 
	Where i.cd_tabela = 70
		and i.nr_controle_pai = :al_controle_pai
	Using SqlCa;

	If SqlCa.sqlcode = -1 Then
		as_Log = "Erro ao buscar o controle na tabela interface_sap. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle_pai)+". Erro: "+SqlCa.sqlErrText
		Return False
	End If

	If ll_Controle_filho = 0 Or IsNull(ll_Controle_filho) Then
		return true
	End If
	
	uo_ge473_comum lo_Comum
	lo_Comum = Create uo_ge473_comum
			
	If lo_Comum.of_processa_carrega_dados(ll_Controle_filho, ref as_Log) Then	
		
		For ll_Linha = 1 To lo_Comum.ids_lista_registros.RowCount()
			
			ls_filial_origem = lo_Comum.ids_lista_registros.Object.cd_filial_sap_origem[ll_Linha]
			If Not io_Comum.of_Localiza_Codigo_Filial_Legado(ls_filial_origem , Ref  ll_cd_Filial_origem, Ref as_Log) Then Return False
			
			ls_filial_destino = lo_Comum.ids_lista_registros.Object.cd_filial_sap_destino[ll_Linha]
			If Not io_Comum.of_Localiza_Codigo_Filial_Legado(ls_filial_destino , Ref  ll_cd_Filial_destino, Ref as_Log) Then Return False
			
			ls_cd_remanejamento_sap =  gf_Tira_Zero_Esquerda(lo_Comum.ids_lista_registros.object.cd_remanejamento[ll_linha])
			
			ls_cd_produto_sap = gf_Tira_Zero_Esquerda(lo_Comum.ids_lista_registros.object.cd_produto_sap[ll_linha])
			
			If IsNull(ls_cd_produto_sap) Then ls_cd_produto_sap = ''
			
			If Not io_Comum.of_Localiza_Codigo_Produto_Legado(ls_cd_produto_sap, Ref ll_cd_Produto, Ref as_Log) Then
				Return False
			End If		
			
			ll_qt_remanejamento = long( gf_Replace( lo_Comum.ids_lista_registros.object.qt_remanejamento[ll_linha] , '.', ',', 0))
			
			if isnull(ls_cd_remanejamento_sap) or ls_cd_remanejamento_sap = '' Then
				as_log = 'O c$$HEX1$$f300$$ENDHEX$$digo do remanejamento n$$HEX1$$e300$$ENDHEX$$o pode ser nulo.'
				return false
			end if
			
			if isnull(ll_cd_filial_origem) or ll_cd_filial_origem = 0 Then
				as_log = 'O c$$HEX1$$f300$$ENDHEX$$digo da filial origem deve ser informado.'	
				return false
			end if
			
			if isnull(ll_cd_filial_destino) or ll_cd_filial_destino = 0 Then
				as_log = 'O c$$HEX1$$f300$$ENDHEX$$digo da filial destino deve ser informado.'	
				return false
			end if
			
			if isnull(ll_cd_produto) or ll_cd_produto = 0 Then
				as_log = 'O c$$HEX1$$f300$$ENDHEX$$digo do produto deve ser informado.'	
				return false
			end if
			
			if isnull(ll_qt_remanejamento) or ll_qt_remanejamento = 0 Then
				continue
			end if
			
			if is_id_retirada_excluida	= 'X' Then
				
				Select count(*)
				into :ll_existe
				from remanejamento_resultado
				where  cd_remanejamento = :al_cd_remanejamento
					and cd_filial_origem = :ll_cd_filial_origem
					and cd_filial_destino = :ll_cd_filial_destino
					and cd_produto = :ll_cd_produto;
				
				If SqlCa.sqlcode = -1 Then
					as_Log = "Objeto: " + this.classname() + "~nM$$HEX1$$e900$$ENDHEX$$todo: of_insere_remanejamento_resultado ~n" + "Erro ao consultar registro na tabela 'remanejamento_resultado': " + SqlCa.sqlErrText
					Return False
				End If
				
				delete from remanejamento_filial
				where cd_remanejamento = :al_cd_remanejamento
					and cd_filial = :ll_cd_filial_origem;
				
				If SqlCa.sqlcode = -1 Then
					as_Log = "Objeto: " + this.classname() + "~nM$$HEX1$$e900$$ENDHEX$$todo: of_insere_remanejamento_resultado ~n" + "Erro ao excluir registro na tabela 'remanejamento_filial': " + SqlCa.sqlErrText
					Return False
				End If
				
				delete from remanejamento_filial
				where cd_remanejamento = :al_cd_remanejamento
					and cd_filial = :ll_cd_filial_destino;
				
				If SqlCa.sqlcode = -1 Then
					as_Log = "Objeto: " + this.classname() + "~nM$$HEX1$$e900$$ENDHEX$$todo: of_insere_remanejamento_resultado ~n" + "Erro ao excluir registro na tabela 'remanejamento_filial': " + SqlCa.sqlErrText
					Return False
				End If
					
				Delete from remanejamento_resultado
				where cd_remanejamento = :al_cd_remanejamento
				and cd_filial_origem = :ll_cd_filial_origem
				and cd_filial_destino = :ll_cd_filial_destino
				and cd_produto = :ll_cd_produto;
				
				If SqlCa.sqlcode = -1 Then
					as_Log = "Objeto: " + this.classname() + "~nM$$HEX1$$e900$$ENDHEX$$todo: of_insere_remanejamento_resultado ~n" + "Erro ao excluir registro na tabela 'remanejamento_resultado': " + SqlCa.sqlErrText
					Return False
				End If
				
			else
				
				If Not this.of_busca_valor_custo( ll_cd_filial_origem, ll_cd_produto, ref ldc_vl_custo, ref as_log ) Then return false
				
				ldc_vl_remanejamento = ( ldc_vl_custo * ll_qt_remanejamento )
				
				select 1
				  into :ll_exists
				  from remanejamento_resultado
				 where cd_remanejamento		= :al_cd_remanejamento
				 	and cd_filial_origem		= :ll_cd_filial_origem
					and cd_filial_destino	= :ll_cd_filial_destino
					and cd_produto				= :ll_cd_produto
				using SQLCA;
				
				Choose Case SQLCA.SQLCode
					Case -1
						as_Log = "Objeto: " + this.classname() + "~nM$$HEX1$$e900$$ENDHEX$$todo: of_insere_remanejamento_resultado ~n" + "Erro ao consultar registro na tabela 'remanejamento_resultado': " + SqlCa.sqlErrText
						Return False
					Case 100
						Insert into remanejamento_resultado(cd_remanejamento, 
																		cd_filial_origem, 
																		cd_filial_destino, 
																		cd_produto, 
																		qt_remanejamento, 
																		vl_remanejamento, 
																		id_situacao)
						Values( :al_cd_remanejamento, 
									:ll_cd_filial_origem, 
									:ll_cd_filial_destino, 
									:ll_cd_produto, 
									:ll_qt_remanejamento, 
									:ldc_vl_remanejamento, 
									'P' );
						
						If SqlCa.sqlcode = -1 Then
							as_Log = "Objeto: " + this.classname() + "~nM$$HEX1$$e900$$ENDHEX$$todo: of_insere_remanejamento_resultado ~n" + "Erro ao inserir registro na tabela 'remanejamento_resultado': " + SqlCa.sqlErrText
							Return False
						End If
					Case 0
						update remanejamento_resultado
							set qt_remanejamento = :ll_qt_remanejamento, 
								 vl_remanejamento	= :ldc_vl_remanejamento
		 				 where cd_remanejamento		= :al_cd_remanejamento
							and cd_filial_origem		= :ll_cd_filial_origem
							and cd_filial_destino	= :ll_cd_filial_destino
							and cd_produto				= :ll_cd_produto
						using SQLCA;
						
						If SqlCa.sqlcode = -1 Then
							as_Log = "Objeto: " + this.classname() + "~nM$$HEX1$$e900$$ENDHEX$$todo: of_insere_remanejamento_resultado ~n" + "Erro ao atualizar registro na tabela 'remanejamento_resultado': " + SqlCa.sqlErrText
							Return False
						End If
				End Choose
				
				if ll_cd_filial_origem > 0 Then
					If Not this.of_insere_remanejamento_filial( al_cd_remanejamento, ll_cd_filial_origem, 'S', ref as_log) Then return false
				end if
				
				if ll_cd_filial_destino > 0 Then
					If Not this.of_insere_remanejamento_filial( al_cd_remanejamento, ll_cd_filial_destino, 'E', ref as_log) Then return false
				end if
				
			end if
			
		Next
		
	Else
		Return False
	End If	
	
Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_insere_remanejamento_resultado'. Erro: "+lo_rte.GetMessage( )
	Return False	
Finally
	If IsValid(lo_Comum) Then Destroy(lo_Comum)
End Try	

Return True
end function

public function boolean of_insere_remanejamento (ref long al_cd_remanejamento, ref string as_log);long ll_existe, ll_cd_remanejamento
string ls_log
datetime ldh_calculo

Select cd_remanejamento
into :ll_cd_remanejamento
from remanejamento
where cd_remanejamento_sap = :is_cd_remanejamento;

if sqlca.sqlcode = -1 then
	as_log = 'Objeto: ' + this.classname() + '~nM$$HEX1$$e900$$ENDHEX$$todo: of_insere_remanejamento ~n' + 'Erro ao consultar a tabela "REMANEJAMENTO": ' + sqlca.sqlerrtext
	return false
end if

if ll_cd_remanejamento = 0 or isnull(ll_cd_remanejamento) Then
	Select max(cd_remanejamento)
	into :ll_cd_remanejamento
	from remanejamento;
	
	if sqlca.sqlcode = -1 then
		as_log = 'Objeto: ' + this.classname() + '~nM$$HEX1$$e900$$ENDHEX$$todo: of_insere_remanejamento ~n' + 'Erro ao consultar a tabela "REMANEJAMENTO": ' + sqlca.sqlerrtext
		return false
	end if
	
	if ll_cd_remanejamento = 0 or isnull(ll_cd_remanejamento) Then
		ll_Cd_remanejamento = 1
	else
		ll_cd_remanejamento++
	end if
	
	al_cd_remanejamento = ll_cd_remanejamento
	
	ldh_calculo = Datetime( Date( idh_remanejamento), Time( is_de_hora ) )
	
	Insert into remanejamento(cd_remanejamento, 
										de_remanejamento, 
										dh_inicio_vigencia, 
										dh_termino_vigencia, 
										cd_status_sap, 
										nr_matricula_responsavel, 
										dh_calculo, 
										cd_remanejamento_sap,
										qt_dias_retirada, 
										qt_dias_remanejamento, 
										id_selecao_produto, 
										id_psico, 
										id_geladeira, 
										id_planograma, 
										id_tratamento_estoque_base, 
										id_beauty_club, 
										id_promocao_estoque_minimo )
	values( :ll_cd_remanejamento, 
			  :is_de_remanejamento,
			  :idh_inicio_vigencia,
			  :idh_termino_vigencia,
			  :is_cd_status,
			  :is_usuario,
			  :ldh_calculo,
			  :is_cd_remanejamento,
			  180,
			  60,
			  0,
			  'S',
			  'N',
			  'N',
			  '0',
			  'S',
			  'N');
	
	if sqlca.sqlcode = -1 then
		as_log = 'Objeto: ' + this.classname() + '~nM$$HEX1$$e900$$ENDHEX$$todo: of_insere_remanejamento ~n' + 'Erro ao inserir registro na tabela "REMANEJAMENTO": ' + sqlca.sqlerrtext
		return false
	end if

Else
	
	al_cd_remanejamento = ll_cd_remanejamento
	
	Update remanejamento
	set de_remanejamento = :is_de_remanejamento, 
		dh_inicio_vigencia = :idh_inicio_vigencia,
		dh_termino_vigencia = :idh_termino_vigencia,
		cd_status_sap = :is_cd_status
	Where cd_remanejamento = :ll_cd_remanejamento;
	
	if sqlca.sqlcode = -1 then
		as_log = 'Objeto: ' + this.classname() + '~nM$$HEX1$$e900$$ENDHEX$$todo: of_insere_remanejamento ~n' + 'Erro ao atualizar registro na tabela "REMANEJAMENTO": ' + sqlca.sqlerrtext
		return false
	end if
	
End if
						
return true
end function

public function boolean of_insere_remanejamento_filial (long pl_cd_remanejamento, long pl_cd_filial, string ps_tipo, ref string ps_log);string ls_retirada, ls_recebe

//Ps_tipo = S = Saida = Retirada
//Ps_tipo = E = Entrada = Recebe

Select id_retirada, id_recebe
into :ls_retirada, :ls_recebe
from remanejamento_filial
where cd_remanejamento = :pl_cd_remanejamento
and cd_filial = :pl_cd_filial;

if ps_tipo = 'S' and ( ls_retirada = 'N' or isnull(ls_retirada) or ls_retirada = '' ) Then
	ls_retirada = 'S'
elseif ps_tipo = 'E' and ( ls_recebe = 'N' or isnull(ls_recebe) or ls_recebe = '' ) Then
	ls_recebe = 'S'
end if

Choose Case sqlca.sqlcode
		
	Case -1
	
		ps_log = 'Objeto: ' + this.classname( ) + '~nM$$HEX1$$e900$$ENDHEX$$todo: of_insere_remanejamento_filial ~n' + 'Problemas ao consultar a tabela "remanejamento_filial": ' + sqlca.sqlerrtext
		return false
		
	Case 0
		
		Update remanejamento_filial
		set id_retirada = :ls_retirada, id_recebe = :ls_recebe
		where cd_remanejamento = :pl_cd_remanejamento
			and cd_filial = :pl_cd_filial;
		
		if sqlca.sqlcode = -1 then
			ps_log = 'Objeto: ' + this.classname( ) + '~nM$$HEX1$$e900$$ENDHEX$$todo: of_insere_remanejamento_filial ~n' + 'Problemas ao atualizar registro na tabela "remanejamento_filial": ' + sqlca.sqlerrtext
			return false
		end if
		
	Case 100
		
		insert into remanejamento_filial(cd_remanejamento, cd_filial, id_retirada, id_recebe)
		values (:pl_Cd_remanejamento, :pl_cd_filial, :ls_retirada, :ls_recebe);
		
		if sqlca.sqlcode = -1 then
			ps_log = 'Objeto: ' + this.classname( ) + '~nM$$HEX1$$e900$$ENDHEX$$todo: of_insere_remanejamento_filial ~n' + 'Problemas ao inserir registro na tabela "remanejamento_filial": ' + sqlca.sqlerrtext
			return false
		end if
		
End Choose


return true
end function

on uo_ge473_remanejamento.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge473_remanejamento.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;io_Comum	= Create uo_ge473_comum


end event

event destructor;Destroy(io_Comum)

end event

