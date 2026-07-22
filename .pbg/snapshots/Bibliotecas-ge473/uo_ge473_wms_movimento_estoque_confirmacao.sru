HA$PBExportHeader$uo_ge473_wms_movimento_estoque_confirmacao.sru
forward
global type uo_ge473_wms_movimento_estoque_confirmacao from nonvisualobject
end type
end forward

global type uo_ge473_wms_movimento_estoque_confirmacao from nonvisualobject
end type
global uo_ge473_wms_movimento_estoque_confirmacao uo_ge473_wms_movimento_estoque_confirmacao

type variables
String is_de_chave_acesso_sap

long il_ano_documento
datetime idt_dt_documento
string is_log_criacao_doc
string is_nr_documento
string is_nr_solicitacao

Long il_Tabela = 104
Long il_nr_requisicao

boolean ib_execucao_simultanea=false
		
end variables

forward prototypes
private function boolean of_inicializa_variaveis (ref string as_log)
public function boolean of_valida_dados (string as_log)
public subroutine of_processa_atualizacao ()
public function boolean of_atualiza_confirmacao_mov_estoque (long al_controle, long al_tabela)
public function boolean of_atualiza_log_exportacao_sap (ref string as_log)
end prototypes

private function boolean of_inicializa_variaveis (ref string as_log);Try
			 
	SetNull(il_ano_documento)
	SetNull(idt_dt_documento)
	SetNull(is_log_criacao_doc)
	SetNull(is_nr_documento)
	SetNull(is_nr_solicitacao)

Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro ao iniciar as variaveis. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True
end function

public function boolean of_valida_dados (string as_log);Return True
end function

public subroutine of_processa_atualizacao ();Long ll_Linhas
Long ll_Linha, ll_nr_controle, ll_controles_gerando

dc_uo_ds_base lds 

try 
	
	lds  = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject('ds_ge473_lista_controles', False) Then 
		gvo_aplicacao.of_grava_log("Interface Movimento Estoque Confirma$$HEX2$$e700e300$$ENDHEX$$o - Erro alterar a DW [ds_ge473_lista_controles] - uo_ge473_wms_movimento_estoque_confirmacao.of_processa_atualizacao" )
		Return
	End If
	
	ll_Linhas = lds.Retrieve(il_Tabela)
	
	If ll_Linhas > 0 Then
		For ll_Linha = 1 To ll_Linhas
			
			if ib_execucao_simultanea = True Then
				//
			else
			
				uo_ge473_wms_movimento_estoque_confirmacao   lo_confirmacao
				 
				Try
					lo_confirmacao	= Create uo_ge473_wms_movimento_estoque_confirmacao
					lo_confirmacao.of_atualiza_confirmacao_mov_estoque( lds.Object.nr_controle[ll_Linha],this.il_tabela )
	
				Finally
					Destroy(lo_confirmacao)
				End Try			
			
			end if
			
		Next
	ElseIf ll_Linhas < 0 Then
		gvo_aplicacao.of_grava_log("Interface Movimento Estoque Confirma$$HEX2$$e700e300$$ENDHEX$$o - Erro ao recuperar os da DW [ds_ge473_lista_controles] - uo_ge473_wms_movimento_estoque_confirmacao.of_processa_atualizacao.")
	End If	
	
finally
	Destroy lds
end try
end subroutine

public function boolean of_atualiza_confirmacao_mov_estoque (long al_controle, long al_tabela);Boolean lb_Sucesso = False

Long ll_Atualizacao_Pend
Long ll_Linhas

String ls_Log
String ls_Chave_Controle

Try
		
	uo_ge473_comum lo_Comum
	lo_Comum = Create uo_ge473_comum
	
	Select de_chave_sap
	Into :is_de_chave_acesso_sap
	From interface_sap  i 
	Where i.cd_tabela = :il_Tabela
		and i.nr_controle = :al_controle
	Using SqlCa;	
	
	If SqlCa.sqlcode = -1 Then
		ls_Log = "Erro ao buscar o controle na tabela interface_sap. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle)+". Erro: "+SqlCa.sqlErrText
		Return False
	End If	
	
	If Not This.of_inicializa_variaveis(Ref ls_Log) Then Return False
	
	If Not lo_Comum.of_atualizacao_pendente(al_Controle, Ref ll_Atualizacao_Pend, Ref ls_Log) Then Return False
	
	//Controle j$$HEX1$$e100$$ENDHEX$$ foi processado
	If ll_Atualizacao_Pend = 0 Then Return True
	
	If Not lo_Comum.of_Muda_Situacao_Interface(al_Controle, Ref ls_Log) Then Return False
	If Not lo_Comum.of_localiza_chave_controle(al_Controle, Ref ls_Chave_Controle, Ref ls_Log) Then Return False
	
	If lo_Comum.of_processa_carrega_dados(al_controle , ref ls_Log) Then
		
		ll_Linhas = lo_Comum.ids_lista_registros.RowCount()
		
		if isvalid(w_aguarde_3) Then
			w_aguarde_3.uo_progress_2.of_reset()
			w_aguarde_3.uo_progress_2.of_setmax(ll_linhas)
		end if
		
		If ll_Linhas = 1 Then
			is_nr_documento		= gf_tira_zero_esquerda(lo_Comum.ids_lista_registros.Object.nr_documento[1])
			is_nr_solicitacao		= gf_tira_zero_esquerda(lo_Comum.ids_lista_registros.Object.nr_solicitacao[1])
			il_ano_documento 		= Long(lo_Comum.ids_lista_registros.Object.ano_documento[1])
			is_log_criacao_doc	= lo_Comum.ids_lista_registros.Object.log_criacao_doc[1]
			
			//De momento ignorar. Visto que nao esta sendo gravado
			//If Not lo_Comum.of_date_time(lo_Comum.ids_lista_registros.Object.dt_documento[1], 'DT_DOCUMENTO', ref  idt_dt_documento, ref ls_Log) Then Return False
			
			if isvalid(w_aguarde_3) Then
				w_aguarde_3.wf_settext('Solicita$$HEX2$$e700e300$$ENDHEX$$o: ' + is_nr_solicitacao , 3 )
			end if					
					
			If This.of_valida_dados( Ref ls_Log) Then
				If This.of_atualiza_log_exportacao_sap(Ref ls_Log ) Then
					lb_Sucesso	= True	
				End If
			End If
				
			if isvalid(w_aguarde_3) Then
				w_aguarde_3.uo_progress_2.of_setprogress(1)
			end if	
				
		Else
			ls_Log  = "Quantidade de registros recebido na interface esta diferente do esperado 1 para a tabela [interface_sap]. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle)+"."
			Return False
		End If
		
	End If

Catch ( runtimeerror  lo_rte )
	ls_Log = "Objeto [uo_ge473_wms_movimento_estoque_confirmacao], fun$$HEX2$$e700e300$$ENDHEX$$o [of_atualiza_confirmacao_mov_estoque]. Erro: "+lo_rte.GetMessage( )
	Return False		
	
Finally
		
	If lb_Sucesso Then
		SqlCa.of_Commit()
	Else
		SqlCA.of_RollBack()
		lo_Comum.of_grava_erro(al_controle, 179, ls_Log)
	End If
	
	Destroy lo_Comum	
	
End Try
	

Return True
end function

public function boolean of_atualiza_log_exportacao_sap (ref string as_log);Long		ll_nr_agrupamento_dev_compra, ll_nr_integracao
String	ls_tipo_integracao, ls_nr_exportacao, ls_cd_chave


ls_tipo_integracao	= '1'

select nr_integracao
  into :ll_nr_integracao
  from log_exportacao_sap l 
 inner join wms_int_sap w on l.cd_chave = cast(w.nr_integracao as varchar(20))
 where l.id_tipo_nf 				in ('WMM', 'WMA', 'WMI')
	 and l.id_status_integracao	= 'P'
	 and l.cd_tipo_documento 		in ('WMM', 'WMA', 'WMI')
	 and l.cd_chave_interface 		= :is_nr_solicitacao
 Using SqlCa;

if SqlCa.SqlCode = -1 then
	as_Log	= "Erro ao buscar registro na tabela 'log_exportacao_sap/wms_int_sap'. N$$HEX1$$fa00$$ENDHEX$$mero da solicita$$HEX2$$e700e300$$ENDHEX$$o [" + is_nr_solicitacao +"]. Erro: "+ SqlCa.SqlErrText
	Return False
end if

if SqlCa.SqlCode = 100 then
	select 
		cd_chave
	into
		:ls_cd_chave
	from   
		log_exportacao_sap l 
 	where l.id_tipo_nf 				in ('WMM')
	 and l.id_status_integracao	= 'P'
	 and l.cd_tipo_documento 		in ('WMM')
	 and l.cd_chave_interface 		= :is_nr_solicitacao;
	 
	if SqlCa.SqlCode = -1 then
		as_Log	= "Erro ao buscar registro na tabela 'log_exportacao_sap (WMM)'. N$$HEX1$$fa00$$ENDHEX$$mero da solicita$$HEX2$$e700e300$$ENDHEX$$o [" + is_nr_solicitacao +"]. Erro: "+ SqlCa.SqlErrText
		Return False
	end if

	if SqlCa.SqlCode = 100 then 
		select 
			nr_exportacao
		into
			:ls_nr_exportacao
		from 
			log_exportacao 
		where
			cd_tipo_exportacao = 4 
			and id_situacao_exportacao = 'P' 
			and cd_varchar3 = :is_nr_solicitacao;
			
		Choose Case SQLCA.SQLCode
			Case -1
				as_Log	= "Erro ao buscar registro na tabela 'log_exportacao'. N$$HEX1$$fa00$$ENDHEX$$mero da solicita$$HEX2$$e700e300$$ENDHEX$$o [" + is_nr_solicitacao +"]. Erro: "+ SqlCa.SqlErrText
				Return False
			Case 100
				as_Log	= "N$$HEX1$$e300$$ENDHEX$$o encontrado registro de envio para o n$$HEX1$$fa00$$ENDHEX$$mero da solicita$$HEX2$$e700e300$$ENDHEX$$o [" + is_nr_solicitacao +"]."
				Return False
			Case 0
				ls_tipo_integracao	= '2'
		End Choose
	end if
End if

//Sucesso
If Trim(is_nr_documento) <> '' And Not IsNull(is_nr_documento) Then
	if ls_tipo_integracao	= '1' then
		update log_exportacao_sap
			set nr_documento_sap 	= :is_nr_documento, 
				 cd_integer 			= :il_ano_documento, 
				 id_situacao_docto 	= 'P', 
				 de_erro 				= null
		 where id_status_integracao	= 'P'
			and (nr_documento_sap 		is null 
			 or id_situacao_docto 		in ('E', 'P'))
			and cd_chave_interface 		= :is_nr_solicitacao
		Using SqlCa;
			
		If SqlCa.SqlCode = -1 Then
			as_Log	= "Erro ao atualizar registro na tabela 'log_exportacao_sap'. N$$HEX1$$fa00$$ENDHEX$$mero da solicita$$HEX2$$e700e300$$ENDHEX$$o [" + is_nr_solicitacao +"]. Erro: "+ SqlCa.SqlErrText
			Return False
		End If
		
		If Sqlca.SQLNRows <> 1 Then
			// Aqui ser$$HEX1$$e100$$ENDHEX$$ zero ou maior que 1
			If Sqlca.SQLNRows = 0 Then
				as_Log	= "Nenhum registro foi atualizado na tabela 'log_exportacao_sap'. N$$HEX1$$fa00$$ENDHEX$$mero da solicita$$HEX2$$e700e300$$ENDHEX$$o [" + is_nr_solicitacao +"]."
			Else
				as_Log	= "Foram atualizados mais que 1 registro na tabela 'log_exportacao_sap'. N$$HEX1$$fa00$$ENDHEX$$mero da solicita$$HEX2$$e700e300$$ENDHEX$$o [" + is_nr_solicitacao +"]."
			End If
	
			Return False
		End If
			
		if ll_nr_integracao > 0 then
			update wms_int_sap
				set id_situacao	= 'P', 
					 dh_retorno_sap	= getdate()
			 where nr_integracao	= :ll_nr_integracao
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				as_Log	= "Erro ao atualizar registro na tabela 'wms_int_sap'. N$$HEX1$$fa00$$ENDHEX$$mero da solicita$$HEX2$$e700e300$$ENDHEX$$o [" + is_nr_solicitacao +"]. Erro: "+ SqlCa.SqlErrText
				Return False
			End If
		end if
	else
		update log_exportacao
		set id_situacao_retorno = 'P'
		where nr_exportacao = :ls_nr_exportacao;
		
		If SqlCa.SqlCode = -1 Then
			as_Log	= "Erro ao atualizar registro na tabela 'log_exportacao'. N$$HEX1$$fa00$$ENDHEX$$mero da exporta$$HEX2$$e700e300$$ENDHEX$$o [" + ls_nr_exportacao +"]. Erro: "+ SqlCa.SqlErrText
			Return False
		End If
	end if
Else
	if ls_tipo_integracao	= '1' then
		update log_exportacao_sap
			set id_situacao_docto 		= 'E', 
				 id_status_integracao	= 'E',
				 de_erro 					= :is_log_criacao_doc
		 where id_status_integracao 	in ('P', 'E')
			and nr_documento_sap 		is null
			and cd_chave_interface 		= :is_nr_solicitacao
		Using SqlCa;
			
		If SqlCa.SqlCode = -1 Then
			as_Log	= "Erro ao atualizar registro na tabela 'log_exportacao_sap'. N$$HEX1$$fa00$$ENDHEX$$mero da solicita$$HEX2$$e700e300$$ENDHEX$$o [" + is_nr_solicitacao +"]. Erro: "+ SqlCa.SqlErrText
			Return False
		End If
		
		If Sqlca.SQLNRows <> 1 Then
			// Aqui ser$$HEX1$$e100$$ENDHEX$$ zero ou maior que 1
			If Sqlca.SQLNRows = 0 Then
				as_Log	= "Nenhum registro foi atualizado na tabela 'log_exportacao_sap'. N$$HEX1$$fa00$$ENDHEX$$mero da solicita$$HEX2$$e700e300$$ENDHEX$$o [" + is_nr_solicitacao +"]."
			Else
				as_Log	= "Foram atualizados mais que 1 registro na tabela 'log_exportacao_sap'. N$$HEX1$$fa00$$ENDHEX$$mero da solicita$$HEX2$$e700e300$$ENDHEX$$o [" + is_nr_solicitacao +"]."
			End If
			Return False
		End If
		 
		if ll_nr_integracao > 0 then
			update wms_int_sap
				set id_situacao		= 'E',
					 dh_retorno_sap	= getdate(), 
					 de_erro 			= :is_log_criacao_doc
			 where nr_integracao	= :ll_nr_integracao
			Using SqlCa;
			
			If SqlCa.SqlCode =  -1 Then
				as_Log	= "Erro ao atualizar registro na tabela 'wms_int_sap'. N$$HEX1$$fa00$$ENDHEX$$mero da solicita$$HEX2$$e700e300$$ENDHEX$$o [" + is_nr_solicitacao +"]. Erro: "+ SqlCa.SqlErrText
				Return False
			End If
		end if
	else
		update log_exportacao
		set 
			id_situacao_retorno = 'E',
			id_situacao_exportacao = 'C',
			de_erro = :is_log_criacao_doc
		where nr_exportacao = :ls_nr_exportacao;
		
		If SqlCa.SqlCode = -1 Then
			as_Log	= "Erro ao atualizar registro na tabela 'log_exportacao'. N$$HEX1$$fa00$$ENDHEX$$mero da exporta$$HEX2$$e700e300$$ENDHEX$$o [" + ls_nr_exportacao +"]. Erro: "+ SqlCa.SqlErrText
			Return False
		End If
	end if
	
End If

Return True
end function

on uo_ge473_wms_movimento_estoque_confirmacao.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge473_wms_movimento_estoque_confirmacao.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

