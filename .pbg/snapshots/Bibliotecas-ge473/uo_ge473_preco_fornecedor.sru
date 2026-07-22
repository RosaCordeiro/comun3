HA$PBExportHeader$uo_ge473_preco_fornecedor.sru
forward
global type uo_ge473_preco_fornecedor from nonvisualobject
end type
end forward

global type uo_ge473_preco_fornecedor from nonvisualobject
end type
global uo_ge473_preco_fornecedor uo_ge473_preco_fornecedor

type variables
uo_ge473_comum io_Comum

Boolean ib_continue = False

string is_cd_fornecedor, is_cd_tipo_condicao, is_cd_uf, is_produto_sap

Long il_produto_legado

datetime idh_inicio_vigencia, idh_termino_vigencia

Decimal idc_valor

Date idh_atual

String is_matricula_sap = 'SAP001', is_chave_sap
				
long il_tabela = 62

end variables

forward prototypes
public function boolean of_valida_dados (ref string as_log)
private function boolean of_inicializa_variaveis (ref string as_log)
public subroutine of_processa_atualizacao ()
public function boolean of_carrega_chave (long al_controle, ref string as_chave_sap, ref string as_log)
public function boolean of_busca_fator_conversao (long pl_cd_produto, ref long pl_fator_conversao, ref string ps_log)
public function boolean of_data_parametro (ref string as_log)
public function boolean of_atualiza_preco_fornecedor (long al_controle, long al_tabela)
public function boolean of_insere_preco_fornecedor (ref string as_log)
end prototypes

public function boolean of_valida_dados (ref string as_log);boolean lb_existe = false
long ll_existe
string ls_msg

ls_msg = 'Objeto: ' + this.classname() + '~nM$$HEX1$$e900$$ENDHEX$$todo: of_valida_dados ~n'

Try	

	If IsNull(is_cd_fornecedor) or is_cd_fornecedor = '' Then
		as_Log	= "O c$$HEX1$$f300$$ENDHEX$$digo do fornecedor n$$HEX1$$e300$$ENDHEX$$o pode ser nulo."
		Return False
	End If	

	If IsNull(is_cd_UF) or is_cd_UF = '' Then
		as_Log	= "O c$$HEX1$$f300$$ENDHEX$$digo da unidade federa$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o pode ser nulo."
		Return False
	end if
	
	If IsNull(is_cd_tipo_condicao) or is_cd_tipo_condicao = '' Then
		as_Log	= "O c$$HEX1$$f300$$ENDHEX$$digo do tipo da condi$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o pode ser nulo."
		Return False
	end if
	
	If IsNull(is_produto_sap) or is_produto_sap = '' Then
		as_Log	= "O c$$HEX1$$f300$$ENDHEX$$digo do produto n$$HEX1$$e300$$ENDHEX$$o pode ser nulo."
		Return False
	end if
	
	If IsNull(idc_valor) Then
		as_Log	= "O valor da condi$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o pode ser nulo."
		Return False
	end if
	
	Select count(*)
	into :ll_existe
	from preco_fornecedor_sap
	where cd_fornecedor = :is_cd_fornecedor
		and cd_produto = :il_produto_legado
		and cd_tipo_condicao = :is_cd_tipo_condicao
		and vl_montante = :idc_valor
		and (dh_termino_vigencia is null or dh_termino_vigencia >= convert(date,getdate()) );
		
	If sqlca.sqlcode = -1 then
		as_log = ls_msg + 'Problemas ao consultar a tabela "preco_fornecedor_sap": ' + sqlca.sqlerrtext
		return false
	end if
	
	if ll_existe > 0 Then
		ib_continue = True
		return true
	end if
	
Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_valida_dados'. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True
end function

private function boolean of_inicializa_variaveis (ref string as_log);Try
	
	setnull(is_cd_fornecedor)
	setnull(is_cd_tipo_condicao)
	setnull(is_cd_uf)
	setnull(is_produto_sap)
	setnull(il_produto_legado)
	setnull(idh_inicio_vigencia)
	setnull(idh_termino_vigencia)
	setnull(idc_valor)
	
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
		gvo_aplicacao.of_grava_log("Interface Pre$$HEX1$$e700$$ENDHEX$$o Fornecedor - Erro alterar a DW [ds_ge473_lista_controles] - uo_ge473_preco_fornecedor.of_processa_atualizacao" )
		Return
	End If
	
	ll_Linhas = lds.Retrieve(il_Tabela)
	
	If ll_Linhas > 0 Then
		For ll_Linha = 1 To ll_Linhas
											
			uo_ge473_preco_fornecedor lo_preco_fornecedor
			 
			Try
				lo_preco_fornecedor	= Create uo_ge473_preco_fornecedor
				lo_preco_fornecedor.of_atualiza_preco_fornecedor( lds.Object.nr_controle[ll_Linha] , il_Tabela )
			Finally
				Destroy(lo_preco_fornecedor)
			End Try			
			
		Next
	ElseIf ll_Linhas < 0 Then
		gvo_aplicacao.of_grava_log("Interface Pre$$HEX1$$e700$$ENDHEX$$o Fornecedor - Erro ao recuperar dados da DW [ds_ge473_lista_controles] - uo_ge473_preco_fornecedor.of_processa_atualizacao.")
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

public function boolean of_data_parametro (ref string as_log);Select dh_movimentacao Into :idh_atual
From parametro 
Where id_parametro = '1'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Return True
	Case 100
		as_log = "Data de movimenta$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o localizada nos par$$HEX1$$e200$$ENDHEX$$metros."
	Case -1
		as_log = "Localiza$$HEX2$$e700e300$$ENDHEX$$o da Data de Movimenta$$HEX2$$e700e300$$ENDHEX$$o do Par$$HEX1$$e200$$ENDHEX$$metro: "  +  + sqlca.sqlerrtext
End Choose

Return False
end function

public function boolean of_atualiza_preco_fornecedor (long al_controle, long al_tabela);dc_uo_ds_base lds

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
	 PRECO_FORNECEDOR(62)
	*/
	
	If Not This.of_data_parametro(ref ls_log) Then Return False
	 
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

			lo_comum.of_localiza_codigo_fornecedor_legado( lo_Comum.ids_lista_registros.Object.cd_fornecedor_sap[ll_Linha], ref is_cd_fornecedor, ref ls_log)

			if isvalid(w_aguarde_3) Then
				w_aguarde_3.wf_settext('Fornecedor: ' + is_cd_fornecedor, 3 )
			end if

			is_cd_tipo_condicao = lo_Comum.ids_lista_registros.Object.cd_tipo_condicao[ll_Linha]
			is_cd_uf = lo_Comum.ids_lista_registros.Object.cd_unidade_federacao[ll_Linha]
			
			is_produto_sap = gf_Tira_Zero_Esquerda(lo_Comum.ids_lista_registros.Object.cd_produto_sap[ll_Linha])
			If IsNull(is_produto_sap) Then is_produto_sap = ''
			
			If Not io_Comum.of_Localiza_Codigo_Produto_Legado(is_produto_sap, Ref il_produto_legado, Ref ls_Log) Then 
				lb_sucesso = false
				Return False	
			end if
			
			If Not io_Comum.of_date_time(lo_Comum.ids_lista_registros.Object.dh_inicio_vigencia[ll_Linha], 'DATA INICIO VIGENCIA', ref idh_inicio_vigencia, ref ls_Log) Then 
				lb_sucesso = false
				Return False
			end if

			If Not io_Comum.of_date_time(lo_Comum.ids_lista_registros.Object.dh_termino_vigencia[ll_Linha], 'DATA TERMINO VIGENCIA', ref idh_termino_vigencia, ref ls_Log) Then 
				lb_sucesso = false
				Return False
			end if

			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vl_montante[ll_Linha], 'VALOR MONTANTE', ref idc_valor, ref ls_Log) Then 
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
		
			If Not This.of_insere_preco_fornecedor( ref ls_log ) Then
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
		io_Comum.of_grava_erro(al_controle, 186, ls_Log)
	End If
		
	Destroy(lds)
	Destroy(lo_comum)
	
End Try

Return lb_Sucesso
end function

public function boolean of_insere_preco_fornecedor (ref string as_log);datetime ldh_termino, ldh_atual
long ll_existe, ll_nr_sequencial, ll_nr_sequencial_ant
string ls_msg

ls_msg = 'Objeto: ' + this.classname( ) + '~nM$$HEX1$$e900$$ENDHEX$$todo: of_insere_preco_fornecedor ~n'

ldh_atual = gf_getserverdate()

Select nr_sequencial
into :ll_nr_sequencial_ant
from preco_fornecedor_sap
where cd_fornecedor = :is_cd_fornecedor
	and cd_produto = :il_produto_legado
	and cd_tipo_condicao = :is_cd_tipo_condicao
	and vl_montante <> :idc_valor
	and (dh_termino_vigencia is null or dh_termino_vigencia >= convert(date,getdate()) );
	
If sqlca.sqlcode = -1 then
	as_log = ls_msg + 'Problemas ao consultar a tabela "preco_fornecedor_sap"[1]: ' + sqlca.sqlerrtext
	return false
end if

//Finaliza a vig$$HEX1$$ea00$$ENDHEX$$ncia anterior.
if ll_nr_sequencial_ant > 0 Then
	ldh_termino = DateTime( relativedate(date(ldh_atual), -1), Time('00:00'))
	
	update preco_fornecedor_sap
	set dh_termino_vigencia = :ldh_termino
	where nr_sequencial = :ll_nr_sequencial_ant;
	
	If sqlca.sqlcode = -1 then
		as_log = ls_msg + 'Problemas ao atualizar a tabela "preco_fornecedor_sap"[2]: ' + sqlca.sqlerrtext
		return false
	end if
	
end if

select max(nr_sequencial)
into :ll_nr_sequencial
from preco_fornecedor_sap;

If sqlca.sqlcode = -1 then
	as_log = ls_msg + 'Problemas ao consultar a tabela "preco_fornecedor_sap"[3]: ' + sqlca.sqlerrtext
	return false
end if

if isnull(ll_nr_sequencial) or ll_nr_sequencial = 0 Then
	ll_nr_sequencial = 1
else
	ll_nr_sequencial++
end if

Insert into preco_fornecedor_sap(nr_sequencial, 
											cd_fornecedor, 
											cd_produto, 
											cd_unidade_federacao, 
											cd_tipo_condicao, 
											dh_inicio_vigencia, 
											dh_termino_vigencia, 
											vl_montante, 
											dh_atualizacao)
values(:ll_nr_sequencial,
		:is_cd_fornecedor,
		:il_produto_legado,
		:is_cd_uf,
		:is_cd_tipo_condicao,
		:idh_inicio_vigencia,
		:idh_termino_vigencia,
		:idc_valor,
		:ldh_atual);
		
If sqlca.sqlcode = -1 then
	as_log = ls_msg + 'Problemas ao inserir registro na tabela "preco_fornecedor_sap"[4]: ' + sqlca.sqlerrtext
	return false
end if		

return true
end function

on uo_ge473_preco_fornecedor.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge473_preco_fornecedor.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;io_Comum	= Create uo_ge473_comum


end event

event destructor;Destroy(io_Comum)

end event

