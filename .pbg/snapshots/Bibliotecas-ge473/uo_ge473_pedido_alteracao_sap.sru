HA$PBExportHeader$uo_ge473_pedido_alteracao_sap.sru
forward
global type uo_ge473_pedido_alteracao_sap from nonvisualobject
end type
end forward

global type uo_ge473_pedido_alteracao_sap from nonvisualobject
end type
global uo_ge473_pedido_alteracao_sap uo_ge473_pedido_alteracao_sap

type variables
uo_ge473_comum io_Comum

String is_hora
Datetime idh_alteracao
String is_id_status
String is_nr_matricula
Long il_nr_pedido
long il_tabela = 72
String is_chave_sap

Boolean ib_execucao_simultanea = False
Integer ii_max_janelas = 3



end variables

forward prototypes
public function boolean of_valida_dados (ref string as_log)
private function boolean of_inicializa_variaveis (ref string as_log)
public subroutine of_processa_atualizacao ()
public function boolean of_carrega_chave (long al_controle, ref string as_chave_sap, ref string as_log)
public function boolean of_valida_usuario (ref string as_nr_matricula, ref string as_log)
public function boolean of_atualiza_pedido_alteracao (long al_controle, long al_tabela)
public function boolean of_atualiza_status (ref string as_log)
public function integer of_valida_controle_executando (ref integer pi_prox_controle)
end prototypes

public function boolean of_valida_dados (ref string as_log);long ll_existe

Try	

	if isnull(il_nr_pedido) or il_nr_pedido = 0 Then
		as_log = 'O n$$HEX1$$fa00$$ENDHEX$$mero do Pedido n$$HEX1$$e300$$ENDHEX$$o pode ser nulo.'
		return false
	end if	
		

	if isnull(is_id_status) or is_id_status = '' Then
		as_log = 'O Status n$$HEX1$$e300$$ENDHEX$$o pode ser nulo.'
		return false
	end if
	
	if Not of_valida_usuario(ref is_nr_matricula, ref as_log) Then return false
	
	Select count(*)
		into :ll_existe
	From pedido_empurrado
	where nr_pedido_sap = :il_nr_pedido;
	
	if sqlca.sqlcode = -1 then
		as_log = 'Objeto: ' + this.classname() + '~nM$$HEX1$$e900$$ENDHEX$$todo: of_valida_dados ~n' + 'Erro ao consultar a tabela "PEDIDO_EMPURRADO": ' + sqlca.sqlerrtext
		return false
	end if
	
	if ll_existe = 0 or isnull(ll_existe) Then
		as_log = 'O Pedido [' + string(il_nr_pedido) + '] n$$HEX1$$e300$$ENDHEX$$o p$$HEX1$$f400$$ENDHEX$$de ser encontrado.'
		return false
	end if
	
Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_valida_dados'. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True
end function

private function boolean of_inicializa_variaveis (ref string as_log);Try

	Setnull(is_hora)
	Setnull(is_id_status)
	Setnull(is_nr_matricula)
	Setnull(il_nr_pedido)
	Setnull(idh_alteracao)
	
Catch ( runtimeerror lo_rte )
	as_Log = "Ocorreu erro ao ao iniciar as vari$$HEX1$$e100$$ENDHEX$$veis. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True
end function

public subroutine of_processa_atualizacao ();Long ll_Linhas
Long ll_Linha, ll_nr_controle, ll_controles_gerando
integer li_prox_execucao
String ls_nome_janela

dc_uo_ds_base lds 

try
	
	lds  = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject('ds_ge473_lista_controles', False) Then 
		gvo_aplicacao.of_grava_log("Interface Pedido Altera$$HEX2$$e700e300$$ENDHEX$$o SAP - Erro alterar a DW [ds_ge473_lista_controles] - uo_ge473_pedido_alteracao_sap.of_processa_atualizacao" )
		Return
	End If
	
	ll_Linhas = lds.Retrieve(il_Tabela)
	
	If ll_Linhas > 0 Then
		For ll_Linha = 1 To ll_Linhas
										
			ll_nr_controle = lds.Object.nr_controle[ll_Linha]
				
			if ib_execucao_simultanea = True Then
	
				ll_nr_controle = lds.Object.nr_controle[ll_Linha]
				
				Do 
					
					ll_controles_gerando = of_valida_controle_Executando(ref li_prox_execucao)
					
				Loop While ll_controles_gerando >= ii_max_janelas
			
				ls_nome_janela = "Interface SAP - GE473[" + String(il_tabela) + "][" + String(li_prox_execucao) + "]"
			
				Run("C:\Sistemas\EX\Exe\ex.exe /AUTO/SAP/" + String(il_tabela) + "/" + string(ll_nr_controle) + "/" + ls_nome_janela )
	
			else							
										
				uo_ge473_pedido_alteracao_sap lo_pedido
				 
				Try
					lo_pedido = Create uo_ge473_pedido_alteracao_sap
					lo_pedido.of_atualiza_pedido_alteracao( ll_nr_controle , il_Tabela )
				Finally
					Destroy(lo_pedido)
				End Try
				
			End if
			
		Next
	ElseIf ll_Linhas < 0 Then
		gvo_aplicacao.of_grava_log("Interface Pedido Altera$$HEX2$$e700e300$$ENDHEX$$o SAP - Erro ao recuperar os da DW [ds_ge473_lista_controles] - uo_ge473_pedido_alteracao_sap.of_processa_atualizacao.")
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

public function boolean of_atualiza_pedido_alteracao (long al_controle, long al_tabela);dc_uo_ds_base lds
Long	ll_Linhas, &
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
		
		ll_linhas = lo_Comum.ids_lista_registros.RowCount()
		
		if isvalid(w_aguarde_3) Then
			w_aguarde_3.uo_progress_2.of_reset()
			w_aguarde_3.uo_progress_2.of_setmax(ll_linhas)
		end if
		
		For ll_Linha = 1 To ll_linhas
			
			this.of_inicializa_variaveis( ref ls_log )
		
			is_hora = lo_Comum.ids_lista_registros.object.de_hora[ll_linha]
			is_id_status = lo_Comum.ids_lista_registros.object.id_status[ll_linha]
			is_nr_matricula = lo_Comum.ids_lista_registros.object.nr_matricula[ll_linha]
			il_nr_pedido = Long(lo_Comum.ids_lista_registros.object.nr_pedido[ll_linha])
			
			If Not io_Comum.of_date_time(lo_Comum.ids_lista_registros.Object.dh_alteracao[ll_Linha], 'DATA DA ALTERACAO', ref idh_alteracao, ref ls_Log) Then 
				lb_sucesso = false
				Return False
			end if
			
			if isvalid(w_aguarde_3) Then
				w_aguarde_3.wf_settext('Pedido: ' + String(il_nr_pedido), 3 )
			end if
			
			If Not This.of_Valida_Dados(Ref ls_Log) Then
				lb_sucesso = false
				return false
			end if
		
			If Not This.of_atualiza_status( ref ls_log ) Then
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

public function boolean of_atualiza_status (ref string as_log);long ll_existe
string ls_log

Choose Case is_id_status
		
	Case 'X'
			
		Update pedido_empurrado
		set id_situacao = 'X', dh_cancelamento_sap = getdate()
		Where nr_pedido_sap = :il_nr_pedido;
		
		if sqlca.sqlcode = -1 then
			as_log = 'Objeto: ' + this.classname() + '~nM$$HEX1$$e900$$ENDHEX$$todo: of_insere_pedido_alteracao ~n' + 'Erro ao consultar a tabela "PEDIDO_EMPURRADO": ' + sqlca.sqlerrtext
			return false
		end if	
		
End Choose
						
return true
end function

public function integer of_valida_controle_executando (ref integer pi_prox_controle);String ls_Janela_Ativa 
long ll_controles_executando, ll_for

for ll_for = 1 to ii_max_janelas

	ls_janela_ativa = "Interface SAP - GE473[" + String(il_tabela) + "][" + String(ll_for) + ']'
	
	If gvo_aplicacao.of_appisrunning(ls_Janela_Ativa) Then
		ll_controles_executando++
	else
		pi_prox_controle = ll_for
	End If
	
Next

return ll_controles_executando
end function

on uo_ge473_pedido_alteracao_sap.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge473_pedido_alteracao_sap.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;io_Comum	= Create uo_ge473_comum


end event

event destructor;Destroy(io_Comum)

end event

