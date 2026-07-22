HA$PBExportHeader$uo_ge473_vigencia_estoque_promocao.sru
forward
global type uo_ge473_vigencia_estoque_promocao from nonvisualobject
end type
end forward

global type uo_ge473_vigencia_estoque_promocao from nonvisualobject
end type
global uo_ge473_vigencia_estoque_promocao uo_ge473_vigencia_estoque_promocao

type variables
uo_ge473_comum io_Comum

Boolean ib_continue = False

Long il_cd_promocao
datetime idh_inicio, idh_fim, idh_alteracao
String is_chave_sap, is_matricula, is_promocao_sap
				
long il_tabela = 58

end variables

forward prototypes
public function boolean of_valida_dados (ref string as_log)
private function boolean of_inicializa_variaveis (ref string as_log)
public subroutine of_processa_atualizacao ()
public function boolean of_carrega_chave (long al_controle, ref string as_chave_sap, ref string as_log)
public function boolean of_atualiza_vigencia_promocao (long al_controle, long al_tabela)
public function boolean of_insere_vigencia_promocao (ref string as_log)
end prototypes

public function boolean of_valida_dados (ref string as_log);boolean lb_existe = false
long ll_existe

Try	

	if il_cd_promocao = 0 or isnull(il_cd_promocao) Then
		as_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar a promo$$HEX2$$e700e300$$ENDHEX$$o SAP [' + is_promocao_sap + '] no sistema legado.'
		return false
	end if
		
	if isnull(idh_inicio) Then
		as_log = 'A data de in$$HEX1$$ed00$$ENDHEX$$cio da vig$$HEX1$$ea00$$ENDHEX$$ncia n$$HEX1$$e300$$ENDHEX$$o pode ser nula.'
		return false
	end if
	
	if isnull(idh_fim) Then
		as_log = 'A data final da vig$$HEX1$$ea00$$ENDHEX$$ncia n$$HEX1$$e300$$ENDHEX$$o pode ser nula.'
		return false
	end if

	Select count(*)
	into :ll_existe
	from usuario
	where nr_matricula = :is_matricula
	Using SQLCA;

	if SQLCA.sqlcode = -1 then 
		as_log = 'Objeto: ' + this.classname() + '~nM$$HEX1$$e900$$ENDHEX$$todo: of_valida_dados ~nErro ao consultar a tabela "usuario": ' + sqlca.sqlerrtext
		return false
	end if
	
	If ll_existe = 0 or isnull(ll_existe) Then is_matricula = 'SAP001'	
	
Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_valida_dados'. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True
end function

private function boolean of_inicializa_variaveis (ref string as_log);Try
	
	setnull(il_cd_promocao)
	setnull(idh_inicio)
	setnull(idh_fim)
	setnull(idh_alteracao)
	setnull(is_matricula)
	setnull(is_promocao_sap)
	
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
		gvo_aplicacao.of_grava_log("Interface Produto - Erro alterar a DW [ds_ge473_lista_controles] - uo_ge473_vigencia_estoque_promocao.of_processa_atualizacao" )
		Return
	End If
	
	ll_Linhas = lds.Retrieve(il_Tabela)
	
	If ll_Linhas > 0 Then
		For ll_Linha = 1 To ll_Linhas
											
			uo_ge473_vigencia_estoque_promocao  lo_vigencia
			 
			Try
				lo_vigencia	= Create uo_ge473_vigencia_estoque_promocao
				lo_vigencia.of_atualiza_vigencia_promocao( lds.Object.nr_controle[ll_Linha] , il_Tabela )
			Finally
				Destroy(lo_vigencia)
			End Try			
			
		Next
	ElseIf ll_Linhas < 0 Then
		gvo_aplicacao.of_grava_log("Interface Vigencia estoque promocao - Erro ao recuperar os da DW [ds_ge473_lista_controles] - uo_ge473_vigencia_estoque_promocao.of_processa_atualizacao.")
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

public function boolean of_atualiza_vigencia_promocao (long al_controle, long al_tabela);dc_uo_ds_base lds

Long	ll_Linhas,&
		ll_Linha, ll_registro_pendente
		
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
	
	if Not this.of_carrega_chave( al_controle, ref is_chave_sap, ref ls_log ) Then Return False
	 
	uo_ge473_comum lo_Comum
	lo_Comum = Create uo_ge473_comum
	
	If lo_Comum.of_processa_carrega_dados(al_controle, ref ls_Log) Then
		
		For ll_Linha = 1 To lo_Comum.ids_lista_registros.RowCount()
			
			this.of_inicializa_variaveis( ref ls_log )

			is_promocao_sap = gf_Tira_Zero_Esquerda(lo_Comum.ids_lista_registros.object.cd_promocao_sap[ll_linha])
		
			If not lo_comum.of_localiza_codigo_promocao_legado( is_promocao_sap, ref il_cd_promocao, ref ls_log) then
				lb_sucesso = false
				return false
			end if
		
			is_matricula = lo_Comum.ids_lista_registros.object.nr_matricula[ll_linha]
			
			ls_inicio = lo_Comum.ids_lista_registros.object.dh_inicio[ll_linha]
			ls_fim = lo_Comum.ids_lista_registros.object.dh_termino[ll_linha]
			ls_alteracao = lo_Comum.ids_lista_registros.object.dh_alteracao[ll_linha]
			
			If Not io_Comum.of_Date_Time(ls_inicio, 'DATA DE IN$$HEX1$$cd00$$ENDHEX$$CIO', ref idh_inicio, ref ls_Log) Then Return False
			If Not io_Comum.of_Date_Time(ls_fim, 'DATA FINAL', ref idh_fim, ref ls_Log) Then Return False
			If Not io_Comum.of_Date_Time(ls_alteracao, 'DATA DE ALTERA$$HEX2$$c700c300$$ENDHEX$$O', ref idh_alteracao, ref ls_Log) Then Return False
			
			If Not This.of_Valida_Dados(Ref ls_Log) Then
				lb_sucesso = false
				return false
			end if
		
			If Not This.of_insere_vigencia_promocao( ref ls_log ) Then
				lb_Sucesso	= False
				return false
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

public function boolean of_insere_vigencia_promocao (ref string as_log);long ll_existe

Select Count(*)
into :ll_existe
from promocao_sos
	where cd_promocao_sos = :il_cd_promocao;

if sqlca.sqlcode = -1 then
	as_log = 'Objeto: ' + this.classname() + '~nM$$HEX1$$e900$$ENDHEX$$todo: of_insere_vigencia_promocao ~n' + 'Erro ao consultar registro na tabela "PROMOCAO_SOS": ' + sqlca.sqlerrtext
	return false
end if

if ll_existe = 0 or isnull(ll_existe) Then
	as_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar a promo$$HEX2$$e700e300$$ENDHEX$$o [' + String(il_cd_promocao) + '] no banco de dados.'
	return false
end if
		
Update promocao_sos
	Set dh_inicio_estoque_minimo = :idh_inicio, 
			dh_termino_estoque_minimo = :idh_fim,
			nr_matricula_alteracao = :is_matricula
	where cd_promocao_sos = :il_cd_promocao;
					
if sqlca.sqlcode = -1 then
	as_log = 'Objeto: ' + this.classname() + '~nM$$HEX1$$e900$$ENDHEX$$todo: of_insere_vigencia_promocao ~n' + 'Erro ao atualizar registro na tabela "PROMOCAO_SOS": ' + sqlca.sqlerrtext
	return false
end if					
	
		
return true
end function

on uo_ge473_vigencia_estoque_promocao.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge473_vigencia_estoque_promocao.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;io_Comum	= Create uo_ge473_comum


end event

event destructor;Destroy(io_Comum)

end event

