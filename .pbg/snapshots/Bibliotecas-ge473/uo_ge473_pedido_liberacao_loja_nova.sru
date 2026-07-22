HA$PBExportHeader$uo_ge473_pedido_liberacao_loja_nova.sru
forward
global type uo_ge473_pedido_liberacao_loja_nova from nonvisualobject
end type
end forward

global type uo_ge473_pedido_liberacao_loja_nova from nonvisualobject
end type
global uo_ge473_pedido_liberacao_loja_nova uo_ge473_pedido_liberacao_loja_nova

type variables
Long il_Tabela  = 36 
end variables

forward prototypes
public function boolean of_atualiza_pedido_liberacao_loja_nova (longlong all_controle, long al_tabela)
public function boolean of_atualiza_parametro_loja (long al_filial, string as_parametro, datetime adt_data, ref string as_log)
public function boolean of_atualiza_bloqueio_filial (long al_filial, string as_valor, ref string as_log)
public subroutine of_processa_atualizacao ()
end prototypes

public function boolean of_atualiza_pedido_liberacao_loja_nova (longlong all_controle, long al_tabela);Boolean lb_Sucesso = False

DateTime ldh_Liberacao_Estoque_Central
DateTime ldh_Liberacao_Distribuidora

Long ll_Linhas
Long ll_Filial
Long ll_Atualizacao_Pend

String ls_Log

Try
	
	sleep(5)
	
	uo_ge473_comum lo_Comum
	lo_Comum = Create uo_ge473_comum
	
	If Not lo_Comum.of_atualizacao_pendente(all_controle, Ref ll_Atualizacao_Pend, Ref ls_Log) Then Return False
	
	//Controle j$$HEX1$$e100$$ENDHEX$$ foi processado
	If ll_Atualizacao_Pend = 0 Then Return True
	
	If Not lo_Comum.of_Muda_Situacao_Interface(all_Controle, Ref ls_Log) Then Return False
	
	If lo_Comum.of_processa_carrega_dados(all_controle, ref ls_Log) Then
		
		ll_linhas = lo_Comum.ids_lista_registros.RowCount()
		
		if isvalid(w_aguarde_3) Then
			w_aguarde_3.uo_progress_2.of_reset()
			w_aguarde_3.uo_progress_2.of_setmax(ll_linhas)
		end if
		
		If ll_Linhas = 1 Then
			
			If Not lo_Comum.of_Localiza_Codigo_Filial_Legado(lo_Comum.ids_lista_registros.Object.cd_filial_sap[1], Ref  ll_Filial, Ref ls_Log) Then Return False
			If Not lo_Comum.of_date_time( lo_Comum.ids_lista_registros.Object.dh_liberacao_estoque_central[1], 'DH_LIBERACAO_ESTOQUE_CENTRAL', ref ldh_Liberacao_Estoque_Central, ref ls_Log) Then Return False
			If Not lo_Comum.of_date_time( lo_Comum.ids_lista_registros.Object.dh_liberacao_distribuidora[1], 'DH_LIBERACAO_DISTRIBUIDORA', ref ldh_Liberacao_Distribuidora, ref ls_Log) Then Return False
					
			if isvalid(w_aguarde_3) Then
				w_aguarde_3.wf_settext('Filial: ' + String(ll_filial), 3 )
			end if		
					
			If Not This.of_atualiza_parametro_loja( ll_Filial, 'DT_INICIO_GERACAO_PEDIDO_ESTOQUE', ldh_Liberacao_Estoque_Central, ref ls_Log) Then Return False
			If Not This.of_atualiza_parametro_loja( ll_Filial, 'DT_INICIO_GERACAO_PEDIDO_DISTRIBUIDORAS', ldh_Liberacao_Distribuidora, ref ls_Log) Then Return False
			
			If Date(ldh_Liberacao_Estoque_Central) = Date('31/12/2099') and Date(ldh_Liberacao_Distribuidora) = Date('31/12/2099') Then
				Update filial
				Set id_pedido_centralizado = 'N'
				Where cd_filial = :ll_Filial
				Using SqlCa;
					
				If SqlCa.SqlCode = -1 Then
					ls_Log	= "Erro ao atualizar a libera$$HEX2$$e700e300$$ENDHEX$$o para gera$$HEX2$$e700e300$$ENDHEX$$o dos pedidos." +  " Erro: "+ SqlCa.SqlErrText
					Return False
				End If	
			Else
				Update filial
				Set id_pedido_centralizado = 'S'
				Where cd_filial = :ll_Filial
				Using SqlCa;
					
				If SqlCa.SqlCode = -1 Then
					ls_Log	= "Erro ao atualizar a libera$$HEX2$$e700e300$$ENDHEX$$o para gera$$HEX2$$e700e300$$ENDHEX$$o dos pedidos." +  " Erro: "+ SqlCa.SqlErrText
					Return False
				End If	
			End If
			
			If Not This.of_atualiza_bloqueio_filial(ll_Filial, lo_Comum.ids_lista_registros.Object.cd_tipo_bloqueio_controlado[1], Ref ls_Log) Then Return False
			
			lb_Sucesso = True
				
			if isvalid(w_aguarde_3) Then
				w_aguarde_3.uo_progress_2.of_setprogress(1)
			end if	
				
		Else
			ls_Log  = "Quantidade de registros recebido na interface esta diferente do esperado 1 para a tabela [interface_sap]. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(all_controle)+"."
			Return False
		End If
		
	End If
		
Finally

	If lb_Sucesso Then
		SqlCa.of_Commit()
	Else
		SqlCA.of_RollBack()
		lo_Comum.of_grava_erro(all_controle, 179, ls_Log)
	End If
	
	Destroy lo_Comum	

End Try

Return True
end function

public function boolean of_atualiza_parametro_loja (long al_filial, string as_parametro, datetime adt_data, ref string as_log);String ls_Valor_Parametro
String ls_Valor_Interface

Select vl_parametro
Into :ls_Valor_Parametro
From parametro_loja
Where cd_filial  = :al_Filial
	and cd_parametro = :as_parametro
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Log	= "Erro ao localizar o parametro '" + as_parametro + "' da filial '" + String(al_filial) + " Erro: "+ SqlCa.SqlErrText
	Return False
End If

ls_Valor_Interface = String( adt_data , "dd/mm/yyyy" )

If SqlCa.SqlCode = 0 Then
	If ls_Valor_Parametro <> ls_Valor_Interface Then
		Update parametro_loja
			set  vl_parametro = :ls_Valor_Interface
		Where   cd_filial		  = :al_Filial
			And  cd_parametro = :as_parametro
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			as_Log	= "Erro ao atualizar o parametro '" + as_parametro + "' da filial '" + String(al_filial) + " Erro: "+ SqlCa.SqlErrText
			Return False
		End If
		
		If Not gf_Grava_Historico_Alteracao_Tabela("PARAMETRO_LOJA",  String(al_Filial, '0000') + "@#!" + as_parametro  , "VL_PARAMETRO", ls_Valor_Parametro, ls_Valor_Interface, 'SAP001',  'A' , Ref as_log, True) Then Return False
	End If
Else
	Insert into parametro_loja ( cd_filial, cd_parametro, vl_parametro)
	Values ( :al_filial , :as_parametro ,:ls_Valor_Interface)
	Using SqlCA;
	
	If SqlCa.SqlCode = -1 Then
		as_Log	= "Erro ao incluir o parametro '" + as_parametro + "' da filial '" + String(al_filial) + " Erro: "+ SqlCa.SqlErrText
		Return False
	End If
	
	If Not gf_Grava_Historico_Alteracao_Tabela("PARAMETRO_LOJA",  String(al_Filial, '0000') + "@#!" + as_parametro  , "VL_PARAMETRO", '', ls_Valor_Interface, 'SAP001',  'I' , Ref as_log, True) Then Return False
End If

Return True
end function

public function boolean of_atualiza_bloqueio_filial (long al_filial, string as_valor, ref string as_log);String ls_Bloqueio_controlado
String ls_Valor_Atualizacao

If Isnull(as_valor) Then as_valor = ''

If as_valor <> '0' and as_valor <> '1' and as_valor <> '2' and  as_valor <> '3' Then
	as_Log = "O tipo de bloqueio deve ser 0, 1, 2 ou 3 - O valor informado est$$HEX1$$e100$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido."
	Return False
End If		  

Select coalesce(id_bloqueia_pedido_psico, '')
Into :ls_Bloqueio_controlado 
FROM filial
where cd_filial = :al_Filial
Using SqlCa;
	
If SqlCa.sqlcode = -1 Then
	as_Log	= "Erro ao recuperar o tipo de bloqueio de controlado'. Erro: "+SqlCa.sqlErrText
	SqlCa.of_RollBack();
	Return False
End If

If ls_Bloqueio_controlado <> as_valor Then
	
	If as_Valor =  '' Then
		SetNull(ls_Valor_Atualizacao)
	Else
		ls_Valor_Atualizacao = as_Valor
	End If
	
	Update filial
	Set id_bloqueia_pedido_psico = :ls_Valor_Atualizacao
	Where cd_filial = :al_Filial
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		as_Log	= "Erro ao atualizar o tipo de bloqueio de controlado da filial '" + String(al_filial) + "'. Erro: "+ SqlCa.SqlErrText
		SqlCa.of_RollBack();
		Return False
	End If
	
	If Not gf_Grava_Historico_Alteracao_Tabela("FILIAL",  String(al_Filial, '0000'), "ID_BLOQUEIA_PEDIDO_PSICO", ls_Bloqueio_controlado, as_Valor, 'SAP001',  'A' , Ref as_log, True) Then Return False
End If

Return True
end function

public subroutine of_processa_atualizacao ();Long ll_Linhas
Long ll_Linha

dc_uo_ds_base lds 

try 
	
	lds  = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject('ds_ge473_lista_controles', False) Then 
		gvo_aplicacao.of_grava_log("Interface Produto - Erro alterar a DW [ds_ge473_lista_controles] - uo_ge473_fornecedor_conexao.of_processa_atualizacao" )
		Return
	End If
	
	ll_Linhas = lds.Retrieve(il_Tabela)
	
	If ll_Linhas > 0 Then
		
		For ll_Linha = 1 To ll_Linhas		
								
			uo_ge473_pedido_liberacao_loja_nova  lo_pedido_liberacao_loja_nova
			 
			Try
				lo_pedido_liberacao_loja_nova	= Create uo_ge473_pedido_liberacao_loja_nova
				lo_pedido_liberacao_loja_nova.of_atualiza_pedido_liberacao_loja_nova(lds.Object.nr_controle[ll_Linha] ,  il_Tabela )
			Finally
				Destroy(uo_ge473_pedido_liberacao_loja_nova)
			End Try			
			
		Next
	ElseIf ll_Linhas < 0 Then
		gvo_aplicacao.of_grava_log("Interface FornecedorConexao - Erro ao recuperar os da DW [ds_ge473_lista_controles] - uo_ge473_fornecedor_conexao.of_processa_atualizacao.")
	End If	
	
finally
	Destroy lds
end try
end subroutine

on uo_ge473_pedido_liberacao_loja_nova.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge473_pedido_liberacao_loja_nova.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

